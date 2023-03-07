import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/profileRole/profile_role_controller.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:fs_app/utils/app_utils.dart';
import 'package:fs_app/widgets/fs_circular_button.dart';
import 'package:get/get.dart';

import '../../../constant/color_const.dart';


class RoleSubSectionWidget extends  StatelessWidget {
  final PageController pageController;
  final int currentIndex;
  final ProfileRoleController controller;
  final Function onPageChanged;


  const RoleSubSectionWidget({Key? key,
    required this.pageController,
    required this.currentIndex,
    required this.controller,
  required this.onPageChanged})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    SharedPreferenceService preferenceService =
    Get.find<SharedPreferenceService>();
    return SafeArea(
      child: Scaffold(

        backgroundColor: Theme.of(context).backgroundColor,

        body:SingleChildScrollView(
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
                                  controller.profileSubRolesList[index == 1 ? index + 1 : index].name!,
                                  controller.profileSubRolesList[index == 1 ? index + 1 : index].id!,
                                  controller
                              ),
                              const SizedBox(width: 20,),
                              index == 1 ?
                              SizedBox(width: 30,) :
                              CustomRadioButton (
                                  context,
                                  controller.profileSubRolesList[index+1].name!,
                                  controller.profileSubRolesList[index+1].id!,
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
        floatingActionButton: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 199,
              ),
              Container(
               width: MediaQuery.of(context).size.width,

                decoration: BoxDecoration(
                    color: ColorConst.white
                ),
                child: Container(
                  child: Center(
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: (){
                            if(controller.subRoleSelect.value != 0) {
                              Get.offAndToNamed(AppRoute.dashboard);
                            }else{
                              AppUtils.bottomSnackbar("Warning", "Please select a sub role");
                            }
                          },
                          child:Container(
                            child: FsCircularButton(
                              text: 'Save and Next',
                              progressValue: 0.05,
                              onSubmit: ()  {
                                if(controller.subRoleSelect.value != 0) {
                                  preferenceService.setString(TextConst.industry_set, controller.subRoleSelect.value.toString());
                                  preferenceService.setInt(TextConst.manufacturer_sub_role, controller.subRoleSelect.value);
                                  controller.saveProfile(1, {}, []);
                                  Get.offAndToNamed(AppRoute.dashboard);
                                }else{
                                  AppUtils.bottomSnackbar("Warning", "Please select a sub role");
                                }
                              },
                            ),
                          )
                      ),
                      SizedBox(height: 10,)
                    ],
                  )
                  ),
                ),
              ),
            ]
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
          width: MediaQuery.of(context).size.width * 0.4,
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border:   controller.subRoleSelect.value == index  ?
              Border.all(color: ColorConst.primary, width: 1) : Border.all(color: ColorConst.black, width: 1),
              color: controller.subRoleSelect.value == index  ?
              ColorConst.primaryLightBackground : ColorConst.white
          ),

          child: GestureDetector(
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


