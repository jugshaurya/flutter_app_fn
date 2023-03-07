import 'dart:async';

import 'package:fs_app/factoryos/profile/model/profile_get_response.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_attr_response.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_response.dart';
import 'package:fs_app/factoryos/profile/profile_repo.dart';
import 'package:fs_app/factoryos/profileRole/model/CompletenessResponse.dart';

import 'package:fs_app/services/shared_preference_service.dart';
import 'package:get/get.dart';
import '../../constant/text_const.dart';
import '../inventory/model/product_model.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;

  RxList<dynamic?> completedProfileSectionList = <dynamic>[].obs;
  RxList<ProfileSections?> profileSectionList = <ProfileSections>[].obs;
  RxList<ProfileSectionsAttributes?> profileSectionAttrList =
      <ProfileSectionsAttributes>[].obs;
  RxList<ProfileGetResponse> profileGetResponseList = <ProfileGetResponse>[].obs;
  Rx<Product?> product = (null as Product?).obs;
  var responseListLoaded = false.obs;
  var isKeyboradOpen = false.obs;
  ProfileRepo repository = Get.find<ProfileRepo>();
  SharedPreferenceService preferenceService =
  Get.find<SharedPreferenceService>();


  Future<void> getProducts(int manufacturerId, int roleCategoryId) async {
    ProductModel? productModel = await repository.getProducts(manufacturerId, roleCategoryId);
    if (productModel != null) {
      product.value = productModel.data;
    }
  }




  Future<void> getProfileSection() async {
    ProfileSectionResponse? profileSectionResponse =
        await repository.getProfileSection();
    if (profileSectionResponse != null) {
      profileSectionList.value =
          profileSectionResponse.profileSection!.profileSections!;
      var manufacturerId = preferenceService.getInt(TextConst.manufacturer_id);
      // if (manufacturerId != null) {
      //   getCompletenessProfileSection(manufacturerId);
      // }
    }
  }

  Future<void> getProfileSectionAttributes(int roleId, int profileSectionId) async {
    ProfileSectionAttrResponse? profileSectionAttrResponse =
        await repository.getProfileSectionAttributes(roleId, profileSectionId);
    if (profileSectionAttrResponse != null) {
      responseListLoaded.value=true;
      profileSectionAttrList.value = profileSectionAttrResponse
          .profileSectionAttr!.profileSectionsAttributes!;
    }
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
      data: data,
      garmentTypes: garmentType.isEmpty ? []: garmentType,
    );
    return saveProfileResponse;
  }

  Future<void> getInitProfileSections() async {
    List<ProfileGetResponse>? profileGetResponses =
    await repository.getProfileSections();
    if (profileGetResponses != null) {
      responseListLoaded.value=true;
      profileGetResponseList.value = profileGetResponses;
    }
  }

  Future<void> getProfileSections() async {
    isLoading.value = true;
    Timer(const Duration(seconds:4), (){isLoading.value =false;});
    List<ProfileGetResponse>? profileGetResponses =
    await repository.getProfileSections();
    if (profileGetResponses != null) {
      responseListLoaded.value=true;
      profileGetResponseList.value = profileGetResponses;
    }
  }
}
