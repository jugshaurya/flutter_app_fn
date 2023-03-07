import 'package:fs_app/factoryos/inventory/model/product_model.dart';

class CustomFieldResponse {
  int? status;
  String? message;
  CustomFields? data;
  String? timeStamp;
  bool? sucess;

  CustomFieldResponse(
      {this.status, this.message, this.data, this.timeStamp, this.sucess});

  CustomFieldResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CustomFields.fromJson(json['data']) : null;
    timeStamp = json['timeStamp'];
    sucess = json['sucess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['timeStamp'] = timeStamp;
    data['sucess'] = sucess;
    return data;
  }
}
