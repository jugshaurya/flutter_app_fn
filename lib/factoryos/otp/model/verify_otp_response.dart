class VerifyOtpResponse {
  int? status;
  String? message;
  Data? data;
  String? timeStamp;
  bool? sucess;

  VerifyOtpResponse(
      {this.status, this.message, this.data, this.timeStamp, this.sucess});

  VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    timeStamp = json['timeStamp'];
    sucess = json['sucess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['timeStamp'] = this.timeStamp;
    data['sucess'] = this.sucess;
    return data;
  }
}

class Data {
  String? countryCode;
  String? token;

  Data({this.countryCode, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countryCode'] = countryCode;
    data['token'] = token;
    return data;
  }
}
