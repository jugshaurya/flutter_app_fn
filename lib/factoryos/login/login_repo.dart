import 'package:fs_app/factoryos/otp/model/otp_response.dart';
import 'package:fs_app/factoryos/otp/model/otrp_request.dart';
import 'package:fs_app/services/links.dart';
import 'package:fs_app/services/network_service.dart';
import 'package:get/get.dart';

class LoginRepository {
  NetworkService service = Get.find<NetworkService>();

  requestOtp(OTPRequest otpRequest, Function(OtpResponse otpResponse) otpResponse,
      Function(dynamic errorData) errorResponse) async {
    await service.post(Links.request_otp,body: otpRequest,
        onSuccess: (onSuccessData) =>
            otpResponse(OtpResponse.fromJson(onSuccessData)),
        onError: (onErrorData) => errorResponse(onErrorData));
  }
}
