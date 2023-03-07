import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/factoryos/profileRole/profile_role_controller.dart';
import 'package:fs_app/factoryos/profileRole/widgets/RoleSectionWidget.dart';
import 'package:fs_app/factoryos/profileRole/widgets/RoleSubSectionWidget.dart';
import 'package:fs_app/factoryos/profileRole/widgets/RoleSuccessWidget.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../services/shared_preference_service.dart';
import '../../theme/text_style.dart';

class ProfileRolePage extends StatefulWidget {
  const ProfileRolePage({Key? key}) : super(key: key);

  @override
  State<ProfileRolePage> createState() => _ProfileRolePageState();
}

class _ProfileRolePageState extends State<ProfileRolePage> {
  ProfileRoleController controller = Get.find<ProfileRoleController>();
  PageController pageController = PageController(initialPage: 0);
  var currentIndex = 0.obs;
  SharedPreferenceService preferenceService =
  Get.find<SharedPreferenceService>();
  ConfettiController? _controller;



  @override
  void initState() {
    super.initState();
    _controller = new ConfettiController(
      duration: new Duration(seconds: 2),
    );
    if(_controller != null)
      _controller!.play();

    controller.getRolesData();
    controller.getUserProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: SafeArea(
          child: Scaffold(
            appBar: currentIndex.value > 1 ?
            AppBar(
              backgroundColor: ColorConst.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: ColorConst.black),
                onPressed: () => Get.toNamed(AppRoute.factoryTimeline),
              ),
              title: const Text(
                'Factory Setup',
                style: AppTextStyle.mediumBlack18,
              ),
              centerTitle: true,
              actions: <Widget>[
                InkWell(
                  onTap: () => Get.toNamed(AppRoute.factoryTimeline),
                  child: const Center(
                    child: Text(
                      'Cancel',
                      style: AppTextStyle.w700Blue16,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
              ],
            )
              :
            currentIndex.value == 0 ?
            AppBar(
              backgroundColor: ColorConst.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: ColorConst.black),
                onPressed: () => Get.toNamed(AppRoute.factoryTimeline),
              ),
              title: const Text(
                'Profile Setup',
                style: AppTextStyle.mediumBlack18,
              ),
              centerTitle: true,
              actions: <Widget>[
                // InkWell(
                //   onTap: () => Get.toNamed(AppRoute.factoryDashboard),
                //   child: const Center(
                //     child: Text(
                //       'Cancel',
                //       style: AppTextStyle.w700Blue16,
                //     ),
                //   ),
                // ),
                const SizedBox(
                  width: 12,
                ),
              ],
            ):
            AppBar(
              backgroundColor: ColorConst.white,
              elevation: 0,
            ),
            backgroundColor: ColorConst.white,
            body: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: _pageView,
            ),
          ),
        ),
      ),
    );
  }

  void onPageChanged(index) {
    currentIndex.value = index;
  }

  Widget get _pageView => PageView(
    controller: pageController,
    physics: const NeverScrollableScrollPhysics(),
    onPageChanged: (index) {
      currentIndex.value = index;
    },
    children: List<Widget>.generate(
        3, (index) {
         return (index == 0) ?
                 controller.profileRolesList.length > 0 ?
                 RoleSectionWidget(pageController: pageController,
                   currentIndex: currentIndex.value,controller: controller,onPageChanged: onPageChanged): Container()
         : (index == 1) ?
              RoleSuccessWidget(pageController: pageController,
                 currentIndex: currentIndex.value,controller: controller, onPageChanged: onPageChanged, confettiController: _controller,)
             :
             RoleSubSectionWidget(pageController: pageController,
               currentIndex: currentIndex.value,controller: controller, onPageChanged: onPageChanged)
         ;
      })
  );
}
