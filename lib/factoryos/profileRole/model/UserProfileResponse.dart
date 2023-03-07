class UserProfileResponse {
  int? status;
  UserInfoModal? userInfoModal;
  String? message;

  UserProfileResponse({this.status, this.userInfoModal, this.message});

  UserProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userInfoModal = json['data'] != null ? UserInfoModal.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (userInfoModal != null) {
      data['data'] = userInfoModal!.toJson();
    }
    data['message'] = message;
    return data;
  }
}


class UserInfoModal {
  String? fullName;
  String? profileLink;
  String? phoneNumber;
  int? manufactureId;

  UserInfoModal({this.fullName, this.profileLink, this.phoneNumber, this.manufactureId});

  UserInfoModal.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    profileLink = json['profileLink'];
    phoneNumber = json['phoneNumber'];
    manufactureId = json['manufactureId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['profileLink'] = profileLink;
    data['phoneNumber'] = phoneNumber;
    data['manufactureId'] = manufactureId;
    return data;
  }
}