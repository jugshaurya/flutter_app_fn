import 'package:flutter/material.dart';
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/dashboard/dashboard_controller.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardController controller = Get.find<DashboardController>();
  SharedPreferenceService preferenceService = Get.find<SharedPreferenceService>();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controller.getUserProfileDetails();
    controller.getDetailList();
  }

  int getActiveSectionId() {
    int? activeSectionId = 0;
    if (controller.profileSectionList.isNotEmpty) {
      controller.profileSectionList.asMap().forEach((index, profileSection) {
        if (controller.completedProfileSectionList.isNotEmpty &&
            profileSection!.id ==
                controller
                    .completedProfileSectionList[
                        controller.completedProfileSectionList.length - 1]
                    .profileSectionId) {
          if (controller.profileSectionList[index + 1] != null) {
            activeSectionId = (preferenceService.getInt(TextConst.activeProfileSectionProfile) ?? 0) != 0  ?
            preferenceService.getInt(TextConst.activeProfileSectionProfile) : controller.profileSectionList[index + 1]!.id;
            preferenceService.setInt(TextConst.activeProfileSectionProfile, 0);
          }
        }
      });
    }
    return activeSectionId ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    var argumemt = Get.arguments != null ? Get.arguments["pageState"]: "";
    if(argumemt == "reload"){
      controller.getUserProfileDetails();
      controller.getDetailList();
    }
    Future.delayed(const Duration(seconds:1)).then((value) {
      SharedPreferenceService preferenceService =
      Get.find<SharedPreferenceService>();
      // if (preferenceService.getAuthToken() != null &&
      //     (preferenceService.getAuthToken()?.isNotEmpty ?? false)) {
      //    Get.offAndToNamed(AppRoute.profileRoleScreen);
      // } else {
      preferenceService.setInt(
          TextConst.manufactureProfileCompletionStateIndex,
          controller.detailList[0].currentSectionIndex);
      preferenceService.setInt(
          TextConst.activeProfileSection,
          controller.detailList[0].activeSectionId);
      Get.offAndToNamed(controller.detailList[0].action);
      // }
    });

    return LoadingOverlay(
            isLoading: controller.isLoading.value,
            child: Scaffold()
    );
    // return Obx(() => LoadingOverlay(
    //     isLoading: controller.isLoading.value,
    //     child: Scaffold(
    //         backgroundColor: ColorConst.white,
    //         appBar: PreferredSize(
    //           preferredSize: const Size(0, 80),
    //           child: Padding(
    //             padding: const EdgeInsets.only(left: 16, right: 16),
    //             child: AppBar(
    //               toolbarHeight: 90,
    //               backgroundColor: ColorConst.white,
    //               shadowColor: ColorConst.white,
    //               elevation: 0,
    //               titleTextStyle: AppTextStyle.boldBlack16,
    //               title: Column(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   textBaseline: TextBaseline.alphabetic,
    //                   textDirection: TextDirection.ltr,
    //                   children: [
    //                     RichText(
    //                       textAlign: TextAlign.start,
    //                       text: TextSpan(
    //                         text: controller.userProfileResponse != null &&
    //                                 controller.userProfileResponse!
    //                                         .userInfoModal !=
    //                                     null
    //                             ? controller.userProfileResponse!.userInfoModal!
    //                                 .fullName
    //                             : "",
    //                         style: AppTextStyle.mediumBlack18
    //                             .copyWith(color: ColorConst.textBlack),
    //                       ),
    //                     ),
    //                     const SizedBox(height: 4),
    //                     RichText(
    //                         textAlign: TextAlign.start,
    //                         text: TextSpan(
    //                           text: "Welcome to FOS!   ",
    //                           style: AppTextStyle.labelGray12.copyWith(
    //                               color: ColorConst.blackSubLabelColor),
    //                         ))
    //                   ]),
    //               leading: const Padding(
    //                 padding: EdgeInsets.all(4.0),
    //                 child: Image(
    //                   image: AssetImage(ImageConst.manProfileIcon),
    //                   width: 48,
    //                   height: 48,
    //                 ),
    //               ),
    //               actions: [
    //                 GestureDetector(
    //                   onTap: (){
    //                     preferenceService.clearData();
    //                     Get.offAndToNamed(AppRoute.login);
    //                   },
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(14.0),
    //                   child: RichText(
    //                     textAlign: TextAlign.start,
    //                     text: const TextSpan(
    //                       text: "Logout",
    //                       style: AppTextStyle.w700Blue16,
    //                     )
    //                 )
    //                 )
    //                 )
    //                 // IconButton(
    //                 //   onPressed: () {},
    //                 //   icon: SvgPicture.asset(
    //                 //       "assets/icons/svgs/notification.svg"),
    //                 // ),
    //                 // IconButton(
    //                 //   onPressed: () {},
    //                 //   icon: SvgPicture.asset("assets/icons/svgs/chat.svg"),
    //                 // ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         bottomNavigationBar: BottomNavigationBar(
    //           type: BottomNavigationBarType.fixed,
    //           showUnselectedLabels: true,
    //           showSelectedLabels: true,
    //           onTap: (index) {
    //             setState(() {
    //               _selectedIndex = index;
    //             });
    //             switch (index) {
    //               case 0:
    //                 Get.toNamed(AppRoute.dashboard);
    //                 break;
    //               case 1:
    //                 break;
    //               case 2:
    //                 break;
    //               case 3:
    //                 break;
    //               default:
    //             }
    //           },
    //           currentIndex: _selectedIndex,
    //           backgroundColor: Colors.white,
    //           unselectedItemColor: Colors.white.withOpacity(0.5),
    //           selectedItemColor: Colors.red,
    //           unselectedLabelStyle: unselectedLabelStyle(),
    //           selectedLabelStyle: selectedLabelStyle(),
    //           items: [
    //             BottomNavigationBarItem(
    //               icon: Container(
    //                 margin: const EdgeInsets.only(bottom: 0),
    //                 child: SvgPicture.asset("assets/icons/svgs/home.svg"),
    //               ),
    //               label: '',
    //             ),
    //             BottomNavigationBarItem(
    //               icon: Container(
    //                 margin: const EdgeInsets.only(bottom: 0),
    //                 child: SvgPicture.asset("assets/icons/svgs/document.svg"),
    //               ),
    //               label: '',
    //             ),
    //             BottomNavigationBarItem(
    //               icon: Container(
    //                 margin: const EdgeInsets.only(bottom: 0),
    //                 child: SvgPicture.asset("assets/icons/svgs/calendar.svg"),
    //               ),
    //               label: '',
    //             ),
    //             BottomNavigationBarItem(
    //               icon: Container(
    //                 margin: const EdgeInsets.only(bottom: 0),
    //                 child: SvgPicture.asset("assets/icons/svgs/navprofile.svg"),
    //               ),
    //               label: '',
    //             ),
    //           ],
    //         ),
    //         body: CustomScrollView(slivers: [
    //           SliverToBoxAdapter(
    //             child: Container(
    //               margin: const EdgeInsets.only(
    //                   left: 20, right: 20, bottom: 20, top: 5.0),
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   // SizedBox(
    //                   //   height: 48.0,
    //                   //   child: TextField(
    //                   //     style: AppTextStyle.normalBlack14
    //                   //         .copyWith(color: Colors.black),
    //                   //     decoration: InputDecoration(
    //                   //       border: InputBorder.none,
    //                   //       filled: true,
    //                   //       fillColor: ColorConst.greyInputField,
    //                   //       enabledBorder: OutlineInputBorder(
    //                   //         borderSide:
    //                   //             BorderSide(width: 3, color: ColorConst.white),
    //                   //         borderRadius: BorderRadius.circular(8.0),
    //                   //       ),
    //                   //       hintText: "Search for items, order, estimator",
    //                   //       hintStyle: AppTextStyle.normalBlack14
    //                   //           .copyWith(color: Colors.black.withOpacity(0.6)),
    //                   //       suffixIcon: IconButton(
    //                   //         onPressed: () => {},
    //                   //         icon: SvgPicture.asset(
    //                   //           "assets/icons/svgs/search.svg",
    //                   //           fit: BoxFit.contain,
    //                   //           height: 18,
    //                   //           width: 18,
    //                   //         ),
    //                   //       ),
    //                   //     ),
    //                   //   ),
    //                   // ),
    //                   //const SizedBox(height: 0),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           SliverToBoxAdapter(
    //               child: Container(
    //                   width: MediaQuery.of(context).size.width,
    //                   padding: EdgeInsets.all(16),
    //                   margin: EdgeInsets.fromLTRB(16, 50, 16, 0),
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(20),
    //                       color: ColorConst.white,
    //                       boxShadow: [
    //                         const BoxShadow(
    //                             color: ColorConst.shadowGreyColor,
    //                             blurRadius: 20)
    //                       ]),
    //                   child: Row(children: [
    //                     Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Text("Get Started with FactoryOS!",
    //                               style: AppTextStyle.mediumBlack18
    //                                   .copyWith(color: ColorConst.textBlack)),
    //                           const SizedBox(
    //                             height: 8,
    //                           ),
    //                           Text(
    //                             "Follow these steps to unlock all features",
    //                             style: AppTextStyle.normalBlack12
    //                                 .copyWith(color: ColorConst.lightGreyColor),
    //                           ),
    //                           const SizedBox(
    //                             height: 24,
    //                           ),
    //                           Row(
    //                             children: [
    //                               Stack(children: [
    //                                 Container(
    //                                   width: MediaQuery.of(context).size.width *
    //                                       0.82,
    //                                   decoration: BoxDecoration(
    //                                     borderRadius: BorderRadius.circular(10),
    //                                     gradient: const LinearGradient(
    //                                       colors: [
    //                                         ColorConst.greyProgressBar,
    //                                         ColorConst.greyProgressBar
    //                                       ],
    //                                       stops: [
    //                                         0.1,
    //                                         0.5,
    //                                       ],
    //                                     ),
    //                                   ),
    //                                   child: const SizedBox(
    //                                     height: 20.0,
    //                                   ),
    //                                 ),
    //                                 Container(
    //                                   width: MediaQuery.of(context).size.width *
    //                                       (controller.completionPercent.value),
    //                                   decoration: BoxDecoration(
    //                                     borderRadius: BorderRadius.circular(10),
    //                                     gradient: const LinearGradient(
    //                                       colors: [
    //                                         ColorConst.gradientEnd,
    //                                         ColorConst.gradientStart
    //                                       ],
    //                                       stops: [
    //                                         0.1,
    //                                         0.5,
    //                                       ],
    //                                     ),
    //                                   ),
    //                                   child: const SizedBox(
    //                                     height: 20.0,
    //                                   ),
    //                                 )
    //                               ])
    //                             ],
    //                           ),
    //                           const SizedBox(
    //                             height: 20,
    //                           ),
    //                           Container(
    //                             child: Column(
    //                               children: List<Widget>.generate(
    //                                   controller.detailList.length, (index) {
    //                                 return ProfileTimeline(
    //                                     controller.detailList[index]);
    //                               }),
    //                             ),
    //                           ),
    //                         ]),
    //                   ]))),
    //         ]))));
  }
}
