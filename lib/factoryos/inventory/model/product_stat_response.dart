class ProductStatResponse {
  int? status;
  String? message;
  Map<String, dynamic>? data;
  String? timeStamp;
  bool? sucess;

  ProductStatResponse(
      {this.status, this.message, this.data, this.timeStamp, this.sucess});

  ProductStatResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    // data = json['data'] != null ? ProductStat.fromJson(json['data']) : null;
    data = json['data'];
    timeStamp = json['timeStamp'];
    sucess = json['sucess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    /*if (this.data != null) {
      data['data'] = this.data!.toJson();
    }*/
    data['data'] = this.data;
    data['timeStamp'] = timeStamp;
    data['sucess'] = sucess;
    return data;
  }
}

class ProductStat {
  int? totalAvailableStock;
  int? totalOutOfStock;
  int? totalLowStock;

  ProductStat(
      {this.totalAvailableStock, this.totalOutOfStock, this.totalLowStock});

  ProductStat.fromJson(Map<String, dynamic> json) {
    totalAvailableStock = json['totalAvailableStock'];
    totalOutOfStock = json['totalOutOfStock'];
    totalLowStock = json['totalLowStock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalAvailableStock'] = totalAvailableStock;
    data['totalOutOfStock'] = totalOutOfStock;
    data['totalLowStock'] = totalLowStock;
    return data;
  }
}
