import 'package:dio/dio.dart' as dio;
import 'package:fs_app/factoryos/inventory/model/custom_field_response.dart';
import 'package:fs_app/factoryos/inventory/model/product_model.dart';
import 'package:fs_app/factoryos/inventory/model/product_response.dart';
import 'package:fs_app/factoryos/inventory/model/product_stat_response.dart';
import 'package:fs_app/services/links.dart';
import 'package:fs_app/services/network_service.dart';
import 'package:fs_app/utils/log.dart';
import 'package:get/get.dart';

class ProductRepo {
  NetworkService service = Get.find<NetworkService>();

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

  Future saveProduct({required Map<String, dynamic> params}) async {
    try {
      dio.Response response =
      await service.post(Links.addProductUrl, body: params);
      if (response.data != null) {
        return ProductResponse.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<List<CustomFields>?> getCustomFields(int manufacturerId) async {
    try {
      dio.Response response = await service
          .get('${Links.customFieldUrl}?manufacturerId=$manufacturerId');
      if (response.data != null && response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((i) => CustomFields.fromJson(i))
            .toList();
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future saveCustomField({required Map<String, dynamic> params}) async {
    try {
      dio.Response response =
          await service.post(Links.addCustomFieldUrl, body: params);
      if (response.data != null) {
        return CustomFieldResponse.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future deleteCustomField(CustomFields data) async {
    try {
      dio.Response response =
          await service.delete(Links.deleteCustomFieldUrl, body: data);
      if (response.data != null) {
        return CustomFieldResponse.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
