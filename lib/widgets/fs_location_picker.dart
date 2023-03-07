import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:fs_app/utils/log.dart';
import 'package:geolocator/geolocator.dart';

class FsLocationPicker extends StatefulWidget {
  final String label;
  final String hint;
  final String text;
  final bool isManadatory;
  final ValueChanged<String> onChanged;

  const FsLocationPicker({
    Key? key,
    required this.label,
    required this.hint,
    required this.text,
    required this.onChanged,
    this.isManadatory = false,
  }) : super(key: key);

  @override
  _FsLocationPickerState createState() => _FsLocationPickerState();
}

class _FsLocationPickerState extends State<FsLocationPicker> {
  late final TextEditingController controller;

  bool serviceStatus = false;
  bool hasPermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text:  widget.text);
    checkGps();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: widget.label,
              style: AppTextStyle.normalBlackGrey14,
              children: [
                TextSpan(
                    text: widget.isManadatory ? ' *' : "",
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16))
              ],),
          ),
          /*Text(
            widget.label,
            style: AppTextStyle.normalBlackGrey14,
          ),*/
          // const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                if(widget.isManadatory) {
                  return widget.hint;
                }
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            enabled: false,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTextStyle.normalBlackGrey12,
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorConst.lightGrey)),
              disabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorConst.lightGrey)),
            ),
            onChanged: (text) {
              widget.onChanged(text);
            },
          ),
          const SizedBox(height: 20),
        ],
      );

  checkGps() async {
    serviceStatus = await Geolocator.isLocationServiceEnabled();
    if (serviceStatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Log.logger.i('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          Log.logger.i("'Location permissions are permanently denied");
        } else {
          hasPermission = true;
        }
      } else {
        hasPermission = true;
      }

      if (hasPermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
      controller.text = "$long | $lat";
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
      controller.text = "$long | $lat";
    });

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        controller.text = "$long | $lat";
      });
    });
  }
}
