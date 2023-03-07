import 'dart:ffi';

import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/dashboard/model/CompletenessResponse.dart';
import 'package:fs_app/factoryos/dashboard/model/UserProfileResponse.dart';
import 'package:fs_app/factoryos/factory/factory_repo.dart';
import 'package:fs_app/factoryos/factoryDashboard/factoryDashboard_repo.dart';
import 'package:fs_app/factoryos/inventory/model/product_list_model.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_response.dart';
import 'package:fs_app/factoryos/dashboard/model/section.dart';
import 'package:fs_app/factoryos/profileRole/model/role_section_response.dart';
import 'package:fs_app/factoryos/profileRole/model/sub_role_section_response.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../services/shared_preference_service.dart';

class FactoryController extends GetxController {
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
  FactoryRepo repository = Get.find<FactoryRepo>();
  SharedPreferenceService preferenceService =
  Get.find<SharedPreferenceService>();

  Future<void> getUserProfileDetails() async {
    isLoading.value = true;
    UserProfileResponse? userResponse = await repository.getUserProfile();
    if (userResponse != null && userResponse.status == 200) {
      userProfileResponse = userResponse;
      preferenceService.setString(
          TextConst.full_name, userProfileResponse!.userInfoModal!.fullName!);
    }
    isLoading.value = false;
  }
}
