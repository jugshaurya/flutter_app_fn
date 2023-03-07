import 'package:flutter/material.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/theme/text_style.dart';

class FsButton extends StatefulWidget {
  final String text;
  final bool isDisabled;
  final double height;
  final double width;
  final Function() onSubmit;

  const FsButton({
    Key? key,
    required this.text,
    this.isDisabled = false,
    this.height = 50,
    this.width = double.infinity,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<FsButton> createState() => _FsButtonState();
}

class _FsButtonState extends State<FsButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: ElevatedButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            widget.onSubmit();
          },
          style: ElevatedButton.styleFrom(
            primary: widget.isDisabled
                ? ColorConst.buttonDisabledColor
                : ColorConst.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Text(widget.text,
              style: AppTextStyle.boldWhite18.copyWith(letterSpacing: 0.5)),
        ),
      ),
    );
  }
}
