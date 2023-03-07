class ProfileGetResponse {
  int? manufacturerId;
  int? profileSectionId;
  int? roleId;
  int? roleCategoryId;
  Map<String, dynamic>? data;

  ProfileGetResponse(
      {this.manufacturerId,
      this.profileSectionId,
      this.roleId,
      this.roleCategoryId,
      this.data});

  ProfileGetResponse.fromJson(Map<String, dynamic> json) {
    manufacturerId = json['manufacturerId'];
    profileSectionId = json['profileSectionId'];
    roleId = json['roleId'];
    roleCategoryId = json['roleCategoryId'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['manufacturerId'] = manufacturerId;
    data['profileSectionId'] = profileSectionId;
    data['roleId'] = roleId;
    data['roleCategoryId'] = roleCategoryId;
    /*if (this.data != null) {
      data['data'] = this.data!.toJson();
    }*/
    return data;
  }
}

class Data {
  Data.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}
