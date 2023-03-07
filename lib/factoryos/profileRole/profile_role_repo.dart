import 'package:dio/dio.dart' as dio;
import 'package:fs_app/factoryos/otp/model/otrp_request.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_response.dart';
import 'package:fs_app/factoryos/profileRole/model/role_section_response.dart';
import 'package:fs_app/factoryos/profileRole/model/sub_role_section_response.dart';
import 'package:fs_app/services/links.dart';
import 'package:fs_app/services/network_service.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:get/get.dart';

import '../../constant/text_const.dart';
import '../dashboard/model/CompletenessResponse.dart';
import '../dashboard/model/UserProfileResponse.dart';

class ProfileRoleRepository {
  NetworkService service = Get.find<NetworkService>();
  SharedPreferenceService preferenceService =
  Get.find<SharedPreferenceService>();


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

  Future saveProfile({
    required int manufacturerId,
    required int profileSectionId,
    required int roleId,
    required int roleCategoryId,
    required Map<String, dynamic> data,
    required List<dynamic> garmentTypes
  }) async {
    Map<String, dynamic> params = {
      "manufacturerId": manufacturerId,
      "profileSectionId": profileSectionId,
      "roleId": roleId,
      "roleCategoryId": roleCategoryId,
      "garmentTypes": garmentTypes,
      "data": data
    };

    try {
      dio.Response response =
      await service.post(Links.saveProfileSectionUrl, body: params);
      if (response.data != null) {
        return true;
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

  Future<UserProfileResponse?> getUserProfile() async {
    try {
      SharedPreferenceService preferenceService =
      Get.find<SharedPreferenceService>();
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

  Future<UserProfileResponse?> updateUserName(OTPRequest otpRequest) async {
    try {
      var linksUrl = Links.userUpdateUrl;
      dio.Response response = await service.post(linksUrl, body:otpRequest);
      if (response.data != null) {
        return UserProfileResponse.fromJson(response.data);
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

  Future<CompletenessProfileSectionResponse?> getCompletenessProfileSubSection(String manufacturerId, int? roleId, int? roleCategoryId) async {
    try {
      SharedPreferenceService preferenceService =
      Get.find<SharedPreferenceService>();
      preferenceService.setString(TextConst.manufacturer_id, manufacturerId);
      dio.Response response = await service.get(Links.getProfileSectionUrl+"?manufacturerId="+manufacturerId.toString()+"&roleId="+(roleId == 0 ? "" :roleId.toString())+"&roleCategoryId="+(roleCategoryId == 0 ? "" :roleCategoryId.toString()));
      if (response.data != null) {
        return CompletenessProfileSectionResponse.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }


  Future<CompletenessProfileSectionResponse?> getCompletenessProfileSection(int manufacturerId) async {
    try {
      SharedPreferenceService preferenceService =
      Get.find<SharedPreferenceService>();
      preferenceService.setString(TextConst.manufacturer_id, manufacturerId.toString());
      dio.Response response = await service.get(Links.getProfileSectionUrl+"?manufacturerId="+manufacturerId.toString()+"&roleId=&roleCategoryId=");
      if (response.data != null) {
        return CompletenessProfileSectionResponse.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

}
