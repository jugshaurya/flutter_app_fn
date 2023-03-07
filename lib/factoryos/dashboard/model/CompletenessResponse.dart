class CompletenessProfileSectionResponse {
  int? statusCode;
  List<dynamic>? completenessProfileSection;
  String? message;

  CompletenessProfileSectionResponse({this.statusCode, this.completenessProfileSection, this.message});

  CompletenessProfileSectionResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    completenessProfileSection = json['data'] != null ? json['data'] : null;
    message = json['message'];
  }
}

