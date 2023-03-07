import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_attr_response.dart';
import 'package:fs_app/factoryos/profileRole/profile_role_controller.dart';
import 'package:fs_app/factoryos/profileRole/widgets/fs_single_dropdown.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:get/get.dart';
import '../../../constant/color_const.dart';


class RoleSectionWidget extends  StatelessWidget {
  final PageController pageController;
  final int currentIndex;
  final ProfileRoleController controller;
  final Function onPageChanged;


  const RoleSectionWidget({Key? key,
    required this.pageController,
    required this.currentIndex,
  required this.controller,
  required this.onPageChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SharedPreferenceService preferenceService =
    Get.find<SharedPreferenceService>();
    ProfileSectionsAttributes profileSectionsAttributes = ProfileSectionsAttributes(
        name: "Identify Primary Persona",
        isMandatory: false,
        id: 1,
        profileSectionsAttributeValues: []
    );
    if(controller.profileRolesList.length > 0){
      List<ProfileSectionsAttributeValues> profileSectionsAttributeValues = (controller.profileRolesList.map((item){return ProfileSectionsAttributeValues(id: item.id, name: item.name, sortOrder: 1, isSelected: false);}).toList() as List<ProfileSectionsAttributeValues>);
      profileSectionsAttributes.profileSectionsAttributeValues = (profileSectionsAttributeValues as List<ProfileSectionsAttributeValues>);
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,

        body:SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                child: Column(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      child: Text("Start your journey by creating a master profile. This will help us in knowing your purpose to use FactoryOS.",
                            textAlign: TextAlign.center,
                          style: AppTextStyle.labelGray12),
                      ),
                    const SizedBox(height: 30,),

                    TextFormField(
                      maxLines: 1,
                      style: AppTextStyle.mediumBlack16,
                      controller: controller.usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter full name';
                        }
                        return null;
                      },
                      autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        label: RichText(
                          text: const TextSpan(
                            text: "Enter Full Name",
                            style: AppTextStyle.normalhintGrey14,
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16))
                            ],),
                        ),
                        hintText: "Enter Name",
                        hintStyle: AppTextStyle.normalhintGrey12,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: ColorConst.lightGrey)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: ColorConst.lightGrey)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: ColorConst.lightGrey)),
                        disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: ColorConst.lightGrey)),
                        floatingLabelStyle:
                        MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                          final Color color = states.contains(MaterialState.error)
                              ? ColorConst.lightGrey
                              : ColorConst.lightGrey;
                          return TextStyle(color: color, letterSpacing: 1.3);
                        }),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),

                    const SizedBox(height: 40,),
                    const SizedBox(
                      width: double.infinity,
                      child: Text("Identify Primary Persona",
                          textAlign: TextAlign.left,
                          style: AppTextStyle.w500textBlack18),
                    ),
                    const SizedBox(height: 30,),
                    controller.profileRolesList.length > 0 ?
                    ProfileSingleDropdown(
                      profileSectionsAttributes: profileSectionsAttributes,
                      text: "",
                      label: "Persona",
                  onChanged: (text, index) {
                    preferenceService.setString(TextConst.manufacturer_role_name, text);
                    controller.roleSelect.value = index;
                    controller.saveRole();
                  },
                ):
                    Container(),

                  ],
                ),
              ),
            )
        ),
        bottomNavigationBar: GestureDetector(
          onTap: (){
            controller.updateUserName();
            if(controller.roleSelect.value != 0) {
              pageController.nextPage(
                  duration: const Duration(milliseconds: 10),
                  curve: Curves.bounceIn);
              onPageChanged(currentIndex);
            }
          },
          child:Container(
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
            child: Material(
              color:(controller.roleSelect.value != null)
                  ? ColorConst.primary
                  : ColorConst.disabledColor,
              borderRadius: BorderRadius.circular(5),
              child: InkWell(
                onTap: () {
                  controller.updateUserName();
                  if(controller.roleSelect.value != 0) {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 10),
                        curve: Curves.bounceIn);
                    onPageChanged(currentIndex);
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
      ),
    );
  }

  GestureDetector CustomRadioBtn(String textValue, int index, ProfileRoleController controller) {
    SharedPreferenceService preferenceService = Get.find<SharedPreferenceService>();
    if(controller.roleSelect.value == index){
      preferenceService.setString(TextConst.manufacturer_role_name, textValue);
    }
    return GestureDetector(
        onTap: () {
          preferenceService.setString(TextConst.manufacturer_role_name, textValue);
          controller.roleSelect.value = index;
          controller.saveRole();
        },
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 80,
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: controller.prefillRoleSelect.contains(index) || controller.roleSelect.value == index ?
              Border.all(color: ColorConst.primary, width: 1) : Border.all(color: ColorConst.black, width: 1),
              color: controller.prefillRoleSelect.contains(index) || controller.roleSelect.value == index ?
              ColorConst.primaryLightBackground : ColorConst.white
          ),

          child: InkWell(
            onTap: () {
              preferenceService.setString(TextConst.manufacturer_role_name, textValue);
              controller.roleSelect.value = index;
              controller.saveRole();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    Row(
                        children: [
                          Container(
                              child: controller.roleSelect.value == index || controller.prefillRoleSelect.contains(index) ?
                              SizedBox(
                                  child: IconButton(
                                      onPressed: (){},
                                      icon: controller.prefillRoleSelect.contains(index) && controller.roleSelect.value != index ?
                                      SvgPicture.asset(ImageConst.redCircleSvg)
                                          :
                                      SvgPicture.asset(ImageConst.redTickIconSvg)
                                  )
                              ):
                              SizedBox(
                                  child: IconButton(
                                      onPressed: (){},
                                      icon: SvgPicture.asset(ImageConst.blackCircleSvg)
                                          )
                              )
                          )
                        ]
                    ),
                    Text(
                      textValue,
                      style: const TextStyle(
                        color:  ColorConst.black,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                  ]

              ),
            ),
          ),
        )
    );
  }

}


