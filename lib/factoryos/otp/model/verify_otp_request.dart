class VerifyOtpRequest {
  int? manufacturerId;
  String? contactNo;
  String? countryCode;
  String? username;
  String? otp;
  String? verficationCode;

  VerifyOtpRequest(
      {this.manufacturerId,
        this.contactNo,
      this.countryCode,
      this.username,
      this.otp,
      this.verficationCode});

  VerifyOtpRequest.fromJson(Map<String, dynamic> json) {
    manufacturerId = json['manufacturerId'];
    contactNo = json['contactNo'];
    countryCode = json['countryCode'];
    username = json['username'];
    otp = json['otp'];
    verficationCode = json['verficationCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['manufacturerId'] = manufacturerId;
    data['contactNo'] = contactNo;
    data['countryCode'] = countryCode;
    data['username'] = username;
    data['otp'] = otp;
    data['verficationCode'] = verficationCode;
    return data;
  }
}
