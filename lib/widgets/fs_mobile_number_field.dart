import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/theme/text_style.dart';

class FsMobileNumberField extends StatefulWidget {
  final String label;
  final String hint;
  final String text;
  final bool isManadatory;
  final ValueChanged<String> onChanged;

  const FsMobileNumberField({
    Key? key,
    required this.label,
    required this.hint,
    required this.text,
    required this.onChanged,
    this.isManadatory = false,
  }) : super(key: key);

  @override
  _FsMobileNumberFieldState createState() => _FsMobileNumberFieldState();
}

class _FsMobileNumberFieldState extends State<FsMobileNumberField> {
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          /*Text(
            widget.label,
            style: AppTextStyle.normalBlackGrey14,
          ),*/
          // const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            validator: (value) {
              if(value == null || value.isEmpty){
                if(widget.isManadatory) {
                  return widget.hint;
                }
              } else if(value.length != 10){
                return 'Enter valid mobile number';
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
                            fontSize: 4))
                  ],),
              ),
              isDense: true,
              counterText: "",
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
              floatingLabelBehavior: FloatingLabelBehavior.always,
              floatingLabelStyle:
              MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
              final Color color = states.contains(MaterialState.error)
              ? ColorConst.lightGrey
              : ColorConst.lightGrey;
              return TextStyle(color: color, letterSpacing: 1.3);
              }),
            ),
            onChanged: (text) {
              widget.onChanged(text);
            },
          ),
          const SizedBox(height: 20),
        ],
      );
}
