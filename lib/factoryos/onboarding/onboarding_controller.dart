import 'package:fs_app/factoryos/onboarding/model/intro_model.dart';
import 'package:fs_app/factoryos/onboarding/onboarding_repo.dart';
import 'package:fs_app/factoryos/onboarding/model/intro_model_response.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
 OnBoardingRepository repository = Get.find<OnBoardingRepository>();

  RxBool isLoading = false.obs;
  RxList<IntroModel> introPageList = <IntroModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getOnboardingSection();
  }

  Future<void> getOnboardingSection() async {
    isLoading.value = true;
    IntroModelResponse? introModels =
    await repository.getIntroModels();
    if (introModels != null && introModels.status == 200) {
      if(introModels.data != null) {
        introPageList.value =
        introModels.data!.onBoardingSteps!;
      }
      isLoading.value = false;
    }
  }
}
