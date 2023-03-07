import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/factoryos/login/login_controller.dart';
import 'package:fs_app/services/links.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:fs_app/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool value = false;
  LoginController controller = Get.find<LoginController>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom * 100;
    return Obx(
      () => LoadingOverlay(
          progressIndicator: const CircularProgressIndicator(
            color: ColorConst.primary,
          ),
          isLoading: controller.isLoading.value,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: ColorConst.white,
                elevation: 0,
                centerTitle: false,
                titleSpacing: 30,
                titleTextStyle: AppTextStyle.w700Blue16,
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [SizedBox(width: 100,)]),
              ),
              backgroundColor: ColorConst.screenBackground,
              body: SingleChildScrollView(
                  child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      const Text("Fill in your details to start your journey!",
                          style: AppTextStyle.w700textBlack18),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                          child: Form(
                            key: formKey,
                              child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                                child: Center(
                                  child: Obx(() => TextFormField(
                                        autofocus: true,
                                        controller: controller.numberController,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter mobile number';
                                          } else if (value.length != 10) {
                                            return 'Enter valid mobile number';
                                          }
                                          return null;
                                        },
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        maxLength: 10,
                                        cursorColor:
                                            Theme.of(context).primaryColor,
                                        maxLines: 1,
                                        style: AppTextStyle.mediumBlack24,
                                        decoration: InputDecoration(
                                            prefixIconConstraints:
                                                BoxConstraints(
                                                    minWidth: 70,
                                                    minHeight: 50),
                                            prefixIcon: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Container(
                                                    width: 70,
                                                    height: 56,
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 0, 0),
                                                      child: Text('+91 |',
                                                          style: AppTextStyle
                                                              .w700textBlack18),
                                                    ))
                                              ],
                                            ),
                                            counterText: "",
                                            errorMaxLines: 1,
                                            errorText: controller.numberError
                                                    .value.isNotEmpty
                                                ? null
                                                : controller.numberError.value,
                                            hintText: "Mobile Number",
                                            hintStyle:
                                                AppTextStyle.labelGray20),
                                      )),
                                ),
                              ),
                              Row(children: [
                                Checkbox(
                                    value: this.value,
                                    onChanged: (value) {
                                      setState(() {
                                        this.value = value!;
                                      });
                                    }),
                                InkWell(
                                  onTap: () => showTermAndConditions(context),
                                  child: RichText(
                                      maxLines: 2,
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Terms & Conditions",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.blue),
                                          )
                                        ],
                                        text: "I Agree to Factory OS ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "SF Pro Display",
                                            fontWeight: FontWeight.normal,
                                            color: ColorConst.lightBlack),
                                      )),
                                ),
                              ]),
                            ],
                          )))
                    ],
                  ),
                ),
              )),
            bottomNavigationBar: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 40),
              alignment: Alignment.bottomCenter,
              height: 48,
              width:MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: ColorConst.disabledColor
                      .withOpacity(0.1),
                  offset: const Offset(4, 4),
                  blurRadius: 10,
                )
              ]),
              child: Obx(
                    () => Material(
                  color:
                  (controller.number.value.length ==
                      10 &&
                      this.value)
                      ? ColorConst.primary
                      : ColorConst.disabledColor,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () {
                      if (formKey.currentState!
                          .validate() && controller.number.value.length ==
                          10 &&
                          this.value) {
                        controller.sendOTP();
                        /* if (controller.number.value.length == 10) {
        controller.sendOTP();
      }*/
                      }else{
                        if(controller.number.value.length !=
                            10) {
                          AppUtils.bottomSnackbar("Message",
                              "Please enter a valid mobile number!");
                        }
                        else if(!this.value){
                          AppUtils.bottomSnackbar("Message",
                              "Please accept the terms and conditions");
                        }
                      }
                    },
                    child: const Center(
                      child: Text(
                        "Next ",
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
            )
      ,
          )),
    );
  }

  showTermAndConditions(BuildContext context) {
    controller.isLoading.value = true;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, //
      /*shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),*/
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      // set this to true
      builder: (
        _,
      ) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.8,
          maxChildSize: 0.8,
          expand: false,
          builder: (_, _controller) {
            return SingleChildScrollView(
              controller: _controller,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 20),
                child: Obx(
                  () => LoadingOverlay(
                    isLoading: controller.isLoading.value,
                    child: WebView(
                      initialUrl: Links.termsCondition,
                      gestureNavigationEnabled: true,
                      gestureRecognizers: <
                          Factory<OneSequenceGestureRecognizer>>{
                        Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer(),
                        ),
                      },
                      onPageFinished: (value) =>
                          controller.isLoading.value = false,
                      javascriptMode: JavascriptMode.unrestricted,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
