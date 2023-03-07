import 'dart:async';
import 'dart:convert';

import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/dashboard/model/UserProfileResponse.dart';
import 'package:fs_app/factoryos/otp/model/verify_otp_request.dart';
import 'package:fs_app/factoryos/otp/model/verify_otp_response.dart';
import 'package:fs_app/factoryos/profileRole/profile_role_repo.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/factoryos/otp/otpverification_repo.dart';
import 'package:fs_app/utils/app_permission.dart';
import 'package:fs_app/utils/app_utils.dart';
import 'package:fs_app/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpVerificationController extends GetxController
    with OtpVerificationRepository, CodeAutoFill {
  TextEditingController otpValue = TextEditingController();
  ProfileRoleRepository repository = Get.find<ProfileRoleRepository>();
  UserProfileResponse? userProfileResponse;

  AppPermission appPermission = AppPermission();
  var isLoading = false.obs;
  var otpResponse = "".obs;

  @override
  void onInit() {
    isLoading.value = true;
    startTimer();
    super.onInit();
    listenOtp();
    otpValue.addListener(() {
      otpResponse.value = otpValue.text;
    });
    isLoading.value = false;
  }

  @override
  void onClose() {
    super.onClose();
  }

  RxInt start = (30).obs;
  RxBool wait = (false).obs;
  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start.value == 0) {
        timer.cancel();
        wait.value = false;
      } else {
        start.value = start.value - 1;
      }
    });
  }



  @override
  void codeUpdated() {
    // TODO: implement codeUpdated
  }

  getMobileNumber() {
    return preferenceService.getString(TextConst.mobile_number);
  }

  Future<void> getUserProfileDetails() async {
    UserProfileResponse? userResponse = await repository.getUserProfile();
    if (userResponse != null && userResponse.status == 200) {
      userProfileResponse = userResponse;
      preferenceService.setString(
          TextConst.full_name, userProfileResponse!.userInfoModal!.fullName!);
      if(userProfileResponse!.userInfoModal!.fullName!.isNotEmpty){
        preferenceService.setInt(TextConst.manufacturer_id, userProfileResponse!.userInfoModal!.manufactureId ?? 1);
        Get.offAndToNamed(AppRoute.factoryDashboard, arguments: {"pageState":"normal"});
      }
      else{
        Get.offAndToNamed(AppRoute.profileRoleScreen);
      }
    } else if (userResponse != null && userResponse.status == 401) {
      preferenceService.clearData();
      Get.offAndToNamed(AppRoute.login);
    }
    preferenceService.setInt(TextConst.manufacturer_role, 1);
  }

  void verifyOTP() async {
    isLoading.value = true;
    startTimer();
    if (otpValue.text.isEmpty || otpValue.text.length != 6) {
      AppUtils.bottomSnackbar("Warning: ", "Please enter valid OTP");
    } else {
      VerifyOtpRequest verifyOtpRequest = VerifyOtpRequest();
      verifyOtpRequest.contactNo =
          preferenceService.getString(TextConst.mobile_number);
      verifyOtpRequest.username = preferenceService.getString(TextConst.user_name);
      verifyOtpRequest.otp = otpValue.text;
      verifyOtpRequest.verficationCode =
          preferenceService.getVerificationToken();
      verifyOtpRequest.countryCode = "91";

      verifytOtp(verifyOtpRequest, (verifyOtpResponse) {
        if (verifyOtpResponse.status == 200) {
          // AppUtils.bottomSnackbar("Message: ", "OTP verified successfully!");
          preferenceService.setInt(TextConst.manufacturer_role, 1);
          otpValue.clear();
          if (verifyOtpResponse.data == null) {
            AppUtils.bottomSnackbar("Warning", "Please verify OTP");
          } else {
            preferenceService
                .setAuthToken('Bearer ' + verifyOtpResponse.data!.token!);
            getUserProfileDetails();
          }
        }
      }, (errorData) {
        AppUtils.bottomSnackbar("Warning", "Please verify OTP");
        VerifyOtpResponse errorResponse =
            VerifyOtpResponse.fromJson(errorData.data);
        AppUtils.bottomSnackbar("Warning: ", errorResponse.message!);
      });
    }
    isLoading.value = false;
  }

  void verifyBeneficiary(int manufacturerId) async {
    isLoading.value = true;
    startTimer();
    if (otpValue.text.isEmpty || otpValue.text.length != 6) {
      AppUtils.bottomSnackbar("Warning: ", "Please enter valid OTP");
    } else {
      VerifyOtpRequest verifyOtpRequest = VerifyOtpRequest();
      verifyOtpRequest.manufacturerId = manufacturerId;
      verifyOtpRequest.contactNo =
          preferenceService.getString(TextConst.mobile_number);
      verifyOtpRequest.username = preferenceService.getString(TextConst.user_name);
      verifyOtpRequest.otp = otpValue.text;
      verifyOtpRequest.verficationCode =
          preferenceService.getVerificationToken();

    }
    isLoading.value = false;
  }

  void listenOtp() async {
    SmsAutoFill().getAppSignature.then((String result) {
    });
    await SmsAutoFill().unregisterListener();
    listenForCode();
    await SmsAutoFill().listenForCode;
  }
}
