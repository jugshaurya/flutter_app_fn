import 'package:flutter/material.dart';
import 'package:fs_app/factoryos/onboarding/onboarding_controller.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'IntroView.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  PageController pageController = PageController(initialPage: 0);
  OnBoardingController controller = Get.find<OnBoardingController>();
  var currentShowIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: LoadingOverlay(
          isLoading: controller.isLoading.value,
          child: Column(
            children: [
              Flexible(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    currentShowIndex.value = index;
                  },
                  children: List<Widget>.generate(
                      controller.introPageList.length, (index) {
                    return IntroView(
                      introModel:
                          controller.introPageList[currentShowIndex.value],
                      introPageList: controller.introPageList,
                      currentShowIndex: currentShowIndex.value,
                      onPageChanged: (index) {
                        currentShowIndex.value = index;
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
