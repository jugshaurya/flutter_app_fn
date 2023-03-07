
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/dashboard/model/CompletenessResponse.dart';
import 'package:fs_app/factoryos/dashboard/model/UserProfileResponse.dart';
import 'package:fs_app/factoryos/factoryDashboard/factoryDashboard_repo.dart';
import 'package:fs_app/factoryos/inventory/model/product_list_model.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_response.dart';
import 'package:fs_app/factoryos/dashboard/model/section.dart';
import 'package:fs_app/factoryos/profileRole/model/role_section_response.dart';
import 'package:fs_app/factoryos/profileRole/model/sub_role_section_response.dart';
import 'package:get/get.dart';

import '../../services/shared_preference_service.dart';

class FactoryDashboardController extends GetxController {
  var isLoading = false.obs;

  RxList<ProfileSections?> profileSectionList = <ProfileSections>[].obs;
  RxList<dynamic?> detailList = <dynamic>[].obs;
  RxList<dynamic?> completedProfileSectionList = <dynamic>[].obs;
  RxMap<dynamic?, dynamic?> completedProfileSectionListObj = <dynamic?, dynamic?>{}.obs;
  RxList<ProfileRoleSections> profileRolesList = <ProfileRoleSections>[].obs;
  RxList<ProfileSubRoleSections> profileSubRolesList = <ProfileSubRoleSections>[].obs;
  RxList<ProductData?> productList = <ProductData>[].obs;
  RxDouble completionPercent = 0.0.obs;
  RxInt completeProfileRoleCount = 1.obs;
  UserProfileResponse? userProfileResponse;
  FactoryDashboardRepo repository = Get.find<FactoryDashboardRepo>();
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
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> getRolesData() async {
    ProfileRoleSectionResponse? profileRoleSectionResponse =
    await repository.getProfileRoleSection();
    if (profileRoleSectionResponse != null) {
      profileRolesList.value = profileRoleSectionResponse.profileRoleSection!.manufacturerRoles!;
    }
    Future.delayed(const Duration(seconds: 3)).then((value) {
      isLoading.value = false;
    });
  }

  Future<void> getSubRolesData(int manufactureId) async {
    var roleId = preferenceService.getInt(TextConst.manufacturer_role);
    ProfileSubRoleSectionResponse? profileRoleSectionResponse =
    await repository.getProfileSubRoleSection(roleId);
    Future.delayed(const Duration(seconds: 3)).then((value) {
      isLoading.value = false;
    });
    if (profileRoleSectionResponse != null) {
      profileSubRolesList.value = profileRoleSectionResponse.profileSubRoleSection!.manufacturerRoleCategory!;
      int? roleId = preferenceService.getInt(TextConst.manufacturer_role) ?? 0;
      int index = 0;
      profileSubRolesList.value.forEach((profileSubItem) {
        getCompletenessProfileSection(manufactureId, roleId, (profileSubItem.id as int),
            index == profileSubRolesList.value.length - 1);
        index = index + 1;
      });

    }
  }

  Future<void> getDetailList() async {
    //isLoading.value = true;
    Future.delayed(const Duration(seconds: 3)).then((value) {
      isLoading.value = false;
    });
    detailList.value = Section.generateSections();
  }

  Future<void> getUserProfileDetails() async {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 3)).then((value) {
      isLoading.value = false;
    });
    UserProfileResponse? userResponse = await repository.getUserProfile();
    if (userResponse != null && userResponse.status == 200) {
      userProfileResponse = userResponse;
      preferenceService.setString(
          TextConst.full_name, userProfileResponse!.userInfoModal!.fullName!);
      getProfileSection(userProfileResponse!.userInfoModal!.manufactureId!);
    }
    isLoading.value = false;
  }

  Future<void> getCompletenessProfileSection(int manufacturerId, int roleId, int roleCategoryId, bool setLoadingValue) async {
    isLoading.value = false;
    Future.delayed(const Duration(seconds: 3)).then((value) {
      isLoading.value = false;
    });
    getProducts(manufacturerId, roleCategoryId);
    CompletenessProfileSectionResponse? completenessProfileSectionResponse =
    await repository.getCompletenessProfileSection(
        manufacturerId, roleId, roleCategoryId);

    if (completenessProfileSectionResponse != null && completenessProfileSectionResponse.completenessProfileSection != null) {
      completedProfileSectionListObj.value[roleCategoryId] = completenessProfileSectionResponse.completenessProfileSection!;
      completenessProfileSectionResponse.completenessProfileSection!.forEach((completenessProfileSection){
        var dataFoundAndAdded = false;
        if(completedProfileSectionList.value.length > 0){
          completedProfileSectionList.value.forEach((completeSectionInList){
            if(completeSectionInList["roleCategoryId"] == completenessProfileSection["roleCategoryId"] && completeSectionInList["profileSectionId"] == completenessProfileSection["profileSectionId"]){
              dataFoundAndAdded = true;
              completeSectionInList["data"] = completenessProfileSection["data"];
            }
            if(completeSectionInList["roleCategoryId"] != completenessProfileSection["roleCategoryId"]){
              completeProfileRoleCount.value += 1;
            }
          });
        }
        if(!dataFoundAndAdded) {
          completedProfileSectionList.value.add(completenessProfileSection);
        }
      });
      if (completedProfileSectionList.isNotEmpty) {
        completedProfileSectionList.value.sort((a, b) =>
            a["profileSectionId"].compareTo(b["profileSectionId"]));
      }

    }
    isLoading.value = setLoadingValue ? false : true;
  }
}
