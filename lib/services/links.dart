class Links {
  static const String authenticate =
      'cravex-admin-service/creator/authenticate';
  static const String onboarding = 'fs-onboarding-service/onboarding/data?ln=1';
  static const String request_otp = 'fs-login-service/user/requestOtp';
  static const String verify_otp = 'fs-login-service/user/verifyOtp';

  // static const String profileSectionUrl = 'fs-static-profile-service/staticProfile/profileSections';
  static const String userProfileUrl = 'fs-login-service/user/profile';
  static const String termsCondition =
      'https://images.konnectbox.in/cravex-app/login/terms.html';

  //Profile
  static const String userInfoUrl = 'fs-login-service/user/profile';
  static const String userUpdateUrl = 'fs-login-service/user/profile/updateName';

  static const String profileSectionUrl =
      'fs-static-profile-service/staticProfile/profileSections';
  static const String profileSectionAttributesUrl =
      'fs-static-profile-service/staticProfile/profileSectionAttributes';
  static const String saveProfileSectionUrl =
      "fs-profile-set-service/profile/section";
  static const String getProfileSectionUrl =
      "fs-profile-set-service/profile/completeness";
  static const String getProfileRoleUrl =
      "fs-static-profile-service/staticProfile/role";
  static const String getGSTDetailsUrl="fs-profile-set-service/profile/gstDetails/";

  //Products
  static const String productUrl =
      'product-inventory/product-attributes/getProductAttributes';
  static const String productStatUrl = 'product-inventory/product/get-product-stats';
  static const String addProductUrl = 'product-inventory/product/add';
  static const String productListUrl = 'product-inventory/product/list';
  static const String customFieldUrl =
      'product-inventory/custom-attributes/list';
  static const String addCustomFieldUrl =
      'product-inventory/custom-attributes/add';
  static const String deleteCustomFieldUrl =
      'product-inventory/custom-attributes/delete';

}
