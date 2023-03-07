import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/theme/text_style.dart';

class FsSimpleTextField extends StatefulWidget {
  final String label;
  final String hint;
  final String text;
  final bool isManadatory;
  final bool isEnabled;

  final ValueChanged<String> onChanged;

  const FsSimpleTextField({
    Key? key,
    required this.label,
    required this.text,
    this.isManadatory = false,
    required this.onChanged,
    required this.hint,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  State<FsSimpleTextField> createState() => _FsSimpleTextFieldState();
}

class _FsSimpleTextFieldState extends State<FsSimpleTextField> {
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
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: RichText(
              text: TextSpan(
                text: widget.label,
                style: AppTextStyle.normalBlackGrey16,
                children: [
                  TextSpan(
                      text: widget.isManadatory ? ' *' : "",
                      style: const TextStyle(color: Colors.red, fontSize: 16))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: TextFormField(
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
              enabled: widget.isEnabled,
              decoration: InputDecoration(
                hintText: widget.isEnabled ? widget.hint : "",
                hintStyle: AppTextStyle.normalBlackGrey16.copyWith(color:const Color(0XFF979797)),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorConst.lightGrey)),
                disabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorConst.lightGrey)),
              ),
              onChanged: (text) {
                widget.onChanged(text);
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      );
}
