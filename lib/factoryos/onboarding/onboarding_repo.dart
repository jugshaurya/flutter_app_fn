import 'package:dio/dio.dart' as dio;
import 'package:fs_app/factoryos/onboarding/model/intro_model_response.dart';
import 'package:fs_app/services/links.dart';
import 'package:fs_app/services/network_service.dart';
import 'package:get/get.dart';

class OnBoardingRepository {
  NetworkService service = Get.find<NetworkService>();

  Future<IntroModelResponse?> getIntroModels() async {
    try {
      dio.Response response = await service.get(Links.onboarding);
      if (response.data != null) {
        return IntroModelResponse.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
