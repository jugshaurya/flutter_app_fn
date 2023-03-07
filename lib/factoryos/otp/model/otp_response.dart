class OtpResponse {
  int? status;
  String? message;
  String? data;
  String? timeStamp;
  bool? sucess;

  OtpResponse(
      {this.status, this.message, this.data, this.timeStamp, this.sucess});

  OtpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
    timeStamp = json['timeStamp'];
    sucess = json['sucess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = data;
    data['timeStamp'] = timeStamp;
    data['sucess'] = sucess;
    return data;
  }
}
