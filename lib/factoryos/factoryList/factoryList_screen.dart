import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/factoryDashboard/factoryDashboard_controller.dart';
import 'package:fs_app/factoryos/factoryList/factoryList_controller.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:fs_app/utils/log.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class FactoryListScreen extends StatefulWidget {
  const FactoryListScreen({Key? key}) : super(key: key);

  @override
  State<FactoryListScreen> createState() => _FactoryListScreenState();
}

class _FactoryListScreenState extends State<FactoryListScreen> {
  FactoryListController controller = Get.find<FactoryListController>();
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
    if(argumemt == "reload"){
      controller.getUserProfileDetails();
      controller.getDetailList();
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
                  backgroundColor: ColorConst.white,
                  elevation: 0,
                  leading: IconButton(
                      icon: const Icon(Icons.arrow_back, color: ColorConst.black),
                      onPressed: () => Get.until(
                            (route) => Get.currentRoute == AppRoute.dashboard,
                      ) //Get.back(),
                  ),
                  title: const Text(
                    'Factory List',
                    style: AppTextStyle.mediumBlack18,
                  ),
                  centerTitle: true,
                  actions: <Widget>[
                    InkWell(
                      onTap: (){
                        preferenceService.clearData();
                        Get.offAndToNamed(AppRoute.login);
                      },
                      child: const Center(
                        child: Text(
                          'Logout',
                          style: AppTextStyle.mediumBlue16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
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
                            Get.toNamed(AppRoute.factoryPage);
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
                                                    controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0] != null &&
                                                    controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["roleCategoryId"] != null &&
                                                    item.id.toString()==(
                                                        controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][0]["roleCategoryId"].toString() as String)).toList()[0].name as String)
                                                    : "Apparel",
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
                                                      controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2] != null &&
                                                          controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"] != null &&
                                                          controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"]["20"] != null ?
                                                      controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"]["20"].substring(0,10)+"..." : "Factory Name",
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
                                                                SvgPicture.asset(ImageConst.locationSvg,height: 16,)
                                                              ],
                                                            ),
                                                            SizedBox(height: 12,),
                                                            Text(
                                                                controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2] != null &&
                                                                    controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"] != null &&
                                                                    controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"]["11"] != null ?
                                                                controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"]["11"].substring(0,10)+"...":"Not Added",
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
                                                                SvgPicture.asset(ImageConst.gstInSvg,height: 16,)
                                                              ],
                                                            ),
                                                            SizedBox(height: 12,),
                                                            Text(
                                                                controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id] != null &&
                                                                    controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2] != null &&
                                                                    controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"] != null
                                                                    ?
                                                                controller.completedProfileSectionListObj[controller.profileSubRolesList[index].id][2]["data"]["8"]??"": "Not Added", style: AppTextStyle.mediumTextBlack20
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
                                                                        SizedBox(height:4),
                                                                        Text((controller.productList.isNotEmpty ? controller.productList.length.toString(): "0" as String),
                                                                            style: AppTextStyle.boldWhite32
                                                                        ),
                                                                        SizedBox(height:4),
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
                                                                        SizedBox(height:4),
                                                                        Text(
                                                                            "",
                                                                            style: AppTextStyle.boldWhite32
                                                                        ),
                                                                        SizedBox(height:4),
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
                                                                        SizedBox(height:4),
                                                                        Text(
                                                                            "",
                                                                            style: AppTextStyle.boldWhite32
                                                                        ),
                                                                        SizedBox(height:4),
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
                                                                Get.toNamed(AppRoute.factoryPage);
                                                              },
                                                              child:Container(
                                                                height: 48,
                                                                width: 48,
                                                                margin: EdgeInsets.fromLTRB(0,24 , 0, 24),
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
                      childCount: 2
                  )
              ): SliverToBoxAdapter(child: SizedBox()),

              SliverToBoxAdapter(
                  child:GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.profileRole2Screen);
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(24),
                        margin: EdgeInsets.fromLTRB(16, 10, 16, 20),
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
                              )
                            ]
                        )
                    ),
                  )
              )

            ]))));
  }
}
