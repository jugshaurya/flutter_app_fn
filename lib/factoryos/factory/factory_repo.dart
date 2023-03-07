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


class FactoryRepo {
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


}