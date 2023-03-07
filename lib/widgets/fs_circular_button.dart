import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/theme/text_style.dart';

class FsCircularButton extends StatefulWidget {
  final String text;
  final bool isDisabled;
  final double height;
  final double width;
  final Function() onSubmit;
  final double progressValue;
  const FsCircularButton({
    Key? key,
    required this.text,
    this.isDisabled = false,
    this.height = 50,
    this.width = double.infinity,
    required this.onSubmit,
    required this.progressValue
  }) : super(key: key);

  @override
  State<FsCircularButton> createState() => _FsCircularButtonState();
}

class _FsCircularButtonState extends State<FsCircularButton> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Stack(
        children: <Widget>[
      Center(
      child: Container(
        width: 60,
        height: 60,
        child: new CircularProgressIndicator(
          strokeWidth: 6,
          value: widget.progressValue,
        ),
      ),
      ),
      Center(
            child: Container(
            height: 58, // You can change here
            decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
            color: Colors.white,
              width: 2.0
        ),
        ),
        child: Center(
            child:  GestureDetector(
              onTap: () {
                widget.onSubmit();
              },
              child: ElevatedButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  widget.onSubmit();
                },
                style: ElevatedButton.styleFrom(
                  primary: widget.isDisabled
                      ? ColorConst.buttonDisabledColor
                      : ColorConst.primary,
                  shape: CircleBorder(),
                    padding: EdgeInsets.all(10),
                  ),
                child:Center(
                  child: GestureDetector(
                      onTap: (){
                        widget.onSubmit();
                      },
                      child:Container(
                        height: 42,
                        width: 42,
                        child: Center(
                            child: SvgPicture.asset(ImageConst.arrowIcon, width: 10,)
                        ),
                        decoration: BoxDecoration(color: ColorConst.redPrimary, borderRadius: BorderRadius.circular(99)),
                      )
                  ),
                ),
              )
          )
          ),
            )
        ),
      ]
      ),
    );

  }
}
