import 'package:flutter/material.dart';
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      SharedPreferenceService preferenceService = Get.find<SharedPreferenceService>();
      if (preferenceService.getAuthToken() != null &&
          (preferenceService.getAuthToken()?.isNotEmpty ?? false)) {
        var fullName = preferenceService.getString(TextConst.full_name) ?? "";
        if(fullName != "" || fullName != null){
          Get.offAndToNamed(AppRoute.factoryDashboard , arguments: {"pageState":"normal"});
          preferenceService.setInt(TextConst.manufacturer_role, 1);
        }
        else {
          Get.offAndToNamed(AppRoute.profileRoleScreen);
        }
      } else {
      Get.offAndToNamed(AppRoute.login);
      }
    });


    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
                child:Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.width * 0.5,),
                    Text("FOS", style: AppTextStyle.splashBlack118),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.1,),
                    Text("V 1.3.20", style: AppTextStyle.bolderGrey500)
                  ],
                )
            ),

          ],
        ),
      ),
    );
  }
}
