import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:get/get.dart';

import '../../../constant/color_const.dart';
import '../../../constant/text_const.dart';

class ProfileSuccessScreen extends StatefulWidget {
  const ProfileSuccessScreen({Key? key}) : super(key: key);
  @override
  State<ProfileSuccessScreen> createState() => _ProfileSuccessScreenState();
}

class _ProfileSuccessScreenState extends State<ProfileSuccessScreen> with TickerProviderStateMixin{

  ConfettiController? confettiController;

  @override
  void initState() {
    super.initState();
    confettiController = new ConfettiController(
      duration: new Duration(seconds: 2),
    );
    if (confettiController != null)
      confettiController!.play();
  }

  Align buildConfettiWidget(controller, double blastDirection) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        blastDirectionality: BlastDirectionality.explosive,
        confettiController: confettiController,
        particleDrag: 0.05,
        emissionFrequency: 0.01,
        numberOfParticles: 10,
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
    var manufactureProfileCompletionStateIndex = preferenceService.getInt(TextConst.manufactureProfileCompletionStateIndex);
    int manufactureIndex =  manufactureProfileCompletionStateIndex ?? 1;
    Future.delayed(const Duration(seconds: 1)).then((value) {
      if(manufactureIndex < 3) {
        Get.offAndToNamed(AppRoute.profile);
      }
    });

    return manufactureIndex < 3 ? Scaffold()
    :
    SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body:Container(
            margin: EdgeInsets.all(16),
            child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
                    child: Column(
                      children: [
                        Stack(
                            children: <Widget>[
                              buildConfettiWidget(confettiController, pi/1),
                              const SizedBox(height: 60,),
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
                            ]
                        ),
                        const SizedBox(height: 100,),
                        SizedBox(
                          width: double.infinity,
                          child: Text('Congrats ${preferenceService.getString(TextConst.full_name) ?? ""}!',
                              textAlign: TextAlign.center,
                              style: AppTextStyle.boldBlack20),
                        ),
                        const SizedBox(height: 10,),
                        const SizedBox(
                          width: double.infinity,
                          child: Text("Factory set up successfully",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.mediumBlack16),
                        ),
                        const SizedBox(height: 5,),
                        const SizedBox(
                          width: double.infinity,
                          child: Text("Start factory operations in the next step",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.mediumBlack16),
                        ),
                      ],
                    ),
                  ),
                )
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: (){
              Get.offAndToNamed(AppRoute.factoryDashboard, arguments: {"pageState":"reload"});
            },
            child:Container(
              margin: EdgeInsets.all(16),
              alignment: Alignment.bottomCenter,
              height: 48,
              width:MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: ColorConst.disabledColor
                      .withOpacity(0.1),
                  offset: const Offset(4, 4),
                  blurRadius: 10,
                )
              ]),
              child: Material(
                color:ColorConst.primary,
                    borderRadius: BorderRadius.circular(5),
                child: InkWell(
                  onTap: () {
                    Get.offAndToNamed(AppRoute.factoryDashboard, arguments: {"pageState":"reload"});
                  },
                  child: const Center(
                    child: Text(
                      "Next ",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
      ),
    );


    // return SafeArea(
    //   child:Scaffold(
    //     body:Stack(
    //       children: [
    //         SizedBox(
    //             height: MediaQuery.of(context).size.height,
    //             width: MediaQuery.of(context).size.width,
    //             child:SvgPicture.asset(ImageConst.splashImage, fit: BoxFit.fill)
    //         ),
    //         Container(
    //             margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.18, MediaQuery.of(context).size.height * 0.4, 60, 0),
    //             child: Column(
    //               children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children:[
    //             Container(
    //               height: 40,
    //               width: 40,
    //               child: Center(
    //                   child: SvgPicture.asset(manufactureIndex >= 1 ? ImageConst.whiteTickSvg: ImageConst.redTickSvg, width: 22,height:22)
    //               ),
    //               decoration: BoxDecoration(color: manufactureIndex >= 1 ? ColorConst.redPrimary: ColorConst.greyTickBackground, borderRadius: BorderRadius.circular(99)),
    //             ),
    //                     SizedBox(width: 12,height: 12,),
    //                     Container(
    //                       height: 40,
    //                       width: 40,
    //                       child: Center(
    //                           child: SvgPicture.asset(manufactureIndex >= 2 ? ImageConst.whiteTickSvg: ImageConst.redTickSvg, width: 22,height:22)
    //                       ),
    //                       decoration: BoxDecoration(color: manufactureIndex >= 2 ? ColorConst.redPrimary: ColorConst.greyTickBackground, borderRadius: BorderRadius.circular(99)),
    //                     ),
    //                     SizedBox(width: 12,height: 12,),
    //                     Container(
    //                       height: 40,
    //                       width: 40,
    //                       child: Center(
    //                           child: SvgPicture.asset(manufactureIndex >= 3 ? ImageConst.whiteTickSvg: ImageConst.redTickSvg, width: 22,height:22)
    //                       ),
    //                       decoration: BoxDecoration(color: manufactureIndex >= 3 ? ColorConst.redPrimary: ColorConst.greyTickBackground, borderRadius: BorderRadius.circular(99)),
    //                     )
    //                   ]
    //                 ),
    //                 SizedBox(height: 24,),
    //                 Text(
    //                   manufactureIndex <= 1 ?
    //                   "Profile details have been saved successfully"
    //                   :
    //                   manufactureIndex <= 2 ?
    //                   "Company details have been saved successfully":
    //                   manufactureIndex <= 3 ?
    //                   "You are Good to go!":"",
    //                     style: AppTextStyle.boldBlack18,
    //                     textAlign: TextAlign.center,
    //                 )
    //               ]
    //             )
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}


