import 'package:flutter/material.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_response.dart';
import 'package:fs_app/factoryos/profile/profile_controller.dart';
import 'package:fs_app/factoryos/profile/widget/profile_widget.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var currentIndex = 0.obs;
  SharedPreferenceService preferenceService =
      Get.find<SharedPreferenceService>();
  ProfileController controller = Get.find<ProfileController>();
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    currentIndex.value = preferenceService
            .getInt(TextConst.manufactureProfileCompletionStateIndex) ??
        0;
    controller.getProfileSection();
    controller.getInitProfileSections();
  }

  @override
  Widget build(BuildContext context) {
    currentIndex.value = preferenceService
        .getInt(TextConst.manufactureProfileCompletionStateIndex) ??
        0;
    controller.getProfileSection();
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: ColorConst.backgroundColor,
            body: Container(
              child: _pageView,
              /*Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(child: _pageView),
                  const SizedBox(height: 20,)
                ],
              ),*/
            ),
          ),
        ),
      ),
    );
  }

  Widget get _pageView => Obx(
        () => PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            currentIndex.value = index;
          },
          children: List<Widget>.generate(
            controller.profileSectionList.length,
            (index) {
              return ProfileWidget(
                  profileSections: _getProfileSection()!,
                  pageController: pageController,
                  currentIndex: preferenceService.getInt(
                          TextConst.activeProfileSection) ??
                      0,
                  profileSectionList: controller.profileSectionList,
                  sliderCount: controller.profileSectionList.length );
            },
          ),
        ),
      );

  ProfileSections? _getProfileSection() {
    int activeSectionId = preferenceService.getInt(TextConst.activeProfileSection) ?? 0;
    int index = controller.profileSectionList
        .indexWhere((profileSection) => profileSection!.id == activeSectionId);
    if (index < 0) {
      index = 0;
    }
    return controller.profileSectionList[index];
  }
}
