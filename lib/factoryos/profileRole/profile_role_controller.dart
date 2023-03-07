import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fs_app/factoryos/dashboard/dashboard_repo.dart';
import 'package:fs_app/factoryos/dashboard/model/section.dart';
import 'package:fs_app/factoryos/otp/model/otrp_request.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_response.dart';
import 'package:fs_app/factoryos/profileRole/model/role_section_response.dart';
import 'package:fs_app/factoryos/profileRole/profile_role_repo.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:get/get.dart';

import '../../constant/text_const.dart';
import '../../routes/app_routes.dart';
import '../dashboard/model/CompletenessResponse.dart';
import '../dashboard/model/UserProfileResponse.dart';
import 'model/sub_role_section_response.dart';

class ProfileRoleController extends GetxController {

  SharedPreferenceService preferenceService = Get.find<SharedPreferenceService>();
  ProfileRoleRepository repository = Get.find<ProfileRoleRepository>();
  RxList<ProfileRoleSections> profileRolesList = <ProfileRoleSections>[].obs;
  RxList<ProfileSubRoleSections> profileSubRolesList = <ProfileSubRoleSections>[].obs;
  RxList<dynamic?> completedProfileSectionList = <dynamic>[].obs;
  RxList<dynamic?> completedProfileSubSectionList = <dynamic>[].obs;
  UserProfileResponse? userProfileResponse;
  TextEditingController usernameController = TextEditingController();


  var isLoading = false.obs;
  var roleSelect = 0.obs;
  var roleSelectError = "".obs;

  var subRoleSelect = 0.obs;
  var subRoleSelectError = "".obs;
  var prefillRoleSelect = <int>{}.obs;
  var prefillSubRoleSelect = <int>{}.obs;
  var username = "".obs;
  var usernameError = "".obs;

  @override
  void onInit() {
    super.onInit();
    getRolesData();
    username.value = usernameController.text;
    usernameController.addListener((){
      username.value = usernameController.text;
    });
    isLoading.value = false;
  }

  RxList<ProfileSections?> profileSectionList = <ProfileSections>[].obs;
  RxList<dynamic?> detailList = <dynamic>[].obs;
  RxDouble completionPercent = 0.0.obs;
  DashboardRepo dashboardRepo = Get.find<DashboardRepo>();

  Future<void> getProfileSection(String? manufactureId) async {
    isLoading.value = true;
    ProfileSectionResponse? profileSectionResponse =
    await repository.getProfileSection();
    isLoading.value = false;
    if (profileSectionResponse != null) {
      profileSectionList.value =
      profileSectionResponse.profileSection!.profileSections!;
      if (manufactureId != null) {
        getCompletenessProfileSubSection(manufactureId);
      }
    }
  }

  Future<void> getDetailList() async {
    //isLoading.value = true;
    detailList.value = Section.generateSections();
  }

  Future saveProfile(
      int profileSectionId,
      Map<String, dynamic> data,List<dynamic> garmentType) async {
    isLoading.value = true;
    Timer(const Duration(seconds:3 ),   (){isLoading.value =false;});
    SharedPreferenceService preferenceService =
    Get.find<SharedPreferenceService>();
    var manufacturerId = preferenceService.getInt(TextConst.manufacturer_id);
    var roleId = preferenceService.getInt(TextConst.manufacturer_role);
    var roleCategoryId = preferenceService.getInt(TextConst.manufacturer_sub_role);

    var saveProfileResponse = await repository.saveProfile(
      manufacturerId: manufacturerId ?? 1,
      profileSectionId: profileSectionId,
      roleId: roleId ?? 1,
      roleCategoryId: roleCategoryId ?? 1,
      data: {},
      garmentTypes: garmentType.isEmpty ? []: garmentType,
    );
    return saveProfileResponse;
  }


  Future<void> getCompletenessProfileSubSection(String manufacturerId) async {
    isLoading.value = true;
    int? roleId = preferenceService.getInt(TextConst.manufacturer_role)??0;
    int? roleCategoryId = preferenceService.getInt(TextConst.manufacturer_sub_role)??0;

    CompletenessProfileSectionResponse? completenessProfileSectionResponse =
    await repository.getCompletenessProfileSubSection(manufacturerId, roleId, roleCategoryId);
    if (completenessProfileSectionResponse != null) {
      isLoading.value = false;
      completedProfileSubSectionList.value =
      completenessProfileSectionResponse.completenessProfileSection!;
      if(completedProfileSubSectionList.isNotEmpty) {
        completedProfileSubSectionList.value.sort((a, b) =>
            a["profileSectionId"].compareTo(b["profileSectionId"]));
      }
      int? activeSectionId = 0;
      if (profileSectionList.isNotEmpty) {
        profileSectionList.asMap().forEach((index, profileSection) {
          if (completedProfileSubSectionList.isNotEmpty &&
              profileSection!.id ==
                  completedProfileSubSectionList[
                  completedProfileSubSectionList.length - 1]
                  ["profileSectionId"]) {
            if (index < profileSectionList.length - 1 && profileSectionList[index + 1] != null) {
              activeSectionId = profileSectionList[index + 1]!.id;
              preferenceService.setInt(
                  TextConst.activeProfileSection, activeSectionId!);
              preferenceService.setInt(
                  TextConst.manufactureProfileCompletionStateIndex,
                  (index + 1));
              preferenceService.setInt(
                  TextConst.manufacturer_role,
                  completedProfileSubSectionList[
                  completedProfileSubSectionList.length - 1]["roleId"]!
              );
              preferenceService.setInt(
                  TextConst.manufacturer_sub_role,
                  completedProfileSubSectionList[
                  completedProfileSubSectionList.length - 1]
                  ["roleCategoryId"]!
              );

              if (completedProfileSubSectionList.isNotEmpty) {
                detailList[0].action = AppRoute.profile;
              } else {
                detailList[0].action = AppRoute.profile;
              }
              if (profileSectionList.isNotEmpty) {
                completionPercent.value =
                    ((completedProfileSubSectionList.length) /
                        (profileSectionList.length)) *
                        0.5;
                detailList[0].done = completedProfileSubSectionList.length ==
                    profileSectionList.length;
              }
              return;
            }else if(index == profileSectionList.length - 1){
              activeSectionId = 0;
              activeSectionId = profileSectionList[0]!.id;
              preferenceService.setInt(
                  TextConst.activeProfileSection, activeSectionId!);
              preferenceService.setInt(
                  TextConst.manufactureProfileCompletionStateIndex,
                  0);
              preferenceService.setInt(
                  TextConst.manufacturer_role,
                  completedProfileSubSectionList[
                  completedProfileSubSectionList.length - 1]["roleId"]!);
              preferenceService.setInt(
                  TextConst.manufacturer_sub_role,
                  completedProfileSubSectionList[
                  completedProfileSubSectionList.length - 1]
                  ["roleCategoryId"]!);

            }
          }
          else{
            if(preferenceService.getInt(TextConst.activeProfileSection) == null) {
              preferenceService.setInt(TextConst.activeProfileSection, 1);
              preferenceService.setInt(
                  TextConst.manufactureProfileCompletionStateIndex, 0);
              preferenceService.setInt(TextConst.manufacturer_role, 0);
              preferenceService.setInt(TextConst.manufacturer_sub_role, 0);

            }

          }
        });
      } else {
        preferenceService.setInt(TextConst.activeProfileSection, 1);
        preferenceService.setInt(
            TextConst.manufactureProfileCompletionStateIndex, 0);
        preferenceService.setInt(TextConst.manufacturer_role, 0);
        preferenceService.setInt(TextConst.manufacturer_sub_role, 0);
      }
    }
    if (completedProfileSubSectionList.isNotEmpty) {
      detailList[0].currentSectionIndex = preferenceService.getInt(
          TextConst.manufactureProfileCompletionStateIndex);
      detailList[0].activeSectionId = preferenceService.getInt(
          TextConst.activeProfileSection);
      detailList[0].action = AppRoute.profile;
    } else {
      preferenceService.setInt(TextConst.activeProfileSection, 1);
      preferenceService.setInt(
          TextConst.manufactureProfileCompletionStateIndex, 0);
      detailList[0].action = AppRoute.profile;
    }
    if (profileSectionList.isNotEmpty && completedProfileSubSectionList.isNotEmpty) {
      completionPercent.value =
          ((completedProfileSubSectionList.length) /
              (profileSectionList.length)) *
              0.5;
      detailList[0].done = completedProfileSubSectionList.length ==
          profileSectionList.length;
    }
  }



  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getRolesData() async {
    ProfileRoleSectionResponse? profileRoleSectionResponse =
    await repository.getProfileRoleSection();
    if (profileRoleSectionResponse != null) {
      profileRolesList.value = profileRoleSectionResponse.profileRoleSection!.manufacturerRoles!;
    }
  }

  Future<void> getSubRolesData() async {
    var roleId = preferenceService.getInt(TextConst.manufacturer_role);
    ProfileSubRoleSectionResponse? profileRoleSectionResponse =
    await repository.getProfileSubRoleSection(roleId == 0 ? (1) : roleId ?? 1);
    if (profileRoleSectionResponse != null) {
      profileSubRolesList.value = profileRoleSectionResponse.profileSubRoleSection!.manufacturerRoleCategory!;
    }
  }

  Future<void> getCompletenessProfileSection(int manufacturerId) async {
    CompletenessProfileSectionResponse? completenessProfileSectionResponse =
    await repository.getCompletenessProfileSection(manufacturerId);
    if(completenessProfileSectionResponse != null){
      completedProfileSectionList.value =
      completenessProfileSectionResponse.completenessProfileSection!;
      completedProfileSectionList.asMap().forEach((index, profileSection){
          var roleId = completedProfileSectionList[index]["roleId"];
          prefillRoleSelect.add(roleId);
          roleSelect.value = roleId;
          saveRole();
          var roleCategoryId = completedProfileSectionList[index]["roleCategoryId"];
          prefillSubRoleSelect.add(roleCategoryId);
          subRoleSelect.value = roleCategoryId;
          saveSubRole();
      });
    }
  }

  Future<void> getUserProfileDetails() async {
    UserProfileResponse? userResponse = await repository.getUserProfile();
    if (userResponse != null && userResponse.status == 200) {
      userProfileResponse = userResponse;
      preferenceService.setString(
          TextConst.full_name, userProfileResponse!.userInfoModal!.fullName!);
      if(userProfileResponse!.userInfoModal!.fullName!.isNotEmpty){
       Get.offAndToNamed(AppRoute.factoryDashboard, arguments: {"pageState":"normal"});
      }
      getCompletenessProfileSection(userProfileResponse!.userInfoModal!.manufactureId!);
    } else if (userResponse != null && userResponse.status == 401) {
      preferenceService.clearData();
      Get.offAndToNamed(AppRoute.login);
    }
    preferenceService.setInt(TextConst.manufacturer_role, 1);
  }

  void updateUserName() async {
    if(usernameController.text.isEmpty){
      usernameError("Field is required");
    } else {
      usernameError("");
      OTPRequest otpReqObj = OTPRequest();
      otpReqObj.contactNo = preferenceService.getString(TextConst.mobile_number).toString();
      otpReqObj.userName = username.value;
      preferenceService.setString(TextConst.user_name, username.value);
      UserProfileResponse? userResponse = await repository.updateUserName(otpReqObj);
      if (userResponse != null && userResponse.status == 200) {
        userProfileResponse = userResponse;
        preferenceService.setString(
            TextConst.full_name, userProfileResponse!.userInfoModal!.fullName!);
        preferenceService.setString(TextConst.user_name, username.value);
        preferenceService.setString(TextConst.full_name, username.value);
        preferenceService.setInt(TextConst.manufacturer_id, userProfileResponse!.userInfoModal!.manufactureId!);
        getCompletenessProfileSection(
            userProfileResponse!.userInfoModal!.manufactureId!);
        // getProfileSection(userProfileResponse!.userInfoModal!.manufactureId.toString() ?? "");
      }
    }
  }

  void saveRole() async {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 3)).then((value) {
      isLoading.value=false;
    });
      if (roleSelect.value == 0) {
      roleSelectError("Role must be selected");
    } else {
      roleSelectError("");
      preferenceService.setInt(TextConst.manufacturer_role, roleSelect.value);
      isLoading.value = false;
      getSubRolesData();
    }
  }

  void saveSubRole() async {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 3)).then((value) {
      isLoading.value=false;
    });
    if (subRoleSelect.value == 0) {
      subRoleSelectError("Role must be selected");
    } else {
      subRoleSelectError("");
      preferenceService.setInt(TextConst.manufacturer_sub_role, subRoleSelect.value);
      isLoading.value = false;
    }
  }

}
