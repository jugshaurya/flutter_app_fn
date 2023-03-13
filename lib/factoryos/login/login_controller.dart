import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/otp/model/otp_response.dart';
import 'package:fs_app/factoryos/otp/model/otrp_request.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/factoryos/login/login_repo.dart';
import 'package:fs_app/factoryos/otp/otpverfication_controller.dart';
import 'package:fs_app/utils/app_permission.dart';
import 'package:fs_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/shared_preference_service.dart';

class LoginController extends GetxController with LoginRepository {
  TextEditingController numberController = TextEditingController();
  // TextEditingController usernameController = TextEditingController();

  var isLoading = false.obs;
  String code = "+91";
  var numberError = "".obs;
  var number = "".obs;
  var username = "User".obs;
  var usernameError = "".obs;
  AppPermission appPermission = AppPermission();

  SharedPreferenceService preferenceService =
      Get.find<SharedPreferenceService>();

  @override
  void onInit() {
    isLoading.value = true;
    super.onInit();
    username.value = "User";
    number.value = numberController.text;
    // readTermAndConstions();
    // usernameController.addListener((){
    //   username.value = usernameController.text;
    // });
    numberController.addListener(() {
      number.value = numberController.text;
    });
    isLoading.value = false;
  }

  @override
  void onClose() {
    number.value = "";
    // usernameController.clear();
    numberController.clear();
    super.onClose();
  }

  void sendOTP() async {
    isLoading.value = true;
    if (numberController.text.isEmpty) {
      numberError("Field is required");
    } else if (numberController.text.length > 10) {
      numberError.value = "Invalid Number";
    } else {
      numberError("");
      usernameError("");
      var numberVal = number.value;
      number.value = (number.value.indexOf(code) == -1)
          ? code + number.value
          : number.value;
      OTPRequest otpReqObj = OTPRequest();
      otpReqObj.contactNo = number.value;
      otpReqObj.userName = "User";
      requestOtp(otpReqObj, (loginResponse) {
        if (loginResponse.status == 200) {
          preferenceService.setVerificationToken(loginResponse.data!);
          preferenceService.setString(TextConst.user_name, username.value);
          preferenceService.setString(TextConst.mobile_number, number.value);
          numberController.text = numberVal;
          Get.offAndToNamed(AppRoute.verification);
          isLoading.value = false;
        }
      }, (errorData) {
        numberController.text = numberVal;
        OtpResponse errorResponse = OtpResponse.fromJson(errorData.data);
        AppUtils.bottomSnackbar("Warning: ", errorResponse.message!);
        isLoading.value = false;
      });
    }
  }

  void resendOTP() {
    isLoading.value = true;
    OtpVerificationController controller =
        Get.find<OtpVerificationController>();
    controller.start.value = 30;
    controller.startTimer();
    OTPRequest otpRequest = new OTPRequest();
    otpRequest.contactNo =
        preferenceService.getString(TextConst.mobile_number).toString();
    otpRequest.userName = preferenceService.getString(TextConst.user_name);
    requestOtp(otpRequest, (loginResponse) {
      if (loginResponse.status == 200) {
        isLoading.value = false;
        AppUtils.bottomSnackbar("Message", "OTP sent successfully");
        preferenceService.setVerificationToken(loginResponse.data!);
        preferenceService.setString(TextConst.mobile_number, number.value);
        Get.offAndToNamed(AppRoute.verification);
      } else {
        isLoading.value = false;
        AppUtils.bottomSnackbar("Message", "Something went wrong!");
      }
    }, (errorData) {
      OtpResponse errorResponse = OtpResponse.fromJson(errorData.data);
      AppUtils.bottomSnackbar("Warning: ", errorResponse.message!);
    });
  }

  /*Future<void> readTermAndConstions() async {
    final String response =
        await rootBundle.loadString('assets/data/term_condtions.json');
    final data = await json.decode(response);
    termsAndConditions = TermsAndConditions.fromJson(data);
    Log.logger.i(termsAndConditions?.description);
  }*/
}
