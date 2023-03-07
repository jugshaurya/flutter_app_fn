import 'package:fs_app/factoryos/dashboard/dashboard_screen.dart';
import 'package:fs_app/factoryos/factory/factory_screen.dart';
import 'package:fs_app/factoryos/factoryDashboard/factoryDashboard_repo.dart';
import 'package:fs_app/factoryos/factoryDashboard/factoryDashboard_screen.dart';
import 'package:fs_app/factoryos/factoryList/factoryList_screen.dart';
import 'package:fs_app/factoryos/factoryTimeline/factoryTimeline_screen.dart';
import 'package:fs_app/factoryos/inventory/inventory_dashboard_screen.dart';
import 'package:fs_app/factoryos/inventory/product/create_custom_field_screen.dart';
import 'package:fs_app/factoryos/inventory/product/custom_field_list.dart';
import 'package:fs_app/factoryos/inventory/product/product_screen.dart';
import 'package:fs_app/factoryos/inventory/product/product_segment_screen.dart';
import 'package:fs_app/factoryos/inventory/product/product_success_screen.dart';
import 'package:fs_app/factoryos/onboarding/onboarding_screen.dart';
import 'package:fs_app/factoryos/otp/otpverfication_screen.dart';
import 'package:fs_app/factoryos/profile/profile_page.dart';
import 'package:fs_app/factoryos/profile/successScreens/profile_success_screen.dart';
import 'package:fs_app/factoryos/profileRole/profile_role_2_screen.dart';
import 'package:fs_app/factoryos/profileRole/profile_role_screen.dart';
import 'package:fs_app/factoryos/splash/SplashScreen.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:get/get.dart';

import '../factoryos/login/login_screen.dart';

class AppPages {
  static List<GetPage> routes = [
    GetPage(
        name: AppRoute.splashScreen,
        page: () => const SplashScreen(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: AppRoute.onboarding,
        page: () => OnboardingScreen(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: AppRoute.login,
        page: () => LoginScreen(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: AppRoute.verification,
        page: () => OtpVerificationScreen(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: AppRoute.profile,
        page: () => ProfilePage(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: AppRoute.dashboard,
        page: () => DashboardScreen(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: AppRoute.factoryDashboard,
        page: () => FactoryDashboardScreen(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: AppRoute.inventory,
        page: () => const InventoryDashboardScreen(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: AppRoute.product,
        page: () => const ProductScreen(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: AppRoute.productSegment,
        page: () => const ProductSegmentScreen(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: AppRoute.productSuccess,
        page: () => const ProductSuccessScreen(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: AppRoute.createField,
        page: () => const CreateCustomField(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: AppRoute.createFieldList,
        page: () => const CustomFieldList(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: AppRoute.profileRoleScreen,
        page: () => ProfileRolePage(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: AppRoute.profileRole2Screen,
        page: () => ProfileRolePage2(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: AppRoute.factoryPage,
        page: () => FactoryScreen(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: AppRoute.factoryList,
        page: () => FactoryListScreen(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: AppRoute.factoryTimeline,
        page: () => FactoryTimelineScreen(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: AppRoute.profileSuccessScreen,
        page: () => ProfileSuccessScreen(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(seconds: 1))
  ];
}
