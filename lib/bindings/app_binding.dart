import 'package:fs_app/factoryos/dashboard/dashboard_controller.dart';
import 'package:fs_app/factoryos/dashboard/dashboard_repo.dart';
import 'package:fs_app/factoryos/factory/factory_controller.dart';
import 'package:fs_app/factoryos/factory/factory_repo.dart';
import 'package:fs_app/factoryos/factoryDashboard/factoryDashboard_controller.dart';
import 'package:fs_app/factoryos/factoryDashboard/factoryDashboard_repo.dart';
import 'package:fs_app/factoryos/factoryList/factoryList_controller.dart';
import 'package:fs_app/factoryos/factoryList/factoryList_repo.dart';
import 'package:fs_app/factoryos/factoryTimeline/factoryTimeline_controller.dart';
import 'package:fs_app/factoryos/factoryTimeline/factoryTimeline_repo.dart';
import 'package:fs_app/factoryos/inventory/inventory_dashboard_controller.dart';
import 'package:fs_app/factoryos/inventory/inventory_dashboard_repo.dart';
import 'package:fs_app/factoryos/inventory/product/product_controller.dart';
import 'package:fs_app/factoryos/inventory/product/product_repo.dart';
import 'package:fs_app/factoryos/login/login_controller.dart';
import 'package:fs_app/factoryos/onboarding/onboarding_controller.dart';
import 'package:fs_app/factoryos/onboarding/onboarding_repo.dart';
import 'package:fs_app/factoryos/otp/otpverfication_controller.dart';
import 'package:fs_app/factoryos/profile/profile_controller.dart';
import 'package:fs_app/factoryos/profile/profile_repo.dart';
import 'package:fs_app/factoryos/profileRole/profile_role_controller.dart';
import 'package:fs_app/factoryos/profileRole/profile_role_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../factoryos/profile/widget/fs_gst_controller.dart';
import '../factoryos/profile/widget/fs_gst_repo.dart';
import '../services/network_service.dart';
import '../services/shared_preference_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    //Controller binding
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<OnBoardingController>(() => OnBoardingController(),
        fenix: true);
    Get.lazyPut<OtpVerificationController>(() => OtpVerificationController(),
        fenix: true);
    Get.lazyPut<DashboardController>(() => DashboardController(), fenix: true);
    Get.lazyPut<FactoryDashboardController>(() => FactoryDashboardController(), fenix: true);

    Get.lazyPut<ProfileRoleController>(() => ProfileRoleController(),
        fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<ProductController>(() => ProductController(), fenix: true);
    Get.lazyPut<InventoryDashboardController>(() => InventoryDashboardController(), fenix: true);
    Get.lazyPut<GSTController>(() => GSTController(), fenix: true);
    //Repository binding
    Get.lazyPut<GSTDetailsRepo>(() => GSTDetailsRepo(), fenix: true);

    Get.lazyPut<FactoryController>(() => FactoryController(), fenix: true);
    Get.lazyPut<FactoryRepo>(() => FactoryRepo(), fenix: true);
    Get.lazyPut<FactoryListController>(() => FactoryListController(), fenix: true);
    Get.lazyPut<FactoryListRepo>(() => FactoryListRepo(), fenix: true);

    Get.lazyPut<FactoryTimelineController>(() => FactoryTimelineController(), fenix: true);
    Get.lazyPut<FactoryTimelineRepo>(() => FactoryTimelineRepo(), fenix: true);

    //Repository binding
    Get.lazyPut<OnBoardingRepository>(() => OnBoardingRepository(),
        fenix: true);
    Get.lazyPut<DashboardRepo>(() => DashboardRepo(), fenix: true);
    Get.lazyPut<FactoryDashboardRepo>(() => FactoryDashboardRepo(), fenix: true);

    Get.lazyPut<ProfileRoleRepository>(() => ProfileRoleRepository(),
        fenix: true);
    Get.lazyPut<ProfileRepo>(() => ProfileRepo(), fenix: true);
    Get.lazyPut<ProductRepo>(() => ProductRepo(), fenix: true);
    Get.lazyPut<InventoryDashboardRepo>(() => InventoryDashboardRepo(),
        fenix: true);

    // Utils binding
    Get.putAsync<SharedPreferences>(() async {
      return await SharedPreferences.getInstance();
    }, permanent: true);
    Get.lazyPut(() => SharedPreferences.getInstance(), fenix: true);

    //Services binding
    Get.lazyPut<SharedPreferenceService>(
        () => SharedPreferenceService(Get.find<SharedPreferences>()),
        fenix: true);
    Get.lazyPut<NetworkService>(
        () => NetworkService(Get.find<SharedPreferenceService>()),
        fenix: true);
  }
}
