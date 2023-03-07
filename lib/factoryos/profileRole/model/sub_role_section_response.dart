class ProfileSubRoleSectionResponse {
  int? statusCode;
  ProfileSubRoleSectionModel? profileSubRoleSection;
  String? message;

  ProfileSubRoleSectionResponse({this.statusCode, this.profileSubRoleSection, this.message});

  ProfileSubRoleSectionResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    profileSubRoleSection = json['data'] != null ? ProfileSubRoleSectionModel.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (profileSubRoleSection != null) {
      data['data'] = profileSubRoleSection!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class ProfileSubRoleSectionModel {
  List<ProfileSubRoleSections>? manufacturerRoleCategory;

  ProfileSubRoleSectionModel({this.manufacturerRoleCategory});

  ProfileSubRoleSectionModel.fromJson(Map<String, dynamic> json) {
    if (json['manufacturerRoleCategory'] != null) {
      manufacturerRoleCategory = <ProfileSubRoleSections>[];
      json['manufacturerRoleCategory'].forEach((v) {
        manufacturerRoleCategory!.add(ProfileSubRoleSections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (manufacturerRoleCategory != null) {
      data['manufacturerRoleCategory'] =
          manufacturerRoleCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileSubRoleSections {
  int? id;
  String? name;

  ProfileSubRoleSections({this.id, this.name});

  ProfileSubRoleSections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}