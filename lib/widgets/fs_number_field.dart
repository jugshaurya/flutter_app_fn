import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/theme/text_style.dart';

class FsNumberField extends StatefulWidget {
  final String label;
  final String hint;
  final String text;
  final bool isManadatory;
  final ValueChanged<String> onChanged;

  const FsNumberField({
    Key? key,
    required this.label,
    required this.hint,
    required this.text,
    required this.onChanged,
    this.isManadatory = false,
  }) : super(key: key);

  @override
  _FsNumberFieldState createState() => _FsNumberFieldState();
}

class _FsNumberFieldState extends State<FsNumberField> {
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
  Widget build(BuildContext context) => Column(
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
            maxLength: 10,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              FilteringTextInputFormatter.digitsOnly
            ],
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
          ),
          const SizedBox(height: 20),
        ],
      );
}
