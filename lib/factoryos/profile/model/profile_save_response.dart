class ProfileSaveResponse {
  int? status;
  String? message;
  // ProfileSection? data;
  bool? success;

  ProfileSaveResponse({this.status, this.message, /*this.data, */this.success});

  ProfileSaveResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    // data = json['data'] != null ? ProfileSection.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    /*if (this.data != null) {
      data['data'] = this.data!.toJson();
    }*/
    data['success'] = success;
    return data;
  }
}

class ProfileSection {
  int? profileSectionId;
  int? statusId;
  SectionDetailsJson? sectionDetailsJson;
  Null? insertedOn;
  String? updatedOn;
  int? manufacturerId;
  int? manufactureRoleId;
  int? manufactureRoleCategoryId;
  int? id;

  ProfileSection(
      {this.profileSectionId,
        this.statusId,
        this.sectionDetailsJson,
        this.insertedOn,
        this.updatedOn,
        this.manufacturerId,
        this.manufactureRoleId,
        this.manufactureRoleCategoryId,
        this.id});

  ProfileSection.fromJson(Map<String, dynamic> json) {
    profileSectionId = json['profileSectionId'];
    statusId = json['statusId'];
    sectionDetailsJson = json['sectionDetailsJson'] != null
        ? SectionDetailsJson.fromJson(json['sectionDetailsJson'])
        : null;
    insertedOn = json['insertedOn'];
    updatedOn = json['updatedOn'];
    manufacturerId = json['manufacturerId'];
    manufactureRoleId = json['manufactureRoleId'];
    manufactureRoleCategoryId = json['manufactureRoleCategoryId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profileSectionId'] = profileSectionId;
    data['statusId'] = statusId;
    if (sectionDetailsJson != null) {
      data['sectionDetailsJson'] = sectionDetailsJson!.toJson();
    }
    data['insertedOn'] = insertedOn;
    data['updatedOn'] = updatedOn;
    data['manufacturerId'] = manufacturerId;
    data['manufactureRoleId'] = manufactureRoleId;
    data['manufactureRoleCategoryId'] = manufactureRoleCategoryId;
    data['id'] = id;
    return data;
  }
}

class SectionDetailsJson {
  String? s1;
  String? s2;
  String? s4;

  SectionDetailsJson({this.s1, this.s2, this.s4});

  SectionDetailsJson.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
    s2 = json['2'];
    s4 = json['4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['1'] = s1;
    data['2'] = s2;
    data['4'] = s4;
    return data;
  }
}