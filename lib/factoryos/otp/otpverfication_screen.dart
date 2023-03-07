import 'dart:async';

import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/factoryos/login/login_controller.dart';
import 'package:fs_app/factoryos/otp/otpverfication_controller.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({Key? key}) : super(key: key);
  var manufacturerId;
  OtpVerificationController controller = Get.find<OtpVerificationController>();
  final TapGestureRecognizer _gestureRecognizer = TapGestureRecognizer()
    ..onTap = () {
      OtpVerificationController controller =
          Get.find<OtpVerificationController>();
      LoginController loginController = Get.find<LoginController>();
      controller.isLoading.value = true;
      controller.listenForCode();
      loginController.resendOTP();
      Timer(const Duration(seconds: 3), (){controller.isLoading.value=false;});
    };

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      manufacturerId = Get.arguments as int;
    }
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Obx(
      () => LoadingOverlay(
        progressIndicator: const CircularProgressIndicator(
          color: ColorConst.primary,
        ),
        isLoading: controller.isLoading.value,
        child: Scaffold(
          backgroundColor: ColorConst.screenBackground,
          appBar: AppBar(
            backgroundColor: ColorConst.white,
            elevation: 0,
            centerTitle: false,
            titleSpacing: 30,
            titleTextStyle:AppTextStyle.w700Blue16,
            title:Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.offNamed(AppRoute.login);
                    },
                    child:const Text("Cancel")
                  )
                ]
            ),
          ),
          body: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            // onTap: () {
            //   FocusScope.of(context).requestFocus(FocusNode());
            // },
            child: Column(
              children: [
                Expanded(
                    flex: 4,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 30,
                            ),
                            child: Text(
                              "Enter the 6 digit OTP sent to " +
                                  controller.getMobileNumber() +
                                  "",
                              style: AppTextStyle.w700textBlack18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 28,
                            ),
                            child: PinFieldAutoFill(
                              cursor: Cursor(
                                width: 2,
                                height: 20,
                                color: ColorConst.primary,
                                radius: Radius.circular(1),
                                enabled: true,
                              ),
                              autoFocus: true,
                              codeLength: 6,
                              decoration: BoxLooseDecoration(
                                strokeColorBuilder:
                                PinListenColorBuilder(ColorConst.shadowGreyColor, ColorConst.shadowGreyColor),
                                bgColorBuilder:null,
                              ),
                              currentCode: controller.otpValue.text,
                              onCodeChanged: (code) {
                                controller.otpValue.text = code.toString();
                              },
                              onCodeSubmitted: (val) {
                                print("Submitted");
                              },
                            ),
                          ),
                          SizedBox(height: 43),
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                                top: 15,
                              ),
                              child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  RichText(
                                      text: TextSpan(
                                        text: "Didn't receive the code?",
                                        style: AppTextStyle.normalBlack12
                                            .copyWith(
                                            fontFamily: "SF Pro Display",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: ColorConst.blackbLabelColor),
                                      )
                                  ),
                                  RichText(
                                    textAlign: TextAlign.right,
                                     text: TextSpan(
                                        text: controller.start.value < 10 ?
                                            "00:0"+controller.start.value.toString() : "00:"+controller.start.value.toString(),
                                        style: AppTextStyle.normalBlack12
                                            .copyWith(color: ColorConst.greyColor),
                                      )
                                  ),
                                ]
                              ),

                            ),

                          ),
                          Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 8,
                          ),
                          child:RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Resend",
                                    style: controller.start.value == 0 ? AppTextStyle.w700bluePrimary16:
                                    AppTextStyle.w700labelGray12,
                                    recognizer: controller.start.value == 0 ? _gestureRecognizer: null),
                              ],
                            ),
                          )
                  )
                        ],
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        height: 48,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .disabledColor
                                .withOpacity(0.1),
                            offset: const Offset(4, 4),
                            blurRadius: 10,
                          )
                        ]),
                        child: Obx(
                          () => Material(
                            color: (controller.otpResponse.value.length == 6)
                                ? ColorConst.primary
                                : ColorConst.disabledColor,
                            borderRadius: BorderRadius.circular(5),
                            child: InkWell(
                              onTap: () {
                                if (manufacturerId != null) {
                                  controller.verifyBeneficiary(manufacturerId);
                                } else {
                                  controller.verifyOTP();
                                  // Get.toNamed(AppRoute.welcome);
                                }
                              },
                              child: const Center(
                                child: Text(
                                  "Verify",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
