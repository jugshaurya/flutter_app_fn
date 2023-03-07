import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/profile/model/profile_save_response.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_attr_response.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_response.dart';
import 'package:fs_app/factoryos/profile/profile_controller.dart';
import 'package:fs_app/factoryos/profile/widget/fs_gst.dart';
import 'package:fs_app/factoryos/profile/widget/fs_profile_dropdown.dart';
import 'package:fs_app/factoryos/profile/widget/fs_profile_segment_dropdown.dart';
import 'package:fs_app/factoryos/profile/widget/fs_profile_single_dropdown.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:fs_app/utils/app_utils.dart';
import 'package:fs_app/utils/log.dart';
import 'package:fs_app/widgets/fs_certificate_picker.dart';
import 'package:fs_app/widgets/fs_circular_button.dart';
import 'package:fs_app/widgets/fs_image_picker.dart';
import 'package:fs_app/widgets/fs_location_picker.dart';
import 'package:fs_app/widgets/fs_mobile_number_field.dart';
import 'package:fs_app/widgets/fs_switch.dart';
import 'package:fs_app/widgets/fs_text_field.dart';
import 'package:get/get.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import '../../../services/shared_preference_service.dart';
import '../../inventory/model/TypeValue.dart';
import '../../inventory/widget/fs_single_select_dropdown.dart';

class ProfileWidget extends StatefulWidget {
  final ProfileSections profileSections;
  final PageController pageController;
  final RxList<ProfileSections?> profileSectionList;
  final int currentIndex;
  final int sliderCount;

  const ProfileWidget(
      {Key? key,
        required this.profileSections,
        required this.pageController,
        required this.currentIndex,
        required this.sliderCount,
        required this.profileSectionList})
      : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  SharedPreferenceService preferenceService = Get.find<SharedPreferenceService>();
  ProfileController controller = Get.find<ProfileController>();
  var formKey = GlobalKey<FormState>();
  Map<String, dynamic> data = <String, dynamic>{};
  List<dynamic> garmentType = <dynamic>[];
  RxList<dynamic> garmentId = [].obs;
  var profileAttrLoaded = false;

  @override
  void initState() {
    super.initState();
    int roleId = preferenceService.getInt(TextConst.manufacturer_role)?? 0;
    int profileSectionId = preferenceService.getInt(TextConst.activeProfileSection) ?? 0;
    int manufacturerId = preferenceService.getInt(TextConst.manufacturer_id) ?? 0;
    var roleCategoryId = preferenceService.getInt(TextConst.manufacturer_sub_role) ?? 0;
    controller.getProducts(manufacturerId, roleCategoryId);
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        controller.isKeyboradOpen.value = visible;
      },
    );

    if(roleId > 0 && profileSectionId > 0) {
      controller.getProfileSectionAttributes(
          roleId, profileSectionId);
      controller.getInitProfileSections();
    }
  }

  @override
  Widget build(BuildContext context) {
    int manufacturerId = preferenceService.getInt(TextConst.manufacturer_id) ?? 0;
    var roleCategoryId = preferenceService.getInt(TextConst.manufacturer_sub_role) ?? 0;
    controller.getProducts(manufacturerId, roleCategoryId);

    int roleId = preferenceService.getInt(TextConst.manufacturer_role)??0;
    int profileSectionId = preferenceService.getInt(TextConst.activeProfileSection) ?? 0;
    if(roleId >= 0 && profileSectionId > 0 && profileAttrLoaded == false) {
      profileAttrLoaded = true;
      Future.delayed(const Duration(seconds:10)).then((value) {
        profileAttrLoaded = false;
      });
      controller.getProfileSectionAttributes(
          roleId, profileSectionId);
      controller.getInitProfileSections();
    }
    return Obx(
          () => Scaffold(
        backgroundColor: ColorConst.white,
        appBar: AppBar(
          backgroundColor: ColorConst.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: ColorConst.black),
            onPressed:() async {

        if (widget.profileSections.id == 1) {
        Get.back();
        } else {
        SharedPreferenceService preferenceService =
        Get.find<SharedPreferenceService>();
        int? profileIndex = preferenceService.getInt(TextConst.manufactureProfileCompletionStateIndex);
        if(profileIndex != null && profileIndex > 0) {
        preferenceService.setInt(
        TextConst.manufactureProfileCompletionStateIndex,
        (profileIndex - 1));
        }
        int? activeSectionId = 0;
        if(controller.profileSectionList.isNotEmpty) {
        controller.profileSectionList.asMap().forEach((index, profileSection) {
        if (profileSection!.id == widget.profileSections.id) {
        if (controller.profileSectionList[index - 1] != null) {
        activeSectionId = controller.profileSectionList[index - 1]!.id;
        preferenceService.setInt(TextConst.activeProfileSection, activeSectionId!);
        }
        }
        });
        }
        else {
        preferenceService.setInt(
        TextConst.activeProfileSection,
        (widget.profileSections.id! - 1));
        }
        if(profileIndex != null) {
        widget.pageController.jumpToPage(profileIndex - 1);
        // Get.back();
        }
        // widget.pageController.previousPage(
        //     duration: const Duration(milliseconds: 100),
        //     curve: Curves.bounceIn);
        controller.getProfileSections();
        }
        },
          ),
          title: const Text(
            'Factory Setup',
            style: AppTextStyle.mediumBlack18,
          ),
          centerTitle: true,
          actions: <Widget>[
            _cancelAction,
            const SizedBox(
              width: 12,
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            color: ColorConst.white
          ),
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    Text(
                        'Step-${widget.currentIndex + 1} : ${widget.profileSections.name}',
                        style: AppTextStyle.boldBlack18,
                        textAlign: TextAlign.center
                    ),
                    SizedBox(height: 12,),
                    Text(
                        '${widget.currentIndex == 0 ? "(Let us know about the products in your factory)":
                            widget.currentIndex == 1 ? "(Enter information regarding company registration of your factory)":
                            "(Almost there. Provide details about your factory)"}',
                        style: AppTextStyle.labelGray12,
                        textAlign: TextAlign.center
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    controller.profileSectionAttrList.isNotEmpty && controller.responseListLoaded.value
                        ? _dynamicWidget
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 120,
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
            floatingActionButton: !controller.isKeyboradOpen.value ?
          Container(
              height: MediaQuery.of(context).size.height+300,
              child: Column(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height-119,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 87,
                                  margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  decoration: const BoxDecoration(
                                    color: ColorConst.white
                                  ),
                                  child: Column(
                                    children: [
                                      FsCircularButton(
                                      text: 'Save and Next',
                                      progressValue:(widget.currentIndex)*0.25,
                                      onSubmit: () async {
                                        if (formKey.currentState!.validate()) {
                                            ProfileSaveResponse response = await controller.saveProfile(
                                              widget.profileSections.id!, data, garmentType);
                                          if (response.status == 200) {
                                            // widget.pageController.nextPage(
                                            //     duration: const Duration(milliseconds: 100),
                                            //     curve: Curves.bounceIn);
                                            SharedPreferenceService preferenceService =
                                            Get.find<SharedPreferenceService>();
                                            preferenceService.setInt(
                                                TextConst.manufactureProfileCompletionStateIndex,
                                                widget.profileSections.id!);
                                            int? activeSectionId = 0;
                                            if(controller.profileSectionList.isNotEmpty) {
                                              controller.profileSectionList.asMap().forEach((index, profileSection) {
                                                if (profileSection!.id == widget.profileSections.id) {
                                                  if (index < controller.profileSectionList.length-1 && controller.profileSectionList[index + 1] != null) {
                                                    activeSectionId = controller.profileSectionList[index + 1]!.id;
                                                    preferenceService.setInt(TextConst.activeProfileSection, activeSectionId!);
                                                  }
                                                }
                                              });
                                            }
                                            else {
                                              preferenceService.setInt(
                                                  TextConst.activeProfileSection,
                                                  (widget.profileSections.id! + 1));
                                            }
                                            Get.toNamed(AppRoute.profileSuccessScreen);
                                          } else {
                                            AppUtils.bottomSnackbar(
                                                "Error!", "Something went wrong!");
                                          }
                                        }
                                      },
                                    ),
                                      SizedBox(height: 10,),
                                  ],
                                  ),
                                ),
                              ]
                          ),
            ) :
            Container(
              height: MediaQuery.of(context).size.height+300,
              child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height-450,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 0,
                      margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      decoration: const BoxDecoration(
                          color: ColorConst.white
                      ),
                      child: null,
                    ),
                  ]
              ),
            ),
            floatingActionButtonLocation: !controller.isKeyboradOpen.value ? FloatingActionButtonLocation.endFloat : null,

          ),
    );
  }

  Widget get _cancelAction => GestureDetector(
    onTap: () async {
      if (widget.profileSections.id == 1) {
        Get.offAndToNamed(AppRoute.factoryTimeline, arguments: {"pageState":"reload"});

      } else {
        SharedPreferenceService preferenceService =
        Get.find<SharedPreferenceService>();
        int? profileIndex = preferenceService.getInt(TextConst.manufactureProfileCompletionStateIndex);
        if(profileIndex != null && profileIndex > 0) {
          preferenceService.setInt(
              TextConst.manufactureProfileCompletionStateIndex,
              (profileIndex - 1));
        }
        int? activeSectionId = 0;
        if(controller.profileSectionList.isNotEmpty) {
          controller.profileSectionList.asMap().forEach((index, profileSection) {
            if (profileSection!.id == widget.profileSections.id) {
              if (controller.profileSectionList[index - 1] != null) {
                activeSectionId = controller.profileSectionList[index - 1]!.id;
                preferenceService.setInt(TextConst.activeProfileSection, activeSectionId!);
              }
            }
          });
        }
        else {
          preferenceService.setInt(
              TextConst.activeProfileSection,
              (widget.profileSections.id! - 1));
        }
        if(profileIndex != null) {
          Get.offAndToNamed(AppRoute.factoryTimeline, arguments: {"pageState":"reload"});
          // widget.pageController.jumpToPage(profileIndex - 1);
          // Get.back();
        }else{
          int roleId = preferenceService.getInt(TextConst.manufacturer_role) ?? 0;
          controller.getProfileSections();
        }
        // widget.pageController.previousPage(
        //     duration: const Duration(milliseconds: 100),
        //     curve: Curves.bounceIn);

        // controller.getProfileSectionAttributes(roleId, activeSectionId ?? 1);
      }
    },
    child: Align(
      alignment: Alignment.centerRight,
      child: Text(
        widget.profileSections.id == 1 ? 'Cancel' : "Cancel",
        style: AppTextStyle.w700Blue16,
      ),
    ),
  );

  Widget get _pageIndicator => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: List<Widget>.generate(
      widget.sliderCount,
          (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 3000),
          height: 5,
          width: 30,
          margin: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: (index == widget.currentIndex)
                ? const Color(0xFF333333)
                : const Color(0xFFE0E0E0),
          ),
        );
      },
    ),
  );

  Widget get _dynamicWidget => ListView.builder(
    itemBuilder: (buildContext, index) {
      ProfileSectionsAttributes profileSectionsAttributes =
      controller.profileSectionAttrList[index]!;

      Map<String, dynamic> map = {};
      for (var profileSection in controller.profileGetResponseList) {
        if (profileSection.profileSectionId == widget.profileSections.id) {
          map = profileSection.data ?? {};
          break;
        }
      }

      late Widget? dynamicWidget;
      if(!data.containsKey("${profileSectionsAttributes.id!}") && map.containsKey("${profileSectionsAttributes.id!}")){
        data["${profileSectionsAttributes.id!}"] = map["${profileSectionsAttributes.id!}"];
      }else if(!data.containsKey("${profileSectionsAttributes.id!}")){
        data["${profileSectionsAttributes.id!}"] = "";
      }
      switch (profileSectionsAttributes.fieldType!.toLowerCase()) {
        case "textfield":
          dynamicWidget = FsTextField(
            inputType: TextInputType.text,
            label: profileSectionsAttributes.name!,
            hint: profileSectionsAttributes.name == "Engagement terms" ?
            "e.g. FoB, CMT & etc." :
            profileSectionsAttributes.name == "Factory Size" ? "Enter number of machines"
                :"Enter ${profileSectionsAttributes.name!}",
            text: data["${profileSectionsAttributes.id!}"],
            isManadatory: profileSectionsAttributes.isMandatory ?? false,
            onChanged: (text) {
              data["${profileSectionsAttributes.id!}"] = text;
            },
          );
          break;
        case "numberfield":
          dynamicWidget = FsTextField(
            inputType: TextInputType.number,
            label: profileSectionsAttributes.name!,
            hint: profileSectionsAttributes.name == "Engagement terms" ?
            "e.g. FoB, CMT & etc." :
            profileSectionsAttributes.name == "Factory Size" ? "Enter number of machines"
                :"Enter ${profileSectionsAttributes.name!}",
            text: data["${profileSectionsAttributes.id!}"],
            isManadatory: profileSectionsAttributes.isMandatory ?? false,
            onChanged: (text) {
              data["${profileSectionsAttributes.id!}"] = text;
            },
          );
          break;
        case "mobilenumber":
          dynamicWidget = FsMobileNumberField(
            label: profileSectionsAttributes.name!,
            hint: "Enter ${profileSectionsAttributes.name ?? ""}",
            text: data["${profileSectionsAttributes.id!}"],
            isManadatory: profileSectionsAttributes.isMandatory ?? false,
            onChanged: (text) {
              data["${profileSectionsAttributes.id!}"] = text;
            },
          );
          break;
        case "singledropdown":
          dynamicWidget = FsProfileSingleDropdown(
            profileSectionsAttributes: profileSectionsAttributes,
            label: profileSectionsAttributes.name ?? "",
            text: data["${profileSectionsAttributes.id!}"],
            onChanged: (text) {
              data["${profileSectionsAttributes.id!}"] = text;
            },
          );
          break;
        case "garment":
          dynamicWidget = FsProfileMultiDropdown(
            profileSectionsAttributes: profileSectionsAttributes,
            label: profileSectionsAttributes.name ?? "",
            text: data["${profileSectionsAttributes.id!}"],
            onChanged: (text, listId) {
              Log.logger.i("FsDropdown ==== $text");
              data["${profileSectionsAttributes.id!}"] = text;
              garmentType = listId;
              garmentId.value = listId;
              SharedPreferenceService preferenceService = Get.find<SharedPreferenceService>();
              preferenceService.setString(TextConst.garmentTypes, listId.toString());


            },
          );
          break;

        case "dropdown":
        case "multidropdown":
          dynamicWidget = FsProfileMultiDropdown(
            profileSectionsAttributes: profileSectionsAttributes,
            label: profileSectionsAttributes.name ?? "",
            text: data["${profileSectionsAttributes.id!}"],
            onChanged: (text, listId) {
              Log.logger.i("FsDropdown ==== $text");
              data["${profileSectionsAttributes.id!}"] = text;
            },
          );
          break;
        case "segmentdropdown":
          dynamicWidget = FsMultiSegmentSelectDropdown(
              product:controller.product.value,
              profileSectionsAttributes: profileSectionsAttributes,
              label: profileSectionsAttributes.name ?? "",
              type: TypeValue.segmentTypeValues,
              text: data["${profileSectionsAttributes.id!}"],
              isMandatory: true,
              garmentId: garmentId.value.length > 0 ? garmentId.value : [],
              onChanged: (text, listId) {
                Log.logger.i("FsDropdown ==== $text");
                data["${profileSectionsAttributes.id!}"] = text;
              });
          break;
          case "gst":
          dynamicWidget = FsGstPicker(
            label: profileSectionsAttributes.name!,
            hint: "Enter ${profileSectionsAttributes.name!}",
            text: data["${profileSectionsAttributes.id!}"],
            fieldType: "gst",
            isManadatory: profileSectionsAttributes.isMandatory ?? false,
            onChanged: (text) {
              Log.logger.i("FsTextField ==== $text");
              data["${profileSectionsAttributes.id!}"] = text;
            },
          );
          break;
        case "gstcompanyname":
          dynamicWidget = FsGstPicker(
            label: profileSectionsAttributes.name!,
            hint: "Enter ${profileSectionsAttributes.name!}",
            text: data["${profileSectionsAttributes.id!}"],
            fieldType: "gstCompanyName",
            isManadatory: profileSectionsAttributes.isMandatory ?? false,
            onChanged: (text) {
              Log.logger.i("FsTextField ==== $text");
              data["${profileSectionsAttributes.id!}"] = text;
            },
          );
          break;
        case "gstcompanyaddress":
          dynamicWidget = FsGstPicker(
            label: profileSectionsAttributes.name!,
            hint: "Enter ${profileSectionsAttributes.name!}",
            text: data["${profileSectionsAttributes.id!}"],
            fieldType: "gstCompanyAddress",
            isManadatory: profileSectionsAttributes.isMandatory ?? false,
            onChanged: (text) {
              Log.logger.i("FsTextField ==== $text");
              data["${profileSectionsAttributes.id!}"] = text;
            },
          );
          break;
        case "upload":
          dynamicWidget = FsImagePicker(
            label: profileSectionsAttributes.name ?? "",
            hint: "Enter ${profileSectionsAttributes.name ?? ""}",
            text: data["${profileSectionsAttributes.id!}"],
            isManadatory: profileSectionsAttributes.isMandatory ?? false,
            onSelect: (fileName, base64String) {
              data["${profileSectionsAttributes.id!}"] = base64String;
            },
          );
          break;
        case "certificate":
          dynamicWidget = FsCertificatePicker(
            label: profileSectionsAttributes.name ?? "",
            hint: "Enter ${profileSectionsAttributes.name ?? ""}",
            text: data["${profileSectionsAttributes.id!}"],
            isManadatory: profileSectionsAttributes.isMandatory ?? false,
            onSelect: (index, fileName, base64String) {
              Log.logger.i("FsImagePicker ==== $fileName");
              dynamic newDataImg = data["${profileSectionsAttributes.id!}"];
              if(base64String == ""){
                List<String> parts = newDataImg.split(",");
                newDataImg = [parts.removeAt(index), parts.join(",")];
              }
              if(newDataImg == "" && base64String != "") {
                newDataImg = [base64String];
              }
              else if(base64String != ""){
                List<String> parts = data["${profileSectionsAttributes.id!}"].split(",");
                newDataImg=parts;
                newDataImg[index] = base64String;

              }
              if(base64String != "") {
                data["${profileSectionsAttributes.id!}"] = newDataImg.join(",");
              }
            },
          );
          break;
        case "location":
          dynamicWidget = FsLocationPicker(
            label: profileSectionsAttributes.name ?? "",
            hint: "Enter ${profileSectionsAttributes.name ?? ""}",
            text: data["${profileSectionsAttributes.id!}"],
            isManadatory: profileSectionsAttributes.isMandatory ?? false,
            onChanged: (text) {
              data["${profileSectionsAttributes.id!}"] = text;
            },
          );
          break;

        case "toggle":
          dynamicWidget = FsSwitch(
            text: profileSectionsAttributes.name ?? "",
            isMandatory: profileSectionsAttributes.isMandatory!,
            onSwitchChange: (value) {
              Log.logger.i("FsSwitch ==== $value");
            },
          );
          break;
        default:
          dynamicWidget = FsTextField(
            inputType: TextInputType.text,
            label: profileSectionsAttributes.name!,
            hint: "Enter ${profileSectionsAttributes.name!}",
            text: data["${profileSectionsAttributes.id!}"],
            isManadatory: profileSectionsAttributes.isMandatory ?? false,
            onChanged: (text) {
              Log.logger.i("FsTextField ==== $text");
              data["${profileSectionsAttributes.id!}"] = text;
            },
          );
          break;
      }
      return dynamicWidget;
    },
    itemCount: controller.profileSectionAttrList.length,
    shrinkWrap: true,
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.vertical,
  );
}