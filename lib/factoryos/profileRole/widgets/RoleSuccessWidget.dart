import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/profileRole/profile_role_controller.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:fs_app/utils/app_utils.dart';
import 'package:fs_app/widgets/fs_circular_button.dart';
import 'package:get/get.dart';
import '../../../constant/color_const.dart';


class RoleSuccessWidget extends  StatelessWidget {
  final PageController pageController;
  final int currentIndex;
  final ProfileRoleController controller;
  final Function onPageChanged;
  final ConfettiController? confettiController;

  const RoleSuccessWidget({Key? key,
    required this.pageController,
    required this.currentIndex,
    required this.controller,
    required this.onPageChanged,
    required this.confettiController})
      : super(key: key);




  Align buildConfettiWidget(controller, double blastDirection) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        blastDirectionality: BlastDirectionality.explosive,
        confettiController: confettiController,
        particleDrag: 0.05,
        emissionFrequency: 0.01,
        numberOfParticles: 50,
        gravity: 0.05,
        shouldLoop: false,
        colors: [
          Colors.green,
          Colors.red,
          Colors.yellow,
          Colors.blue,
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    SharedPreferenceService preferenceService =
    Get.find<SharedPreferenceService>();
    return SafeArea(
      child: Scaffold(

          backgroundColor: Theme.of(context).backgroundColor,
          body:SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 28),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
                          child: Column(
                            children: [
                              buildConfettiWidget(confettiController, pi/1),
                              const SizedBox(height: 10,),
                              Stack(
                                  children: <Widget>[
                                    Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                  child:Image.asset(ImageConst.splashSuccessGreenTick, fit: BoxFit.fill,
                                                  )
                                              )
                                            ]
                                        )
                                    )
                                  ]
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 100,),
                      SizedBox(
                        width: double.infinity,
                        child: Text('Congrats ${preferenceService.getString(TextConst.user_name) ?? ""}!',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.boldBlack20),
                      ),
                      const SizedBox(height: 10,),
                      const SizedBox(
                        width: double.infinity,
                        child: Text("Profile set up successfully",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.mediumBlack16),
                      ),
                      const SizedBox(height: 5,),
                      const SizedBox(
                        width: double.infinity,
                        child: Text("Setup your factory in the next step",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.mediumBlack14),
                      ),
                    ],
                  ),
                ),
              )
          ),
          bottomNavigationBar: GestureDetector(
              onTap: (){
                if(controller.roleSelect.value != 0) {
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 10),
                      curve: Curves.bounceIn);
                  onPageChanged(currentIndex);
                }
              },
              child:Container(
                width: 140,
                height: 140,
                child: FsCircularButton(
                  text: 'Save and Next',
                  progressValue: 0.05,
                  onSubmit: ()  {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 10),
                        curve: Curves.bounceIn);
                    onPageChanged(currentIndex);
                  },
                ),
              )
          )
      ),
    );
  }



}


