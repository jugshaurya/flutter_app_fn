import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/factoryDashboard/factoryDashboard_controller.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class FactoryDashboardScreen extends StatefulWidget {
  const FactoryDashboardScreen({Key? key}) : super(key: key);

  @override
  State<FactoryDashboardScreen> createState() => _FactoryDashboardScreenState();
}

class _FactoryDashboardScreenState extends State<FactoryDashboardScreen> {
  FactoryDashboardController controller = Get.find<FactoryDashboardController>();
  SharedPreferenceService preferenceService = Get.find<SharedPreferenceService>();
  RxInt _selectedIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    controller.getUserProfileDetails();
    controller.getDetailList();
  }


  @override
  Widget build(BuildContext context) {
    var argumemt = Get.arguments != null ? Get.arguments["pageState"]: "";
    if(argumemt == "reload"){
      controller.getUserProfileDetails();
      controller.getDetailList();
    }
    if(_selectedIndex.value == 0) {
      controller.getUserProfileDetails();
      controller.getDetailList();
    }
    if(controller.completedProfileSectionList.length > 0 && controller.completedProfileSectionList.length < 2 && argumemt != "reload" && argumemt != ""){
      Future.delayed(const Duration(seconds: 0)).then((value) {
        Get.offAndToNamed(AppRoute.factoryTimeline);
      });
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
                child: controller.completedProfileSectionList.isNotEmpty ? Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 0, bottom: 20, top: 5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Select your factory to start",
                          style: AppTextStyle.mediumBlack18
                              .copyWith(color: ColorConst.textBlack)),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Click on the factory card you want to manage",
                        style: AppTextStyle.normalBlack12
                            .copyWith(color: ColorConst.lightGreyColor),
                      ),
                    ],
                  ),
                )
                :
                Container(
                    margin: const EdgeInsets.only(
                        left: 0, right: 0, bottom: 20, top: 5.0),
                    padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                          Text("Looks like there is no factory",
                              style: AppTextStyle.mediumBlack18
                                  .copyWith(color: ColorConst.textBlack)),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Setup factory to begin",
                            style: AppTextStyle.normalBlack12
                                .copyWith(color: ColorConst.lightGreyColor),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: (){
                              Get.toNamed(AppRoute.profileRole2Screen);
                            },
                            child:Text(
                              "Setup factory",
                              style: AppTextStyle.w700Blue14
                                  .copyWith(color: ColorConst.blueColor),
                            ),
                          )

                        ]
                    )
                ),
              ),
              controller.completedProfileSectionList.isNotEmpty ?
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index){

                      return controller.completedProfileSectionListObj != null && controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id] != null ?
                      GestureDetector(
                        onTap: (){
                          preferenceService.setString(TextConst.factory_data, jsonEncode(controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id]));
                          Get.offAndToNamed(AppRoute.factoryPage);
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width*0.9,
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.fromLTRB(16, 10, 16, 0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                    image: AssetImage(ImageConst.factoryBgImage),
                                    fit:BoxFit.cover
                                ),
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
                                              Text("Category : ",
                                                  style: AppTextStyle.mediumBlack18
                                                      .copyWith(color: ColorConst.white)),
                                              Text((controller.completedProfileSectionList.isNotEmpty && controller.profileSubRolesList.isNotEmpty) ?
                                              (controller.profileSubRolesList.where((item)=>controller.profileSubRolesList.length > 0  &&
                                                  controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id] != null &&
                                                  controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id].length > 0 &&
                                                  controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0] != null &&
                                                  controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["roleCategoryId"] != null &&
                                                  item.id.toString()==(
                                                  controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["roleCategoryId"].toString() as String)).toList().length > 0 ?
                                              (controller.profileSubRolesList.where((item)=>controller.profileSubRolesList.length > 0  &&
                                                  controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id] != null &&
                                                  controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id].length > 0 &&
                                                  controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0] != null &&
                                                  controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["roleCategoryId"] != null &&
                                                  item.id.toString()==(
                                                      controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["roleCategoryId"].toString() as String)).toList()[0].name as String)
                                              : "Apparel")
                                                  : "Apparels",
                                                  style: AppTextStyle.mediumBlack18
                                                      .copyWith(color: ColorConst.white)
                                              )

                                            ],
                                          ),
                                          Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 30,),
                                                Text(
                                                    controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id].length > 2 &&
                                                    controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2] != null &&
                                                    controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"] != null &&
                                                    controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"]["20"] != null ?
                                                    (controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"]["20"]).length > 4 ? 
                                                    (controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"]["20"]).substring(0,4)+"..." :
                                                    (controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"]["20"]):
                                                    controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id].length > 1 &&
                                                        controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][1] != null &&
                                                        controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][1]["data"] != null &&
                                                    controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][1]["data"]["20"] != null ?
                                                    (controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][1]["data"]["20"]).length > 4 ?
                                                    (controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][1]["data"]["20"]).substring(0,4)+"..." :
                                                    (controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][1]["data"]["20"]):
                                                    controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id].length > 0 &&
                                                        controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0] != null &&
                                                        controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["data"] != null &&
                                                    controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["data"]["20"] != null ?
                                                    (controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["data"]["20"]).length > 4 ?
                                                    (controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["data"]["20"]).substring(0,4)+"..." :
                                                    (controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["data"]["20"]):
                                                    "Factory Name",
                                                    style: AppTextStyle.mediumTextBlack24
                                                        .copyWith(color: ColorConst.white)),
                                                SizedBox(height: 30,),
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text("Location", style: AppTextStyle.mediumBlack18
                                                                  .copyWith(color: ColorConst.white)),
                                                              SizedBox(width: 12,),
                                                              SvgPicture.asset(ImageConst.locationSvg,height: 16, width: 16, fit: BoxFit.cover)
                                                            ],
                                                          ),
                                                          SizedBox(height: 12,),
                                                          Text(
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id].length > 2 &&
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2] != null &&
                                                                  controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"] != null &&
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"]["11"] != null ?
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"]["11"].length > 10 ?
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"]["11"].substring(0,10)+"...":
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"]["11"] +"..."
                                                              :                                                              
                                                                  controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id].length > 1 &&
                                                                  controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][1] != null &&
                                                                  controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][1]["data"] != null &&
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][1]["data"]["11"] != null ?
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][1]["data"]["11"].length > 10 ?
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][1]["data"]["11"].substring(0,10)+"...":
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][1]["data"]["11"] +"..."
                                                                  :
                                                                  controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id].length > 0 &&
                                                                      controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0] != null &&
                                                                      controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["data"] != null &&
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["data"]["11"] != null ?
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["data"]["11"].length > 10 ?
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["data"]["11"].substring(0,10)+"...":
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["data"]["11"] +"..."
                                                                  :"Not Added" 
                                                              ,
                                                              style: AppTextStyle.mediumTextBlack20
                                                              .copyWith(color: ColorConst.white)),
                                                        ],
                                                      ),
                                                      SizedBox(width: 24,),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text("GSTIN", style: AppTextStyle.mediumBlack18
                                                                  .copyWith(color: ColorConst.white)),
                                                              SizedBox(width: 12,),
                                                              SvgPicture.asset(ImageConst.gstInSvg,height: 16, width: 16, fit: BoxFit.cover)


                                                            ],
                                                          ),
                                                          SizedBox(height: 12,),
                                                          Text(
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id].length > 2 &&
                                                                  controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2] != null &&
                                                                  controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"] != null &&
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"]["8"] != null ?
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"]["8"].length > 8 ?
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"]["8"].substring(0,8) + "..."??"":
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"]["8"]
                                                                  :
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id].length > 1 &&
                                                                  controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][1] != null &&
                                                                  controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][1]["data"] != null &&
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][1]["data"]["8"] != null ?                                                              
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][1]["data"]["8"].length > 8 ?
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][1]["data"]["8"].substring(0,8) + "..."??"":
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][1]["data"]["8"]
                                                              :
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id].length > 0 &&
                                                                  controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0] != null &&
                                                                  controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["data"] != null &&
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["data"]["8"] != null ? 
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["data"]["8"].length > 8 ?
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["data"]["8"].substring(0,8) + "..."??"":
                                                              controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["data"]["8"]: "Not Added",
                                                              style: AppTextStyle.mediumTextBlack20
                                                              .copyWith(color: ColorConst.white)),
                                                        ],
                                                      ),

                                                    ]
                                                ),
                                                SizedBox(height:24),
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children:[
                                                      Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                                width: MediaQuery.of(context).size.width*0.20,
                                                                padding: EdgeInsets.all(12),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(20),
                                                                  color: ColorConst.factoryBoxColor,
                                                                ),
                                                                child:Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                      Text(
                                                                           "Products",
                                                                          style: AppTextStyle.labellightWhite12
                                                                      ),
                                                                      SizedBox(height:2),
                                                                      Text((controller.productList.isNotEmpty ? controller.productList.length.toString(): "0" as String),
                                                                          style: AppTextStyle.boldWhite20
                                                                      ),
                                                                      SizedBox(height:2),
                                                                      Text(
                                                                          "In-Stock",
                                                                          style: AppTextStyle.labellightWhite12
                                                                      ),
                                                                    ]
                                                                )
                                                            ),

                                                          ]
                                                      ),
                                                      SizedBox(width:12),
                                                      Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                                width: MediaQuery.of(context).size.width*0.20,
                                                                padding: EdgeInsets.all(12),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(20),
                                                                  color: ColorConst.factoryBoxColor,
                                                                ),
                                                                child:Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: const [
                                                                      Text(
                                                                          "",
                                                                          style: AppTextStyle.labellightWhite12
                                                                      ),
                                                                      SizedBox(height:2),
                                                                      Text("",
                                                                          style: AppTextStyle.boldWhite20
                                                                      ),
                                                                      SizedBox(height:2),
                                                                      Text(
                                                                          "",
                                                                          style: AppTextStyle.labellightWhite12
                                                                      ),
                                                                    ]
                                                                )
                                                            ),

                                                          ]
                                                      ),
                                                      SizedBox(width:12),
                                                      Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                                width: MediaQuery.of(context).size.width*0.20,
                                                                padding: EdgeInsets.all(12),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(20),
                                                                  color: ColorConst.factoryBoxColor,
                                                                ),
                                                                child:Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: const [
                                                                      Text(
                                                                          "",
                                                                          style: AppTextStyle.labellightWhite12
                                                                      ),
                                                                      SizedBox(height:2),
                                                                      Text("",
                                                                          style: AppTextStyle.boldWhite20
                                                                      ),
                                                                      SizedBox(height:2),
                                                                      Text(
                                                                          "",
                                                                          style: AppTextStyle.labellightWhite12
                                                                      ),
                                                                    ]
                                                                )
                                                            ),
                                                          ]
                                                      ),
                                                      SizedBox(width: 12),
                                                      Center(
                                                        child: GestureDetector(
                                                            onTap: (){
                                                              preferenceService.setString(TextConst.factory_data, jsonEncode(controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id]));
                                                              if(controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id].length > 2){
                                                                preferenceService.setInt(TextConst.manufacturer_sub_role, controller.profileSubRolesList[index].id ?? 1);
                                                                Get.toNamed(AppRoute.factoryPage);
                                                              }
                                                              else{
                                                                preferenceService.setInt(TextConst.manufacturer_sub_role, controller.profileSubRolesList[index].id ?? 1);
                                                                Get.toNamed(AppRoute.factoryTimeline);
                                                              }
                                                            },
                                                            child:Container(
                                                              height: 48,
                                                              width: 48,
                                                              margin: EdgeInsets.fromLTRB(0,16 , 0, 32),
                                                              child: Center(
                                                                  child: SvgPicture.asset(ImageConst.arrowIcon, width: 8,)
                                                              ),
                                                              decoration: BoxDecoration(color: ColorConst.greyArrowBackground,
                                                                  borderRadius: BorderRadius.circular(99)),
                                                            )
                                                        ),
                                                      )


                                                    ]
                                                )
                                              ]
                                          ),



                                        ])
                                      ],
                                    ),

                                  ]),
                            ])
                        ),
                      ): null;
                    },
                  childCount: controller.completedProfileSectionListObj.value[3] != null && controller.completedProfileSectionListObj.value[3].length > 0 ? 3:
                  controller.completedProfileSectionListObj.value[2] != null && controller.completedProfileSectionListObj.value[2].length > 0 ? 2:
                  controller.completedProfileSectionListObj.value[1] != null && controller.completedProfileSectionListObj.value[1].length > 0 ? 1: 0
                )
              ): SliverToBoxAdapter(child: SizedBox()),

            SliverToBoxAdapter(
            child:GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoute.profileRole2Screen);
                },
                child:controller.completedProfileSectionList.isNotEmpty ?
                Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(24),
                      margin: EdgeInsets.fromLTRB(16, 10, 16, 40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorConst.factoryYellowColor,
                          boxShadow: [
                            const BoxShadow(
                                color: ColorConst.shadowGreyColor,
                                blurRadius: 20)
                          ]),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Container(
                             width:MediaQuery.of(context).size.width*0.65,
                             child:Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Container(
                                   child:Text(
                                       "Have a new factory?",
                                       style: AppTextStyle.boldBlack20
                                   )
                                 ),
                                 SizedBox(height: 10, width:MediaQuery.of(context).size.width*0.65),
                                 Container(
                                     child:Text(
                                         "Additional Information",
                                         style: AppTextStyle.labelGray12
                                     )
                                 )

                             ]
                           )
                           ),
                          Container(
                              child:Center(
                                child: GestureDetector(
                                    onTap: (){
                                      Get.toNamed(AppRoute.profileRole2Screen);
                                    },
                                    child:Container(
                                      height: 48,
                                      width: 48,
                                      margin: EdgeInsets.fromLTRB(8,0 , 0, 0),
                                      child: Center(
                                          child: SvgPicture.asset(ImageConst.whitePlusIcon, width: 8,height: 16,)
                                      ),
                                      decoration: BoxDecoration(color: ColorConst.redPrimary,
                                          borderRadius: BorderRadius.circular(99)),
                                    )
                                ),
                              )
                          ),
                        ]
                      )
                    ): SizedBox()
              )
               )

            ]))));
  }
}
