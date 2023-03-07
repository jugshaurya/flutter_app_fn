class GSTDetailsResponse {
  String? companyName;
  String? companyAddress;

  GSTDetailsResponse(
      {this.companyName,
        this.companyAddress,
      });

  GSTDetailsResponse.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    companyAddress = json['companyAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['companyName'] = companyName;
    data['companyAddress'] = companyAddress;
    return data;
  }
}

