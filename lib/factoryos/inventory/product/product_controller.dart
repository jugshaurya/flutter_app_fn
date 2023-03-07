import 'dart:convert';

import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/inventory/model/custom_field_response.dart';
import 'package:fs_app/factoryos/inventory/model/product_model.dart';
import 'package:fs_app/factoryos/inventory/model/product_response.dart';
import 'package:fs_app/factoryos/inventory/product/product_repo.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_attr_response.dart';
import 'package:fs_app/factoryos/profile/profile_repo.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:fs_app/utils/app_utils.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  ProductRepo repository = Get.find<ProductRepo>();
  SharedPreferenceService preferenceService = Get.find<SharedPreferenceService>();

  RxBool isLoading = false.obs;
  Rx<Product?> product = (null as Product?).obs;
  Rx<dynamic> productRes = (null as ProductRes?).obs;
  // RxMap<String, dynamic> productRes = <String, dynamic>{}.obs;
  RxList<CustomFields?> customFieldList = <CustomFields>[].obs;
  RxList<ProfileSectionsAttributes?> profileSectionAttrList =
      <ProfileSectionsAttributes>[].obs;
  ProfileRepo profileRepository = Get.find<ProfileRepo>();


  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getProducts(int manufacturerId, int roleCategoryId) async {
    isLoading.value = true;
    ProductModel? productModel = await repository.getProducts(manufacturerId, roleCategoryId);
    if (productModel != null) {
      product.value = productModel.data;
    }
    isLoading.value = false;
  }

  Future<bool> saveProduct(
    Map<String, dynamic> data,
  ) async {
    try {
      isLoading.value = true;
      ProductResponse response = await repository.saveProduct(params: data);
      if (response.status == 200) {
        preferenceService.setString(TextConst.activeProductDetail, jsonEncode(response.data!));
        productRes.value = response.data!;
        AppUtils.bottomSnackbar(
            "Message", response.message ?? "Product saved successfully");
        isLoading.value = false;
        return true;
      } else {
        isLoading.value = false;
        AppUtils.bottomSnackbar(
            "Message", response.message ?? "Error while saving product");
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }

  Future<void> getProfileSectionAttributes(int roleId, int profileSectionId) async {
    ProfileSectionAttrResponse? profileSectionAttrResponse =
    await profileRepository.getProfileSectionAttributes(roleId, profileSectionId);
    if (profileSectionAttrResponse != null) {
      profileSectionAttrList.value = profileSectionAttrResponse
          .profileSectionAttr!.profileSectionsAttributes!;
    }
  }

  Future<void> getCustomFields(int manufacturerId) async {
    isLoading.value = true;
    List<CustomFields>? customFields = await repository.getCustomFields(manufacturerId);
    if (customFields != null) {
      customFieldList.value = customFields;
      isLoading.value = false;
    }
  }

  Future<bool> saveCustomFields(
    Map<String, dynamic> data,
  ) async {
    CustomFieldResponse response =
        await repository.saveCustomField(params: data);
    if (response != null && response.status == 200) {
      if (response.data != null) {
        await getCustomFields(response.data!.manufacturerId!);
      }

      /*Future.delayed(const Duration(seconds: 500)).then((value) {
        AppUtils.bottomSnackbar(
            "Message", response.message ?? "Field saved successfully");
      });*/

      return true;
    }
    return false;
  }

  Future<bool> deleteCustomFields(CustomFields data) async {
    CustomFieldResponse response = await repository.deleteCustomField(data);
    if (response != null && response.status == 200) {
      AppUtils.bottomSnackbar(
          "Message", response.message ?? "Field deleted successfully");

      if (response.data != null) {
        await getCustomFields(response.data!.manufacturerId!);
      }

      return true;
    }
    return false;
  }

  @override
  void dispose() {
    super.dispose();
    isLoading.value = false;
    product.value = null;
    customFieldList.clear();
  }
}
