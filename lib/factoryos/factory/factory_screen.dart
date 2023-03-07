import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/factory/factory_controller.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class FactoryScreen extends StatefulWidget {
  const FactoryScreen({Key? key}) : super(key: key);

  @override
  State<FactoryScreen> createState() => _FactoryScreenState();
}

class _FactoryScreenState extends State<FactoryScreen> {
  FactoryController controller = Get.find<FactoryController>();
  SharedPreferenceService preferenceService = Get.find<SharedPreferenceService>();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    dynamic factoryData = jsonDecode(preferenceService.getString(TextConst.factory_data) ?? "");
    if(factoryData.length <= 2){
      Get.toNamed(AppRoute.factoryTimeline);
    }
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
                          Get.toNamed(AppRoute.login);
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
            body:SingleChildScrollView(
              child:SizedBox(
                child:Container(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                   child: Column(
                     children: [
                       Row(
                         children:[
                           Container(
                             child:Text(factoryData.length > 2 && factoryData[2]["data"]["20"] != null  ?
                             factoryData[2]["data"]["20"].length > 10 ? factoryData[2]["data"]["20"].substring(0,10)+"...":
                             factoryData[2]["data"]["20"] : "Factory Name",
                                 style: AppTextStyle.mediumBlack18
                                     .copyWith(color: ColorConst.textBlack)),
                           ),
                           SizedBox(width: 20,),
                           GestureDetector(
                             onTap: (){
                               Get.toNamed(AppRoute.factoryList);
                             },
                             child: Container(
                               width: 10,
                               height: 10,
                               child:SvgPicture.asset(ImageConst.downArrow),
                             ),
                           )

                         ]
                       ),
                       SizedBox(height: 10,),
                       Row(
                         children: [
                           GestureDetector(
                             onTap:(){
                             Get.toNamed(AppRoute.inventory);
                             },
                           child:Container(
                               width: MediaQuery.of(context).size.width*0.43,
                               padding: EdgeInsets.all(24),
                               margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(20),
                                   color: ColorConst.shadowWhiteColor,
                                   boxShadow: const [
                                     BoxShadow(
                                         color: ColorConst.shadowWhiteColor,
                                         blurRadius: 20)
                                   ]),
                             child: Column(
                               children: [
                                    SvgPicture.asset(ImageConst.inventoryIcon),
                                    SizedBox(height: 16,),
                                    Text("Inventory", style: AppTextStyle.boldBlackPoppins16),
                                    SizedBox(height: 10,),
                                    Text("Check your inventory", style: AppTextStyle.lowBlackPoppins10)
                               ]
                             ),
                           )
                           ),
                           SizedBox(width: 20,),
                           Container(
                             width: MediaQuery.of(context).size.width*0.43,
                             padding: EdgeInsets.all(24),
                             margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20),
                                 color: ColorConst.shadowWhiteColor,
                                 boxShadow: const [
                                   BoxShadow(
                                       color: ColorConst.shadowWhiteColor,
                                       blurRadius: 20)
                                 ]),
                             child: Column(
                                 children: [
                                   SvgPicture.asset(ImageConst.orderIcon),
                                   SizedBox(height: 16,),
                                   Text("Orders", style: AppTextStyle.boldBlackPoppins16),
                                   SizedBox(height: 10,),
                                   Text("Lorem Ipsum", style: AppTextStyle.lowBlackPoppins10)
                                 ]
                             ),
                           )
                         ]
                       ),
                       SizedBox(height: 20,),
                       Row(
                           children: [
                             Container(
                               width: MediaQuery.of(context).size.width*0.43,
                               padding: EdgeInsets.all(24),
                               margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(20),
                                   color: ColorConst.shadowWhiteColor,
                                   boxShadow: const [
                                     BoxShadow(
                                         color: ColorConst.shadowWhiteColor,
                                         blurRadius: 20)
                                   ]),
                               child: Column(
                                   children: [
                                     SvgPicture.asset(ImageConst.inventoryIcon),
                                     SizedBox(height: 16,),
                                     Text("Vendors", style: AppTextStyle.boldBlackPoppins16),
                                     SizedBox(height: 10,),
                                     Text("Check your vendors", style: AppTextStyle.lowBlackPoppins10)
                                   ]
                               ),
                             ),
                             SizedBox(width: 20,),
                             Container(
                               width: MediaQuery.of(context).size.width*0.43,
                               padding: EdgeInsets.all(24),
                               margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(20),
                                   color: ColorConst.shadowWhiteColor,
                                   boxShadow: const [
                                     BoxShadow(
                                         color: ColorConst.shadowWhiteColor,
                                         blurRadius: 20)
                                   ]),
                               child: Column(
                                   children: [
                                     SvgPicture.asset(ImageConst.workflowIcon),
                                     SizedBox(height: 16,),
                                     Text("Workflow", style: AppTextStyle.boldBlackPoppins16),
                                     SizedBox(height: 10,),
                                     Text("Lorem Ipsum", style: AppTextStyle.lowBlackPoppins10)
                                   ]
                               ),
                             )
                           ]
                       )

                     ]
                   )
                )
              )
            ),
        )
    )
    );
  }
}
