import 'package:fs_app/factoryos/inventory/inventory_dashboard_repo.dart';
import 'package:fs_app/factoryos/inventory/model/product_list_model.dart';
import 'package:fs_app/factoryos/inventory/model/product_stat_response.dart';
import 'package:get/get.dart';

import '../../constant/text_const.dart';
import '../../services/shared_preference_service.dart';


class InventoryDashboardController extends GetxController {
  InventoryDashboardRepo repository = Get.find<InventoryDashboardRepo>();
  SharedPreferenceService preferenceService =
  Get.find<SharedPreferenceService>();

  RxBool isLoading = false.obs;
  RxList<ProductData?> productList = <ProductData>[].obs;

  // Rx<ProductStat?> productStat = (null as ProductStat?).obs;
  RxMap<String, dynamic> productStat = <String, dynamic>{}.obs;

  Future<void> getProducts(int manufacturerId, int roleCategoryId) async {
    try {
      isLoading.value = true;
      ProductListModel? productListModel =
          await repository.getProducts(manufacturerId, roleCategoryId);
      if (productListModel != null && productListModel.status == 200) {
        productList.value = productListModel.product ?? [];
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> getProductStat(int manufacturerId, int roleCateogyId) async {
    ProductStatResponse? productStatResponse =
        await repository.getProductStat(manufacturerId, roleCateogyId);
    if (productStatResponse != null && productStatResponse.status == 200) {
      productStat.value = productStatResponse.data!;
    }
  }
}
