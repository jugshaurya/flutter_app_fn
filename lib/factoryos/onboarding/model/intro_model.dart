import '../../../constant/img_const.dart';

class IntroModel {
  String? heading;
  String? description;
  String? imageUrl;
  int? sortOrder;

  IntroModel({this.heading, this.description, this.imageUrl, this.sortOrder});



  IntroModel.fromJson(Map<String, dynamic> json) {
    sortOrder = json['sortOrder'];
    heading = json['heading'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    if(json['imageUrl'] == null){
      switch(json["sortOrder"]){
        case 1:
          imageUrl = ImageConst.onboarding1;
          break;
        case 2:
          imageUrl = ImageConst.onboarding2;
          break;
        case 3:
          imageUrl = ImageConst.onboarding3;
          break;
        case 4:
          imageUrl = ImageConst.onboarding4;
          break;
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sortOrder'] = this.sortOrder;
    data['heading'] = this.heading;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    if(data['imageUrl'] == null){
      switch(data["sortOrder"]){
        case 1:
          data["imageUrl"] = ImageConst.onboarding1;
          break;
        case 2:
          data["imageUrl"] = ImageConst.onboarding2;
          break;
        case 3:
          data["imageUrl"] = ImageConst.onboarding3;
          break;
      }
    }
    return data;
  }
}
