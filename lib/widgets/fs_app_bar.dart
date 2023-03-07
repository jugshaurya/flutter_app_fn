import 'package:flutter/material.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:get/get.dart';

class FSAppBar extends StatelessWidget with PreferredSizeWidget {
  String title;
  bool showActionText = false;
  bool refreshScreen = false;
  Function(dynamic v) callback;

  FSAppBar({
    Key? key,
    this.title = "",
    this.showActionText = false,
    this.refreshScreen = false,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            Get.back(result: refreshScreen);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: ColorConst.black,)),
      backgroundColor: ColorConst.white,
      title: Text(
        title,
        style: AppTextStyle.normalBlack18,
      ),
      actions: [
        showActionText
            ? Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap:(){ callback("");},
                  child: const Text(
                    'Cancel',
                    style: AppTextStyle.mediumBlue16,
                  ),
                ))
            : const SizedBox.shrink(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
