import 'dart:ffi';

import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/dashboard/model/CompletenessResponse.dart';
import 'package:fs_app/factoryos/dashboard/model/UserProfileResponse.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_response.dart';
import 'package:fs_app/factoryos/dashboard/model/section.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../services/shared_preference_service.dart';
import 'dashboard_repo.dart';

class DashboardController extends GetxController {
  var isLoading = false.obs;

  RxList<ProfileSections?> profileSectionList = <ProfileSections>[].obs;
  RxList<dynamic?> detailList = <dynamic>[].obs;
  RxList<dynamic?> completedProfileSectionList = <dynamic>[].obs;
  RxDouble completionPercent = 0.0.obs;
  UserProfileResponse? userProfileResponse;
  DashboardRepo repository = Get.find<DashboardRepo>();
  SharedPreferenceService preferenceService =
      Get.find<SharedPreferenceService>();

  Future<void> getProfileSection(int? manufactureId) async {
    isLoading.value = true;
    ProfileSectionResponse? profileSectionResponse =
        await repository.getProfileSection();
    isLoading.value = false;
    if (profileSectionResponse != null) {
      profileSectionList.value =
          profileSectionResponse.profileSection!.profileSections!;
      if (manufactureId != null) {
        getCompletenessProfileSection(manufactureId);
      }
    }
  }

  Future<void> getDetailList() async {
    //isLoading.value = true;
    detailList.value = Section.generateSections();
  }

  Future<void> getUserProfileDetails() async {
    isLoading.value = true;
    UserProfileResponse? userResponse = await repository.getUserProfile();
    if (userResponse != null && userResponse.status == 200) {
      userProfileResponse = userResponse;
      preferenceService.setString(
          TextConst.full_name, userProfileResponse!.userInfoModal!.fullName!);
      getProfileSection(userProfileResponse!.userInfoModal!.manufactureId!);
    }
    isLoading.value = false;
  }

  Future<void> getCompletenessProfileSection(int manufacturerId) async {
    isLoading.value = true;
    int? roleId = preferenceService.getInt(TextConst.manufacturer_role)??0;
    int? roleCategoryId = preferenceService.getInt(TextConst.manufacturer_sub_role)??0;

    CompletenessProfileSectionResponse? completenessProfileSectionResponse =
        await repository.getCompletenessProfileSection(manufacturerId, roleId, roleCategoryId);
    if (completenessProfileSectionResponse != null) {
      isLoading.value = false;
      completedProfileSectionList.value =
          completenessProfileSectionResponse.completenessProfileSection!;
      if(completedProfileSectionList.isNotEmpty) {
        completedProfileSectionList.value.sort((a, b) =>
            a["profileSectionId"].compareTo(b["profileSectionId"]));
      }
      int? activeSectionId = 0;
      if (profileSectionList.isNotEmpty) {
        profileSectionList.asMap().forEach((index, profileSection) {
          if (completedProfileSectionList.isNotEmpty &&
              profileSection!.id ==
                  completedProfileSectionList[
                          completedProfileSectionList.length - 1]
                      ["profileSectionId"]) {
            if (index < profileSectionList.length - 1 && profileSectionList[index + 1] != null) {
              activeSectionId = (preferenceService.getInt(TextConst.activeProfileSectionProfile) ?? 0) != 0  ?
              preferenceService.getInt(TextConst.activeProfileSectionProfile) : profileSectionList[index + 1]!.id;
              preferenceService.setInt(TextConst.activeProfileSectionProfile, 0);
              preferenceService.setInt(
                  TextConst.activeProfileSection, activeSectionId!);
              preferenceService.setInt(
                  TextConst.manufactureProfileCompletionStateIndex,
                  (index + 1));
              preferenceService.setInt(
                  TextConst.manufacturer_role,
                  completedProfileSectionList[
                          completedProfileSectionList.length - 1]["roleId"]!
                      );
              preferenceService.setInt(
                  TextConst.manufacturer_sub_role,
                  completedProfileSectionList[
                              completedProfileSectionList.length - 1]
                          ["roleCategoryId"]!
                      );

              if (completedProfileSectionList.isNotEmpty) {
                detailList[0].action = AppRoute.profile;
              } else {
                detailList[0].action = AppRoute.profile;
              }
              if (profileSectionList.isNotEmpty) {
                completionPercent.value =
                    ((completedProfileSectionList.length) /
                            (profileSectionList.length)) *
                        0.5;
                detailList[0].done = completedProfileSectionList.length >= 1;
                detailList[1].done = completedProfileSectionList.length >= 1;
                detailList[2].done = completedProfileSectionList.length >= 2;
                detailList[3].done = completedProfileSectionList.length >= 3;
                detailList[completedProfileSectionList.length].isActive = true;
              }
              return;
            }else if(index == profileSectionList.length - 1){
              activeSectionId = (preferenceService.getInt(TextConst.activeProfileSectionProfile) ?? 0) != 0  ?
              preferenceService.getInt(TextConst.activeProfileSectionProfile) : profileSectionList[0]!.id;
              preferenceService.setInt(TextConst.activeProfileSectionProfile, 0);
              preferenceService.setInt(
                  TextConst.activeProfileSection, activeSectionId!);
              preferenceService.setInt(
                  TextConst.manufactureProfileCompletionStateIndex,
                  0);
              preferenceService.setInt(
                  TextConst.manufacturer_role,
                  completedProfileSectionList[
                  completedProfileSectionList.length - 1]["roleId"]!);
              preferenceService.setInt(
                  TextConst.manufacturer_sub_role,
                  completedProfileSectionList[
                  completedProfileSectionList.length - 1]
                  ["roleCategoryId"]!);

            }
          }
          else{
            if(preferenceService.getInt(TextConst.activeProfileSection) == null) {
              preferenceService.setInt(TextConst.activeProfileSection, 1);
              preferenceService.setInt(
                  TextConst.manufactureProfileCompletionStateIndex, 0);
              // preferenceService.setInt(TextConst.manufacturer_role, 0);
              // preferenceService.setInt(TextConst.manufacturer_sub_role, 0);

            }

          }
        });
      } else {
        preferenceService.setInt(TextConst.activeProfileSection, 1);
        preferenceService.setInt(
            TextConst.manufactureProfileCompletionStateIndex, 0);
      }
    }
    if (completedProfileSectionList.isNotEmpty) {
      detailList[0].currentSectionIndex = preferenceService.getInt(
          TextConst.manufactureProfileCompletionStateIndex);
      detailList[0].activeSectionId = (preferenceService.getInt(TextConst.activeProfileSectionProfile) ?? 0) != 0  ?
      preferenceService.getInt(TextConst.activeProfileSectionProfile) : preferenceService.getInt(
          TextConst.activeProfileSection);
      preferenceService.setInt(TextConst.activeProfileSectionProfile, 0);
      detailList[0].action = AppRoute.profile;
    } else {
      int manufactureSubRole = preferenceService.getInt(TextConst.manufacturer_sub_role) ?? 0;
      if(manufactureSubRole ==  1){
        preferenceService.setInt(TextConst.activeProfileSection, 2);
        preferenceService.setInt(
            TextConst.manufactureProfileCompletionStateIndex, 0);
        detailList[0].action = AppRoute.profile;
      }else{
        preferenceService.setInt(TextConst.activeProfileSection, 1);
        preferenceService.setInt(
            TextConst.manufactureProfileCompletionStateIndex, 0);
        detailList[0].action = AppRoute.profile;
      }

    }
    if (profileSectionList.isNotEmpty && completedProfileSectionList.isNotEmpty) {
      completionPercent.value =
          ((completedProfileSectionList.length) /
              (profileSectionList.length)) *
              0.5;
      detailList[0].done = completedProfileSectionList.length >= 1;
      detailList[1].done = completedProfileSectionList.length >= 1;
      detailList[2].done = completedProfileSectionList.length >= 2;
      detailList[3].done = completedProfileSectionList.length >= 3;
      detailList[completedProfileSectionList.length].isActive = true;
    }
  }
}
