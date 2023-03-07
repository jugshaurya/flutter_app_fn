class OTPRequest {
  String? contactNo;
  String? userName;

  OTPRequest(
      {this.contactNo,
        this.userName});

  OTPRequest.fromJson(Map<String, dynamic> json) {
    contactNo = json['contactNo'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contactNo'] = contactNo;
    data['userName'] = userName;
    return data;
  }
}
