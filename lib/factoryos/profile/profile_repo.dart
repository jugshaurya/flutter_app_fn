import 'package:dio/dio.dart' as dio;
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/inventory/model/product_model.dart';
import 'package:fs_app/factoryos/profile/model/profile_get_response.dart';
import 'package:fs_app/factoryos/profile/model/profile_save_response.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_attr_response.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_response.dart';
import 'package:fs_app/factoryos/profileRole/model/CompletenessResponse.dart';
import 'package:fs_app/services/links.dart';
import 'package:fs_app/services/network_service.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:fs_app/utils/log.dart';
import 'package:get/get.dart';

class ProfileRepo {
  NetworkService service = Get.find<NetworkService>();

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

  Future<ProductModel?> getProducts(int manufacturerId, int roleCategoryId) async {
    try {
      dio.Response response = await service
          .get('${Links.productUrl}?manufacturerId=$manufacturerId&manufactureRoleCategoryId=$roleCategoryId');
      if (response.data != null) {
        return ProductModel.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ProfileSectionAttrResponse?> getProfileSectionAttributes(
      int roleId, int sortId) async {
    try {
      dio.Response response = await service
          .get('${Links.profileSectionAttributesUrl}/$roleId/$sortId');
      if (response.data != null) {
        return ProfileSectionAttrResponse.fromJson(response.data);
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
        return ProfileSaveResponse.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<List<ProfileGetResponse>?> getProfileSections() async {
    try {
      SharedPreferenceService preferenceService =
      Get.find<SharedPreferenceService>();
      var manufacturerId = preferenceService.getInt(TextConst.manufacturer_id);
      var roleId = preferenceService.getInt(TextConst.manufacturer_role);
      var roleCategoryId = preferenceService.getInt(TextConst.manufacturer_sub_role);
      String urlString =
          '?manufacturerId=$manufacturerId&roleId=$roleId&roleCategoryId=$roleCategoryId';
      dio.Response response =
          await service.get(Links.getProfileSectionUrl + urlString);
      if (response.data != null && response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((i) => ProfileGetResponse.fromJson(i))
            .toList();
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
