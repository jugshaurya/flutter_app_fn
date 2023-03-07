import 'package:fs_app/factoryos/onboarding/model/intro_model.dart';

class IntroModelResponse {
  int? status;
  Data? data;

  IntroModelResponse({this.status, this.data});

  IntroModelResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<IntroModel>? onBoardingSteps;

  Data({this.onBoardingSteps});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['onBoardingSteps'] != null) {
      onBoardingSteps = <IntroModel>[];
      json['onBoardingSteps'].forEach((v) {
        onBoardingSteps!.add(IntroModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (onBoardingSteps != null) {
      data['onBoardingSteps'] =
          onBoardingSteps!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
