import 'package:flutter/material.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:fs_app/utils/log.dart';
import 'package:logger/logger.dart';

class FsTextField extends StatefulWidget {
  final String label;
  final String hint;
  final String text;
  final bool isManadatory;
  final TextInputType inputType;

  final ValueChanged<String> onChanged;

  const FsTextField({
    Key? key,
    required this.label,
    required this.text,
    this.isManadatory = false,
    required this.onChanged,
    required this.hint,
    required this.inputType
  }) : super(key: key);

  @override
  _FsTextFieldState createState() => _FsTextFieldState();
}

class _FsTextFieldState extends State<FsTextField> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    TextSelection previousSelection = controller.selection;
    controller.text = widget.text;
    controller.selection = previousSelection;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
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
            keyboardType: widget.inputType,
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
              TextSelection previousSelection = controller.selection;
              controller.text = text;
              controller.selection = previousSelection;
              widget.onChanged(text);
            },
          ),
          const SizedBox(height: 20),
        ],
      );
  }
}
