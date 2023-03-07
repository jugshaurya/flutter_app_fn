import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:get/get.dart';

class StackImageWidget extends StatefulWidget {
  final RxList<File> imageList;
  final Function addImage;
  final Function(dynamic v) updateImage;

  const StackImageWidget(
      {Key? key,
      required this.imageList,
      required this.addImage,
      required this.updateImage})
      : super(key: key);

  @override
  State<StackImageWidget> createState() => _StackImageWidgetState();
}

class _StackImageWidgetState extends State<StackImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10), // Image border
              child: widget.imageList.isEmpty
                  ? InkWell(
                      onTap: () => widget.addImage(),
                      child: Container(
                        width: 142,
                        height: 144,
                        alignment: Alignment.center,
                        color: const Color(0XFFD9D9D9),
                        child: SvgPicture.asset(
                          ImageConst.plusIcon,
                          color: ColorConst.white,
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () => widget.updateImage(0),
                      child: Stack(
                        // fit: StackFit.loose,
                        alignment: Alignment.topRight,
                        children: [
                          SizedBox(
                            width: 142,
                            height: 144,
                            child:  Image.file(
                              widget.imageList[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 20,
                            margin: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              shape: BoxShape.rectangle,
                              color: ColorConst.primary, //Color(0XFFD9D9D9),
                            ),
                            child: const Center(
                              child: Text(
                                'Main',
                                style: AppTextStyle.mediumWhite10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      // Image border
                      child: widget.imageList.length < 2
                          ? InkWell(
                              onTap: () => widget.addImage(),
                              child: Container(
                                width: 68,
                                height: 68,
                                alignment: Alignment.center,
                                color: const Color(0XFF848484),
                                child: SvgPicture.asset(
                                  ImageConst.plusIcon,
                                  color: ColorConst.white,
                                  height: 16,
                                  width: 16,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () => widget.updateImage(1),
                              child: SizedBox(
                                width: 68,
                                height: 68,
                                child: Image.file(
                                  widget.imageList[1],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      // Image border
                      child: widget.imageList.length < 3
                          ? InkWell(
                              onTap: () => widget.addImage(),
                              child: Container(
                                width: 68,
                                height: 68,
                                alignment: Alignment.center,
                                color: const Color(0XFF848484),
                                child: SvgPicture.asset(
                                  ImageConst.plusIcon,
                                  color: ColorConst.white,
                                  height: 16,
                                  width: 16,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () => widget.updateImage(2),
                              child: SizedBox(
                                width: 68,
                                height: 68,
                                child: Image.file(
                                  widget.imageList[2],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      // Image border
                      child: widget.imageList.length < 4
                          ? InkWell(
                              onTap: () => widget.addImage(),
                              child: Container(
                                width: 68,
                                height: 68,
                                alignment: Alignment.center,
                                color: const Color(0XFF848484),
                                child: SvgPicture.asset(
                                  ImageConst.plusIcon,
                                  color: ColorConst.white,
                                  height: 16,
                                  width: 16,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () => widget.updateImage(3),
                              child: SizedBox(
                                width: 68,
                                height: 68,
                                child: Image.file(
                                  widget.imageList[3],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      // Image border
                      child: widget.imageList.length < 5
                          ? InkWell(
                              onTap: () => widget.addImage(),
                              child: Container(
                                width: 68,
                                height: 68,
                                alignment: Alignment.center,
                                color: const Color(0XFF848484),
                                child: SvgPicture.asset(
                                  ImageConst.plusIcon,
                                  color: ColorConst.white,
                                  height: 16,
                                  width: 16,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () => widget.updateImage(4),
                              child: SizedBox(
                                width: 68,
                                height: 68,
                                child: Image.file(
                                  widget.imageList[4],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ],
            )
            /*Positioned(
              left: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: widget.imageList.length < 2
                    ? Container(
                        width: 128,
                        height: 88,
                        color: const Color(0XFF848484),
                      )
                    : SizedBox(
                        width: 128,
                        height: 88,
                        child: Image.file(
                          widget.imageList[1],
                          fit: BoxFit.cover,
                        ),
                      ), // Image border
              ),
            ),
            Positioned(
              left: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: widget.imageList.length < 3
                    ? SizedBox(
                        width: 128,
                        height: 88,
                        child: Image.asset(ImageConst.checkerImage),
                      )
                    // Container(
                    //         width: 128,
                    //         height: 88,
                    //         color: ColorConst.primary,
                    //       )
                    : SizedBox(
                        width: 128,
                        height: 88,
                        child: Image.file(
                          widget.imageList[2],
                          fit: BoxFit.cover,
                        ),
                      ), // Image border
              ), // Image border
            ),*/
          ],
        ),
      ),
    );
  }
}
