import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:fs_app/utils/log.dart';

class FsSwitch extends StatefulWidget {
  final String text;
  final bool isMandatory;
  final Function(dynamic v) onSwitchChange;

  const FsSwitch({Key? key, required this.text, required this.onSwitchChange, required this.isMandatory}) : super(key: key);

  @override
  State<FsSwitch> createState() => _FsSwitchState();
}

class _FsSwitchState extends State<FsSwitch> {
bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Text(widget.text, style: AppTextStyle.normalBlackGrey14,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
        children:[RichText(
          text: TextSpan(
            text: widget.text,
            style: AppTextStyle.normalBlackGrey14,
            children: [
              TextSpan(
                  text: widget.isMandatory ? ' *' : "",
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16))
            ],),
        )]
        ),
        /*Switch(
          value: isSwitch,
          onChanged: (value) {
            setState(() {
              isSwitch = value;
              widget.onSwitchChange(value);
            });
          },
          activeTrackColor: ColorConst.primary.withOpacity(0.2),
          activeColor: ColorConst.primary,
        ),*/

        Padding(
          padding: const EdgeInsets.only(left: 40.0,right: 145.0),
          child: FlutterSwitch(
            activeColor: ColorConst.primary,
            width: 60.0,
            height: 30.0,
            valueFontSize: 25.0,
            toggleSize: 30.0,
            value: isSwitch,
            borderRadius: 30.0,
            padding: 4.0,
            showOnOff: false,
            onToggle: (val) {
              setState(() {
                isSwitch = val;
                widget.onSwitchChange(val);
              });
            },
          ),
        ),
      ],
    );
  }
}
