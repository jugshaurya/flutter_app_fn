import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:get/get.dart';
import '../../constant/img_const.dart';
import 'model/intro_model.dart';

class IntroView extends StatelessWidget {
  final IntroModel introModel;
  final int currentShowIndex;
  final List introPageList;
  final onPageChanged;
  


  const IntroView(
      {Key? key,
        required this.introModel,
        required this.introPageList,
        required this.currentShowIndex,
        required this.onPageChanged
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
            backgroundColor: ColorConst.splashBgColor,
          body:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height*0.5,
          width: MediaQuery.of(context).size.width,
          child:Image.asset(introModel.imageUrl!, fit: BoxFit.fill,
          )
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 40, top: 30, bottom:24),
          child: Text(
             introModel.heading!,
            style: AppTextStyle.w700textBlack24.copyWith(fontSize: 32,fontFamily: "DM Serif Display"),
          ),
        ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 0, bottom: 40),
            child: Text(
            introModel.description!,
                textAlign: TextAlign.left,
            style: AppTextStyle.normalblack16.copyWith(color: ColorConst.textBlack, fontWeight: FontWeight.w100, fontFamily: 'Quicksand')
        ),
          ),
      ],
    ),
          bottomNavigationBar: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child:Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20  ,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    introPageList.length,
                        (index) => buildDot(index, context),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width*0.63 ,),
                GestureDetector(
                    onTap: (){
                      Get.offAndToNamed(AppRoute.login);
                    },
                    child:const Text(
                        "Skip",
                        style: AppTextStyle.boldBlack18
                    )
                ),
                SizedBox(width: 20  ,)
              ]
          )
          )
          ,
    ),
    );
  }
  Container buildDot(int index, BuildContext context) {
    return currentShowIndex == 4 ?
    Container(height:0):
    Container(
      height: 10,
      width: 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: currentShowIndex == index ? ColorConst.black: ColorConst.greyShadow,
      ),
    );
  }
 }