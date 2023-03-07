import 'package:fs_app/factoryos/otp/model/verify_otp_request.dart';
import 'package:fs_app/factoryos/otp/model/verify_otp_response.dart';
import 'package:fs_app/services/links.dart';
import 'package:fs_app/services/network_service.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:get/get.dart';

class OtpVerificationRepository {
  NetworkService service = Get.find<NetworkService>();
  SharedPreferenceService preferenceService =
      Get.find<SharedPreferenceService>();

  verifytOtp(
      VerifyOtpRequest verifyOtpRequest,
      Function(VerifyOtpResponse verifyOtpResponse) verifyOtpResponse,
      Function(dynamic errorData) errorResponse) async {
    await service.post(Links.verify_otp,
        body: verifyOtpRequest,
        onSuccess: (onSuccessData) =>
            verifyOtpResponse(VerifyOtpResponse.fromJson(onSuccessData)),
        onError: (onErrorData) => errorResponse(onErrorData));
  }
}
