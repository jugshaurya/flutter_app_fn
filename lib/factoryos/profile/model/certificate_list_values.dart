class CertificateSectionsAttributes {
  int? id;
  String? name;
  int? sortOrder;
  bool? isMandatory;
  String? fieldType;
  List<CertificateListValues>? certificateListValues;

  CertificateSectionsAttributes(
      {this.id,
        this.name,
        this.sortOrder,
        this.isMandatory,
        this.fieldType,
        this.certificateListValues});

  CertificateSectionsAttributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sortOrder = json['sortOrder'];
    isMandatory = json['isMandatory'];
    fieldType = json['fieldType'];
    if (json['certificateListValues'] != null) {
      certificateListValues = <CertificateListValues>[];
      json['profileSectionsAttributeValues'].forEach((v) {
        certificateListValues!
            .add(CertificateListValues.fromJson(v));
      });
      certificateListValues!
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
    if (certificateListValues != null) {
      data['profileSectionsAttributeValues'] =
          certificateListValues!.map((v) => v.toJson()).toList();
      certificateListValues!
          .sort((obj1, obj2) => obj1.sortOrder!.compareTo(obj2.sortOrder!));
    }
    return data;
  }

  static CertificateSectionsAttributes getCertificateAttribute(){
     CertificateSectionsAttributes certificateSectionsAttributes = CertificateSectionsAttributes(
         id: 1,
         name: "Certificates",
         sortOrder: 4,
       isMandatory: false,
       fieldType: "upload",
       certificateListValues: CertificateListValues.getCertificateList()
     );
     return certificateSectionsAttributes;
  }
}


class CertificateListValues {
  int? id;
  String? name;
  String? fileName;
  int? sortOrder;
  bool isSelected = false;

  CertificateListValues({this.id, this.name,this.fileName, this.sortOrder, this.isSelected = false});

  CertificateListValues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fileName = json['fileName'];
    sortOrder = json['sortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['fileName'] = fileName;
    data['sortOrder'] = sortOrder;
    return data;
  }

  static List<CertificateListValues> getCertificateList(){
    // List<Section> detailList = [];
    // SectionList.asMap().forEach((index, value){
    //
    //      detailList.add(Section(
    //                     iconPath:getIconPath(index),
    //                     bgColor: ColorConst.shadowWhite,
    //                     btnTextStyle: "labelWhite12",
    //                     title: getTitle(index),
    //                     subTitle: getSubTitle(index),
    //                     done: false,
    //                     isFirst: index == 0,
    //                     action: getAction(index)
    //             ));
    // });
    // return detailList;
    //SEDEX, WRAP, BSI, GOTS, FAMA, BCI, TARGET, GAP, Others
    return [
      CertificateListValues(
        id: 1,
        name: "SEDEX",
        sortOrder: 1,
        isSelected: false
      ),
      CertificateListValues(
          id: 2,
          name: "WRAP",
          sortOrder: 2,
          isSelected: false
      ),
      CertificateListValues(
          id: 3,
          name: "BSI",
          sortOrder: 3,
          isSelected: false
      ),
      CertificateListValues(
          id: 4,
          name: "GOTS",
          sortOrder: 4,
          isSelected: false
      ),
      CertificateListValues(
          id: 5,
          name: "FAMA",
          sortOrder: 5,
          isSelected: false
      ),
      CertificateListValues(
          id: 6,
          name: "BCI",
          sortOrder: 6,
          isSelected: false
      ),
      CertificateListValues(
          id: 7,
          name: "TARGET",
          sortOrder: 7,
          isSelected: false
      ),
      CertificateListValues(
          id: 8,
          name: "GAP",
          sortOrder: 8,
          isSelected: false
      ),
      CertificateListValues(
          id: 9,
          name: "Others",
          sortOrder: 9,
          isSelected: false
      ),
    ];
  }
}


