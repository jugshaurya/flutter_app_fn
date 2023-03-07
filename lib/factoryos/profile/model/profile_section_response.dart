class ProfileSectionResponse {
  int? statusCode;
  ProfileSectionModel? profileSection;
  String? message;

  ProfileSectionResponse({this.statusCode, this.profileSection, this.message});

  ProfileSectionResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    profileSection = json['data'] != null ? ProfileSectionModel.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (profileSection != null) {
      data['data'] = profileSection!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class ProfileSectionModel {
  List<ProfileSections>? profileSections;

  ProfileSectionModel({this.profileSections});

  ProfileSectionModel.fromJson(Map<String, dynamic> json) {
    if (json['profileSections'] != null) {
      profileSections = <ProfileSections>[];
      json['profileSections'].forEach((v) {
        profileSections!.add(ProfileSections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profileSections != null) {
      data['profileSections'] =
          profileSections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileSections {
  int? id;
  String? name;
  String? description;
  int? sortOrder;

  ProfileSections({this.id, this.name, this.description, this.sortOrder});

  ProfileSections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    sortOrder = json['sortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['sortOrder'] = sortOrder;
    return data;
  }
}