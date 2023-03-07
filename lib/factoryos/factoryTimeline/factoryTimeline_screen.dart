import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/dashboard/widgets/profile_timeline.dart';
import 'package:fs_app/factoryos/factoryDashboard/factoryDashboard_controller.dart';
import 'package:fs_app/factoryos/factoryTimeline/factoryTimeline_controller.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class FactoryTimelineScreen extends StatefulWidget {
  const FactoryTimelineScreen({Key? key}) : super(key: key);

  @override
  State<FactoryTimelineScreen> createState() => _FactoryTimelineScreenState();
}

class _FactoryTimelineScreenState extends State<FactoryTimelineScreen> {
  FactoryTimelineController controller = Get.find<FactoryTimelineController>();
  SharedPreferenceService preferenceService = Get.find<SharedPreferenceService>();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controller.getUserProfileDetails();
    controller.getDetailList();
  }


  @override
  Widget build(BuildContext context) {
    var argumemt = Get.arguments != null ? Get.arguments["pageState"]: "";
    // if(argumemt == "reload"){
    //   controller.getUserProfileDetails();
    //   controller.getDetailList();
    // }

    return Obx(() => LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
            backgroundColor: ColorConst.white,
            appBar: PreferredSize(
              preferredSize: const Size(0, 80),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: AppBar(
                  toolbarHeight: 90,
                  backgroundColor: ColorConst.white,
                  shadowColor: ColorConst.white,
                  elevation: 0,
                  titleTextStyle: AppTextStyle.boldBlack16,
                  title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textBaseline: TextBaseline.alphabetic,
                      textDirection: TextDirection.ltr,
                      children: [
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            text: preferenceService.getString(TextConst.full_name) == "" ? "User" : preferenceService.getString(TextConst.full_name),
                            style: AppTextStyle.mediumBlack18
                                .copyWith(color: ColorConst.textBlack),
                          ),
                        ),
                        const SizedBox(height: 4),
                        RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              text: "Welcome to FOS!   ",
                              style: AppTextStyle.labelGray12.copyWith(
                                  color: ColorConst.blackSubLabelColor),
                            ))
                      ]),
                  leading: Container(
                    width: 48,
                    height: 48,
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image:AssetImage(ImageConst.manProfileIcon),
                          fit: BoxFit.contain
                      ),
                    ),
                  ),
                  actions: [
                    GestureDetector(
                        onTap: (){
                          preferenceService.clearData();
                          Get.offAndToNamed(AppRoute.login);
                        },
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(14, 14, 10, 14),
                            child: RichText(
                                textAlign: TextAlign.start,
                                text: const TextSpan(
                                  text: "Logout",
                                  style: AppTextStyle.w700Blue16,
                                )
                            )
                        )
                    )
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: SvgPicture.asset(
                    //       "assets/icons/svgs/notification.svg"),
                    // ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: SvgPicture.asset("assets/icons/svgs/chat.svg"),
                    // ),
                  ],
                ),
              ),
            ),
            body: CustomScrollView(slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 0, bottom: 20, top: 5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Complete your factory setup",
                          style: AppTextStyle.mediumBlack18
                              .copyWith(color: ColorConst.textBlack)),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Click on the highlighted step to continue",
                        style: AppTextStyle.normalBlack12
                            .copyWith(color: ColorConst.lightGreyColor),
                      ),
                    ],
                  ),
                ),
              ),
               SliverToBoxAdapter(child: GestureDetector(
                 child: Container(
                     width: MediaQuery.of(context).size.width*0.9,
                     padding: EdgeInsets.all(20),
                     margin: EdgeInsets.fromLTRB(16, 10, 16, 0),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                         color: ColorConst.factoryBgColor,
                         boxShadow: const [
                           BoxShadow(
                               color: ColorConst.shadowGreyColor,
                               blurRadius: 20)
                         ]),
                     child: Row(children: [
                       Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Row(
                               children: [
                                 Stack(children: [
                                   Row(
                                     children: [
                                       Container(
                                              decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: ColorConst.factoryBgColor,
                                             ),
                                               child: Column(
                                                 children: List<Widget>.generate(
                                                     controller.detailList.length, (index) {
                                                   return ProfileTimeline(
                                                       controller.detailList[index]);
                                                 }),
                                               ),
                                             )
                                     ],
                                   ),

                                 ])
                               ],
                             ),

                           ]),
                     ])
                 ),
               )),


            ]))));
  }
}
