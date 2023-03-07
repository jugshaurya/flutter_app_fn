import 'package:dio/dio.dart' as dio;
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/dashboard/model/CompletenessResponse.dart';
import 'package:fs_app/factoryos/dashboard/model/UserProfileResponse.dart';
import 'package:fs_app/factoryos/inventory/model/product_list_model.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_response.dart';
import 'package:fs_app/factoryos/profileRole/model/role_section_response.dart';
import 'package:fs_app/factoryos/profileRole/model/sub_role_section_response.dart';
import 'package:fs_app/services/links.dart';
import 'package:fs_app/services/network_service.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:get/get.dart';


class FactoryTimelineRepo {
  NetworkService service = Get.find<NetworkService>();
  SharedPreferenceService preferenceService = Get.find<SharedPreferenceService>();

  Future<UserProfileResponse?> getUserProfile() async {
    try {
      var mobileNumber = preferenceService.getString(TextConst.mobile_number);
      var linksUrl = Links.userInfoUrl + "/" + mobileNumber! + "";
      dio.Response response = await service.get(linksUrl);
      if (response.data != null) {
        return UserProfileResponse.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ProductListModel?> getProducts(int manufacturerId, int roleCategoryId) async {
    try {
      dio.Response response = await service
          .get('${Links.productListUrl}?manufacturerId=$manufacturerId&manufactureRoleCategoryId=$roleCategoryId');
      if (response.data != null) {
        return ProductListModel.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ProfileSectionResponse?> getProfileSection() async {
    try {
      dio.Response response = await service.get(Links.profileSectionUrl);
      if (response.data != null) {
        return ProfileSectionResponse.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ProfileRoleSectionResponse?> getProfileRoleSection() async {
    try {
      dio.Response response = await service.get(Links.getProfileRoleUrl);
      if (response.data != null) {
        return ProfileRoleSectionResponse.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ProfileSubRoleSectionResponse?> getProfileSubRoleSection(dynamic roleId) async {
    try {
      dio.Response response = await service.get(Links.getProfileRoleUrl + "/"+roleId.toString()+"");
      if (response.data != null) {
        return ProfileSubRoleSectionResponse.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<CompletenessProfileSectionResponse?> getCompletenessProfileSection(int manufacturerId, int? roleId, int? roleCategoryId) async {
    try {
      SharedPreferenceService preferenceService =
      Get.find<SharedPreferenceService>();
      preferenceService.setInt(TextConst.manufacturer_id, manufacturerId);
      dio.Response response = await service.get(Links.getProfileSectionUrl+"?manufacturerId="+manufacturerId.toString()+"&roleId="+(roleId == 0 ? "" :roleId.toString())+"&roleCategoryId="+(roleCategoryId == 0 ? "" :roleCategoryId.toString()));
      if (response.data != null) {
        return CompletenessProfileSectionResponse.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

}