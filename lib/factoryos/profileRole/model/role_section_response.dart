class ProfileRoleSectionResponse {
  int? statusCode;
  ProfileRoleSectionModel? profileRoleSection;
  String? message;

  ProfileRoleSectionResponse({this.statusCode, this.profileRoleSection, this.message});

  ProfileRoleSectionResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    profileRoleSection = json['data'] != null ? ProfileRoleSectionModel.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (profileRoleSection != null) {
      data['data'] = profileRoleSection!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class ProfileRoleSectionModel {
  List<ProfileRoleSections>? manufacturerRoles;

  ProfileRoleSectionModel({this.manufacturerRoles});

  ProfileRoleSectionModel.fromJson(Map<String, dynamic> json) {
    if (json['manufacturerRoles'] != null) {
      manufacturerRoles = <ProfileRoleSections>[];
      json['manufacturerRoles'].forEach((v) {
        manufacturerRoles!.add(ProfileRoleSections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (manufacturerRoles != null) {
      data['manufacturerRoles'] =
          manufacturerRoles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileRoleSections {
  int? id;
  String? name;

  ProfileRoleSections({this.id, this.name});

  ProfileRoleSections.fromJson(Map<String, dynamic> json) {
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