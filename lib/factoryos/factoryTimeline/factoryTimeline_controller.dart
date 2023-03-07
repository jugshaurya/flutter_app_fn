import 'dart:ffi';

import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/dashboard/model/CompletenessResponse.dart';
import 'package:fs_app/factoryos/dashboard/model/UserProfileResponse.dart';
import 'package:fs_app/factoryos/factoryTimeline/factoryTimeline_repo.dart';
import 'package:fs_app/factoryos/inventory/model/product_list_model.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_response.dart';
import 'package:fs_app/factoryos/dashboard/model/section.dart';
import 'package:fs_app/factoryos/profileRole/model/role_section_response.dart';
import 'package:fs_app/factoryos/profileRole/model/sub_role_section_response.dart';
import 'package:get/get.dart';

import '../../services/shared_preference_service.dart';

class FactoryTimelineController extends GetxController {
  var isLoading = false.obs;

  RxList<ProfileSections?> profileSectionList = <ProfileSections>[].obs;
  RxList<dynamic?> detailList = <dynamic>[].obs;
  RxList<dynamic?> completedProfileSectionList = <dynamic>[].obs;
  RxMap<dynamic?, dynamic?> completedProfileSectionListObj = <dynamic?, dynamic?>{}.obs;
  RxList<ProfileRoleSections> profileRolesList = <ProfileRoleSections>[].obs;
  RxList<ProfileSubRoleSections> profileSubRolesList = <ProfileSubRoleSections>[].obs;
  RxList<ProductData?> productList = <ProductData>[].obs;
  RxDouble completionPercent = 0.0.obs;
  UserProfileResponse? userProfileResponse;
  FactoryTimelineRepo repository = Get.find<FactoryTimelineRepo>();
  SharedPreferenceService preferenceService =
  Get.find<SharedPreferenceService>();

  Future<void> getProfileSection(int? manufactureId) async {
    isLoading.value = true;
    ProfileSectionResponse? profileSectionResponse =
    await repository.getProfileSection();
    isLoading.value = true;
    if (profileSectionResponse != null) {
      profileSectionList.value =
      profileSectionResponse.profileSection!.profileSections!;
      if (manufactureId != null) {
        getRolesData();
        getSubRolesData(manufactureId);
      }
    }
  }

  Future<void> getProducts(int manufacturerId, int roleCategoryId) async {
    try {
      isLoading.value = true;
      ProductListModel? productListModel =
      await repository.getProducts(manufacturerId, roleCategoryId);
      if (productListModel != null && productListModel.status == 200) {
        productList.value = productListModel.product ?? [];
      }
      isLoading.value = true;
    } catch (e) {
      isLoading.value = true;
    }
  }

  Future<void> getRolesData() async {
    ProfileRoleSectionResponse? profileRoleSectionResponse =
    await repository.getProfileRoleSection();
    if (profileRoleSectionResponse != null) {
      profileRolesList.value = profileRoleSectionResponse.profileRoleSection!.manufacturerRoles!;
    }
  }

  Future<void> getSubRolesData(int manufactureId) async {
    var roleId = preferenceService.getInt(TextConst.manufacturer_role);
    ProfileSubRoleSectionResponse? profileRoleSectionResponse =
    await repository.getProfileSubRoleSection(roleId);
    if (profileRoleSectionResponse != null) {
      profileSubRolesList.value = profileRoleSectionResponse.profileSubRoleSection!.manufacturerRoleCategory!;
      int? roleId = preferenceService.getInt(TextConst.manufacturer_role) ?? 0;
      int? roleCategoryId = preferenceService.getInt(TextConst.manufacturer_sub_role);
      if(roleCategoryId != null){
        getCompletenessProfileSection(
            manufactureId, roleId, roleCategoryId,true);
      }
      else {
        int index = 0;
        profileSubRolesList.value.forEach((profileSubItem) {
          getCompletenessProfileSection(
              manufactureId, roleId, (profileSubItem.id as int),
              index == profileSubRolesList.value.length - 1);
          index = index + 1;
        });
      }

    }
  }

  Future<void> getDetailList() async {
    //isLoading.value = true;
    detailList.value = Section.generateSections();
    String industryData = preferenceService.getString(TextConst.industry_set) ?? "";
      if(industryData != "0" && industryData != ""){
        detailList.value[0].done = true;
      }
    Future.delayed(const Duration(seconds:2)).then((value) {
      isLoading.value = false;
    });

    }

  Future<void> getUserProfileDetails() async {
    UserProfileResponse? userResponse = await repository.getUserProfile();
    if (userResponse != null && userResponse.status == 200) {
      userProfileResponse = userResponse;
      preferenceService.setString(
          TextConst.full_name, userProfileResponse!.userInfoModal!.fullName!);
      getProfileSection(userProfileResponse!.userInfoModal!.manufactureId!);
    }
  }

  Future<void> getCompletenessProfileSection(int manufacturerId, int roleId, int roleCategoryId, bool setLoadingValue) async {
    isLoading.value = true;
    getProducts(manufacturerId, roleCategoryId);
    CompletenessProfileSectionResponse? completenessProfileSectionResponse =
    await repository.getCompletenessProfileSection(
        manufacturerId, roleId, roleCategoryId);
    if (completenessProfileSectionResponse != null && completenessProfileSectionResponse.completenessProfileSection != null && completedProfileSectionList.length == 0) {
      completedProfileSectionList.value = [];
      completedProfileSectionListObj.value[roleCategoryId] = completenessProfileSectionResponse.completenessProfileSection!;
      completenessProfileSectionResponse.completenessProfileSection!.forEach((
          completenessProfileSection) {
        completedProfileSectionList.value.add(completenessProfileSection);
      });

      if (completedProfileSectionList.isNotEmpty) {
        completedProfileSectionList.value.sort((a, b) =>
            a["profileSectionId"].compareTo(b["profileSectionId"]));
      }
      if(completedProfileSectionList.length >= 3){
        detailList.value[0].done = true;
        detailList.value[1].done = true;
        detailList.value[2].done = true;
        detailList.value[3].done = true;
        detailList.value[0].isActive = false;
        detailList.value[1].isActive = false;
        detailList.value[2].isActive = false;
        detailList.value[3].isActive = false;
      }else if(completedProfileSectionList.length >= 2){
        detailList.value[0].done = true;
        detailList.value[1].done = true;
        detailList.value[2].done = true;
        detailList.value[0].isActive = false;
        detailList.value[1].isActive = false;
        detailList.value[2].isActive = false;
        detailList.value[3].isActive = true;
      }else if(completedProfileSectionList.length >= 1){
        detailList.value[0].done = true;
        detailList.value[1].done = true;
        detailList.value[0].isActive = false;
        detailList.value[1].isActive = false;
        detailList.value[2].isActive = true;
      }else if(completedProfileSectionList.length >= 0){
        detailList.value[0].done = detailList[0].done;
        detailList.value[0].isActive = false;
        detailList.value[1].isActive = true;
      }
      String industryData = preferenceService.getString(TextConst.industry_set) ?? "";
      if(industryData != "0" && industryData != ""){
        detailList.value[0].done = true;
        if(detailList.value[1].done != true) {
          detailList.value[1].isActive = true;
        }
      }else{
        if(detailList.value[0].done != true) {
          detailList.value[0].done = false;
          detailList.value[1].isActive = false;
          detailList.value[0].isActive = true;
        }
      }

    }
    if(completedProfileSectionList.length > 0){
      if(completedProfileSectionList.length >= 3){
        detailList.value[0].done = true;
        detailList.value[1].done = true;
        detailList.value[2].done = true;
        detailList.value[3].done = true;
        detailList.value[0].isActive = false;
        detailList.value[1].isActive = false;
        detailList.value[2].isActive = false;
        detailList.value[3].isActive = false;
      }else if(completedProfileSectionList.length >= 2){
        detailList.value[0].done = true;
        detailList.value[1].done = true;
        detailList.value[2].done = true;
        detailList.value[0].isActive = false;
        detailList.value[1].isActive = false;
        detailList.value[2].isActive = false;
        detailList.value[3].isActive = true;
      }else if(completedProfileSectionList.length >= 1){
        detailList.value[0].done = true;
        detailList.value[1].done = true;
        detailList.value[0].isActive = false;
        detailList.value[1].isActive = false;
        detailList.value[2].isActive = true;
      }else if(completedProfileSectionList.length >= 0){
        detailList.value[0].done = detailList[0].done;
        detailList.value[0].isActive = false;
        detailList.value[1].isActive = true;
      }
      String industryData = preferenceService.getString(TextConst.industry_set) ?? "";
      if(industryData != "0" && industryData != ""){
        detailList.value[0].done = true;
        if(detailList.value[1].done != true) {
          detailList.value[1].isActive = true;
        }
      }else{
        if(detailList.value[0].done != true) {
          detailList.value[0].done = false;
          detailList.value[1].isActive = false;
          detailList.value[0].isActive = true;
        }
      }
    }
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2)).then((value) {
      isLoading.value = false;
    });


  }
}
