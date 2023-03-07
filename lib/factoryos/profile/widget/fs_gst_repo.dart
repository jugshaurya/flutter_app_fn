import 'package:dio/dio.dart' as dio;
import 'package:fs_app/services/links.dart';
import 'package:fs_app/services/network_service.dart';
import 'package:get/get.dart';

import '../model/gst_details_response.dart';

class GSTDetailsRepo {
  NetworkService service = Get.find<NetworkService>();

  Future<GSTDetailsResponse?> getGSTDetails(gstNumber) async {
    try {
      dio.Response response = await service.get(Links.getGSTDetailsUrl+""+gstNumber);
      if (response.data != null) {
        return GSTDetailsResponse.fromJson(response.data["data"]);
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
