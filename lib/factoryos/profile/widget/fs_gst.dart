import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_attr_response.dart';
import 'package:fs_app/factoryos/profile/widget/fs_gst_controller.dart';
import 'package:fs_app/factoryos/profile/widget/profile_bottom_sheet_content.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:get/get.dart';

class FsGstPicker extends StatefulWidget {
  final String label;
  final String text;
  final String hint;
  final String fieldType;
  final bool isManadatory;

  final Function(dynamic v) onChanged;

  const FsGstPicker({
    Key? key,
    required this.label,
    required this.text,
    required this.hint,
    required this.fieldType,
    required this.isManadatory,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<FsGstPicker> createState() => _FsGstPicker();
}

class _FsGstPicker extends State<FsGstPicker> {
  GSTController gstController = Get.find<GSTController>();

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    _getGstFieldController(widget.fieldType)!.addListener(_printLatestValue);

  }

  void _printLatestValue() {
    print('Second text field: ${_getGstFieldController(widget.fieldType)!.text}');
    if(_getGstFieldController(widget.fieldType)!.text != "")
    widget.onChanged(_getGstFieldController(widget.fieldType)!.text);

  }

  @override
  Widget build(BuildContext context){
    _getGstFieldController(widget.fieldType)!.text = widget.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*Text(
            widget.label,
            style: AppTextStyle.normalBlackGrey14,
          ),*/
        // const SizedBox(height: 4),
        TextFormField(
            readOnly: widget.fieldType != "gst",
            controller: _getGstFieldController(widget.fieldType),
            validator: (value) {
              if (value == null || value.isEmpty) {
                if (widget.isManadatory) {
                  return widget.hint;
                }
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // enabled: widget.isManadatory,
            decoration: InputDecoration(
              label: RichText(
                text: TextSpan(
                  text: widget.label,
                  style: AppTextStyle.normalhintGrey14,
                  children: [
                    TextSpan(
                        text: widget.isManadatory ? ' *' : "",
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16))
                  ],),
              ),
              hintText: widget.hint,
              hintStyle: AppTextStyle.normalhintGrey12,
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConst.lightGrey)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConst.lightGrey)),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConst.lightGrey)),
              disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConst.lightGrey)),
              floatingLabelStyle:
              MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                final Color color = states.contains(MaterialState.error)
                    ? ColorConst.lightGrey
                    : ColorConst.lightGrey;
                return TextStyle(color: color, letterSpacing: 1.3);
              }),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            onChanged: (text) {
              widget.onChanged(text);
            },
            onEditingComplete: () {
              widget.onChanged(_getGstFieldController(widget.fieldType)!.value);
            }
        ),
        const SizedBox(height: 20),
      ],
    );
  }

    TextEditingController? _getGstFieldController(String value) {
      switch(value){
        case "gst":
          return gstController.gstController;
        case "gstCompanyName":
          return gstController.companyNameController;
        case "gstCompanyAddress":
          return gstController.companyAddressController;
      }
    }
  }


