import 'package:flutter/material.dart';
import 'package:fs_app/constant/color_const.dart';

unselectedLabelStyle() {
  return TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);
}

selectedLabelStyle() {
  return const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);
}

class AppTextStyle {
  //normal text styles

  static const TextStyle normalBlack8 = TextStyle(
    color: Colors.black,
    fontSize: 8,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle normalBlack10 = TextStyle(
    color: Colors.black,
    fontSize: 10,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle normalBlack12 = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle bolderGrey500 = TextStyle(
      fontFamily: "Poppins",
      color: ColorConst.defaultGreyColor,
      fontSize: 10,
      fontWeight: FontWeight.w500);
  static const TextStyle splashBlack118 = TextStyle(
      fontFamily: "Alumni Sans",
      color: ColorConst.primary,
      fontSize: 118,
      fontWeight: FontWeight.w400
  );
  static const TextStyle splashRed118 = TextStyle(
      fontFamily: "Alumni Sans",
      color: ColorConst.primary,
      fontSize: 118,
      fontWeight: FontWeight.w400
  );

  static const TextStyle normalBlack14 = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle normalBlack16 = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle normalWhite10 = TextStyle(
    color: Colors.white,
    fontSize: 10,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle normalWhite12 = TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle normalWhite14 = TextStyle(
    color: Colors.white,
    fontSize: 13,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle boldWhite32 = TextStyle(
    color: Colors.white,
    fontSize: 32,
    fontWeight: FontWeight.w500,
  );



  static const TextStyle normalBlue10 = TextStyle(
    color: ColorConst.blue,
    fontSize: 10,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle normalBlue14 = TextStyle(
    color: ColorConst.blue,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle normalBlue16 = TextStyle(
    color: ColorConst.blue,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  //semi bold text styles
  static const TextStyle mediumBlack14 = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle mediumBlueLabel14 = TextStyle(
    color: ColorConst.blueDropLabel,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );


  static const TextStyle mediumRedLabel14 = TextStyle(
    color: ColorConst.redDropLabel,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle mediumBlack15 = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle mediumBlack16 = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle mediumBlack10 = TextStyle(
    color: Colors.black,
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle mediumBlack11 = TextStyle(
    color: Colors.black,
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle mediumBlack12 = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle mediumBlack20 = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle mediumWhite10 = TextStyle(
    color: Colors.white,
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle mediumBlue10 = TextStyle(
    color: ColorConst.blue,
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle mediumBlue12 = TextStyle(
    color: ColorConst.blue,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle mediumBlue14 = TextStyle(
    color: ColorConst.blue,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle mediumBlue16 = TextStyle(
    color: ColorConst.blue,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  //semi bold text styles
  static const TextStyle mediumWhite14 = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle mediumWhite16 = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  // bold text styles
  static const TextStyle boldBlack10 = TextStyle(
    color: Colors.black,
    fontSize: 10,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle boldBlack12 = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle boldWhite12 = TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle boldBlack14 = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle boldBlack24 = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle boldBlack16 = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle boldBlack20 = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle boldWhite16 = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle boldWhite18 = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle boldWhite20 = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle boldWhite28 = TextStyle(
    color: Colors.white,
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle w700LightGrey36 = TextStyle(
    color: ColorConst.lightGrey,
    fontSize: 36,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle w700Blue16 = TextStyle(
    color: ColorConst.blue,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle w700Blue14 = TextStyle(
    color: ColorConst.blue,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle normalBlackGrey10 = TextStyle(
    color: ColorConst.blackGrey,
    fontSize: 10,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle normalBlackGrey12 = TextStyle(
    color: ColorConst.blackGrey,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle normalhintGrey12 = TextStyle(
    color: ColorConst.hintColor,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle normalhintGrey14 = TextStyle(
    color: ColorConst.hintColor,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle normalBlackGrey14 = TextStyle(
    color: ColorConst.blackGrey,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle normalBlackGrey16 = TextStyle(
    color: ColorConst.blackGrey,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle boldBlackGrey18 = TextStyle(
    color: ColorConst.blackGrey,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle boldBlack18 = TextStyle(
    color: ColorConst.textBlack,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle w700bluePrimary16 = TextStyle(
    color: ColorConst.bluePrimary,
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );


  static const TextStyle mediumBlack24 = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle w700textBlack24 = TextStyle(
    color: ColorConst.textBlack,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle w400textBlack18 = TextStyle(
    color: ColorConst.textBlack,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle w500textBlack18 = TextStyle(
    color: ColorConst.textBlack,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle w700textBlack18 = TextStyle(
    color: ColorConst.textBlack,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle boldLightGrey24 = TextStyle(
    color: ColorConst.lightGrey,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle boldDarkBlack24 = TextStyle(
    color: ColorConst.black,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle boldDarkBlack36 = TextStyle(
    color: ColorConst.black,
    fontSize: 36,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle normalblack16 = TextStyle(
    color: ColorConst.textBlack,
    fontSize: 16,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle normalBlack18 = TextStyle(
    color: ColorConst.textBlack,
    fontSize: 18,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle boldBlue16 = TextStyle(
    color: ColorConst.blueSecondary,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle w700labelGray12 = TextStyle(
    color: ColorConst.greySecondary,
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle labelGray12 = TextStyle(
    color: ColorConst.greySecondary,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle labellightWhite12 = TextStyle(
    color: ColorConst.white,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle labelGray18 = TextStyle(
    color: ColorConst.greySecondary,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle labelLightGray10 = TextStyle(
    color: ColorConst.greySecondary,
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle labelGrayQuardernary24 = TextStyle(
    color: ColorConst.greyQurdernary,
    fontSize: 24,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle labelGray24 = TextStyle(
    color: ColorConst.greySecondary,
    fontSize: 24,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle labelWhite12 = TextStyle(
    color: ColorConst.white,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle labelGray20 = TextStyle(
    color: ColorConst.greySecondary,
    fontSize: 20,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle mediumBlack18 = TextStyle(
    color: ColorConst.textBlack,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle boldBlackPoppins16 = TextStyle(
    color: ColorConst.textBlack,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle lowBlackPoppins10 = TextStyle(
    color: ColorConst.textBlack,
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle mediumTextBlack20 = TextStyle(
    color: ColorConst.textBlack,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle mediumTextBlack24 = TextStyle(
    color: ColorConst.textBlack,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle semiMediumBlack12 = TextStyle(
    color: ColorConst.textBlack,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle semiMediumBlue18 = TextStyle(
    color: ColorConst.blueColor,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle w700labelGray24 = TextStyle(
    color: ColorConst.greyTertiary,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
}
