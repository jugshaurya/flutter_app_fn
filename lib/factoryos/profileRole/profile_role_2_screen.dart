import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/profileRole/profile_role_controller.dart';
import 'package:fs_app/factoryos/profileRole/widgets/RoleSectionWidget.dart';
import 'package:fs_app/factoryos/profileRole/widgets/RoleSubSectionWidget.dart';
import 'package:fs_app/factoryos/profileRole/widgets/RoleSuccessWidget.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/utils/app_utils.dart';
import 'package:fs_app/widgets/fs_certificate_picker.dart';
import 'package:fs_app/widgets/fs_circular_button.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../services/shared_preference_service.dart';
import '../../theme/text_style.dart';

class ProfileRolePage2 extends StatefulWidget {
  const ProfileRolePage2({Key? key}) : super(key: key);

  @override
  State<ProfileRolePage2> createState() => _ProfileRolePage2State();
}

class _ProfileRolePage2State extends State<ProfileRolePage2> {
  ProfileRoleController controller = Get.find<ProfileRoleController>();
  PageController pageController = PageController(initialPage: 0);
  var currentIndex = 0.obs;
  SharedPreferenceService preferenceService =
  Get.find<SharedPreferenceService>();


  @override
  void initState() {
    super.initState();
    controller.getRolesData();
    controller.getSubRolesData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: ColorConst.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: ColorConst.black),
                onPressed: () => Get.back(),
              ),
              title: const Text(
                'Factory Setup',
                style: AppTextStyle.mediumBlack18,
              ),
              centerTitle: true,
              actions: <Widget>[
                InkWell(
                  onTap: () => Get.toNamed(AppRoute.factoryTimeline),
                  child: const Center(
                    child: Text(
                      'Cancel',
                      style: AppTextStyle.w700Blue16,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
              ],
            ),
            backgroundColor: ColorConst.white,
            body:Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 28),
                    child: Column(
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          child: Text("Step-1: Industry Details",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.mediumBlack20),
                        ),
                        const SizedBox(height: 7,),
                        const SizedBox(
                          width: double.infinity,
                          child: Text("(Choose the Industry segment for your factory)",
                          textAlign: TextAlign.center ,
                          style: AppTextStyle.labelGray12)
                        ),
                        const SizedBox(height: 60,),
                        controller.profileSubRolesList.length > 0 ?
                        Column(
                          children:List<Widget>.generate(
                              2, (index) {
                            return Row(
                                children: [
                                  CustomRadioButton (
                                      context,
                                      controller.profileSubRolesList[0].name!,
                                      controller.profileSubRolesList[0].id!,
                                      controller
                                  ),
                                  const SizedBox(width: 20,),
                                  index == 1 ?
                                  SizedBox(width: 30,) :
                                  CustomRadioButton (
                                      context,
                                      controller.profileSubRolesList[0].name!,
                                      controller.profileSubRolesList[0].id!,
                                      controller
                                  )
                                ]
                            );
                          }),

                        ):
                        Container(),

                      ],
                    ),
                  ),
                )
            ),
            floatingActionButton:  MediaQuery.of(context).viewInsets.bottom == 0.0 ?
            Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height - 199,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 30, right: 0, bottom: 0, top: 0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: ColorConst.white
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap: (){
                                if(controller.subRoleSelect.value != 0) {
                                  Get.offAndToNamed(AppRoute.profile);
                                }else{
                                  AppUtils.bottomSnackbar("Warning", "Please select a sub role");
                                }
                              },
                              child:Container(
                                width: 140,
                                height: 140,
                                child: FsCircularButton(
                                  text: 'Save and Next',
                                  progressValue: 0.05,
                                  onSubmit: ()  {
                                    if(controller.subRoleSelect.value != 0) {
                                      preferenceService.setString(TextConst.industry_set, controller.subRoleSelect.value.toString());
                                      preferenceService.setInt(TextConst.manufacturer_sub_role, controller.subRoleSelect.value);
                                      controller.saveProfile(1, {}, []);
                                      Get.offAndToNamed(AppRoute.profile);
                                    }else{
                                      AppUtils.bottomSnackbar("Warning", "Please select a sub role");
                                    }
                                  },
                                ),
                              )
                          ),
                          SizedBox(height: 10,)
                        ],
                      ),
                    ),
                  ]
              ): null,
            floatingActionButtonLocation: MediaQuery.of(context).viewInsets.bottom == 0.0 ? FloatingActionButtonLocation.endFloat: null,
          ),
        ),
      ),
    );
  }


  GestureDetector CustomRadioButton(BuildContext context,String textValue, int index, ProfileRoleController controller) {
    SharedPreferenceService preferenceService = Get.find<SharedPreferenceService>();

    if(controller.subRoleSelect.value == index){
      preferenceService.setString(TextConst.manufacturer_sub_role_name, textValue);
    }
    return GestureDetector(
        onTap: () {
          preferenceService.setString(TextConst.manufacturer_sub_role_name, textValue);
          controller.subRoleSelect.value = index;
          controller.saveSubRole();
        },
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 106,
          width: MediaQuery.of(context).size.width * 0.43,
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border:   controller.subRoleSelect.value == index  ?
              Border.all(color: ColorConst.primary, width: 1) : Border.all(color: ColorConst.black, width: 1),
              color: controller.subRoleSelect.value == index  ?
              ColorConst.primaryLightBackground : ColorConst.white
          ),

          child: InkWell(
            onTap: () {
              preferenceService.setString(TextConst.manufacturer_sub_role_name, textValue);
              controller.subRoleSelect.value = index;
              controller.saveSubRole();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),

              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    SizedBox(
                        child: IconButton(
                            onPressed: (){},
                            icon:   textValue == "Footwear"?
                            Image.asset(ImageConst.footwearSvg)
                                :SvgPicture.asset(
                                textValue == "Apparels" ?
                                ImageConst.apparelSvg
                                    :
                                textValue == "Footwear" ?
                                ImageConst.footwearSvg
                                    :
                                ImageConst.accessoriesSvg
                            )
                        )
                    ),
                    SizedBox(height: 14,),
                    Text(
                      textValue,
                      style: const TextStyle(
                        color: ColorConst.testGrayLight,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                  ]
              ),
            ),
          ),
        )
    );
  }

}
