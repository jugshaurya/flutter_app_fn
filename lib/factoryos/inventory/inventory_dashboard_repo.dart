import 'package:dio/dio.dart' as dio;
import 'package:fs_app/factoryos/inventory/model/product_list_model.dart';
import 'package:fs_app/factoryos/inventory/model/product_stat_response.dart';
import 'package:fs_app/services/links.dart';
import 'package:fs_app/services/network_service.dart';
import 'package:get/get.dart';

class InventoryDashboardRepo {
  NetworkService service = Get.find<NetworkService>();

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

  Future<ProductStatResponse?> getProductStat(int manufacturerId, int manufactureRoleCategoryId) async {
    try {
      dio.Response response = await service
          .get('${Links.productStatUrl}?manufacturerId=$manufacturerId&manufactureRoleCategoryId=$manufactureRoleCategoryId');
      if (response.data != null) {
        return ProductStatResponse.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
