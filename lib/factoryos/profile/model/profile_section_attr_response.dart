class ProfileSectionAttrResponse {
  int? statusCode;
  ProfileSectionAttrModel? profileSectionAttr;
  String? message;

  ProfileSectionAttrResponse({statusCode, data, message});

  ProfileSectionAttrResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    profileSectionAttr = json['data'] != null
        ? ProfileSectionAttrModel.fromJson(json['data'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (profileSectionAttr != null) {
      data['data'] = profileSectionAttr!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class ProfileSectionAttrModel {
  List<ProfileSectionsAttributes>? profileSectionsAttributes;

  ProfileSectionAttrModel({this.profileSectionsAttributes});

  ProfileSectionAttrModel.fromJson(Map<String, dynamic> json) {
    if (json['profileSectionsAttributes'] != null) {
      profileSectionsAttributes = <ProfileSectionsAttributes>[];
      json['profileSectionsAttributes'].forEach((v) {
        profileSectionsAttributes!.add(ProfileSectionsAttributes.fromJson(v));
      });
      profileSectionsAttributes!
          .sort((obj1, obj2) => obj1.sortOrder!.compareTo(obj2.sortOrder!));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profileSectionsAttributes != null) {
      data['profileSectionsAttributes'] =
          profileSectionsAttributes!.map((v) => v.toJson()).toList();
      profileSectionsAttributes!
          .sort((obj1, obj2) => obj1.sortOrder!.compareTo(obj2.sortOrder!));
    }
    return data;
  }
}

class ProfileSectionsAttributes {
  int? id;
  String? name;
  int? sortOrder;
  bool? isMandatory;
  String? fieldType;
  List<ProfileSectionsAttributeValues>? profileSectionsAttributeValues;

  ProfileSectionsAttributes(
      {this.id,
      this.name,
      this.sortOrder,
      this.isMandatory,
      this.fieldType,
      this.profileSectionsAttributeValues});

  ProfileSectionsAttributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sortOrder = json['sortOrder'];
    isMandatory = json['isMandatory'];
    fieldType = json['fieldType'];
    if (json['profileSectionsAttributeValues'] != null) {
      profileSectionsAttributeValues = <ProfileSectionsAttributeValues>[];
      json['profileSectionsAttributeValues'].forEach((v) {
        profileSectionsAttributeValues!
            .add(ProfileSectionsAttributeValues.fromJson(v));
      });
      profileSectionsAttributeValues!
          .sort((obj1, obj2) => obj1.sortOrder!.compareTo(obj2.sortOrder!));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sortOrder'] = sortOrder;
    data['isMandatory'] = isMandatory;
    data['fieldType'] = fieldType;
    if (profileSectionsAttributeValues != null) {
      data['profileSectionsAttributeValues'] =
          profileSectionsAttributeValues!.map((v) => v.toJson()).toList();
      profileSectionsAttributeValues!
          .sort((obj1, obj2) => obj1.sortOrder!.compareTo(obj2.sortOrder!));
    }
    return data;
  }
}

class ProfileSectionsAttributeValues {
  int? id;
  String? name;
  int? sortOrder;
  bool isSelected = false;

  ProfileSectionsAttributeValues({this.id, this.name, this.sortOrder, this.isSelected = false});

  ProfileSectionsAttributeValues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sortOrder = json['sortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sortOrder'] = sortOrder;
    return data;
  }
}
