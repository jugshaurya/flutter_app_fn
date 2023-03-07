class ProductModel {
  int? status;
  String? message;
  Product? data;
  String? timeStamp;
  bool? sucess;

  ProductModel(
      {this.status, this.message, this.data, this.timeStamp, this.sucess});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Product.fromJson(json['data']) : null;
    timeStamp = json['timeStamp'];
    sucess = json['sucess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['timeStamp'] = timeStamp;
    data['sucess'] = sucess;
    return data;
  }
}

class Product {
  int? id;
  String? name;
  List<ProductTypeValues>? garmentTypeValues;
  List<ProductTypeValues>? segmentTypeValues;
  String? description;
  List<ProductTypeValues>? sizeValues;
  List<ProductTypeValues>? fabricValues;
  List<ProductTypeValues>? constructionValues;
  List<ProductTypeValues>? weightValues;
  List<ProductTypeValues>? trims;
  List<ProductTypeValues>? colorValues;
  String? colorCode;
  String? costing;
  List<ProductTypeValues>? unitMeasureValues;
  String? insertedOn;
  String? updatedOn;
  String? quantity;
  List<ProductTypeValues>? workflowValues;
  List<ProductTypeValues>? customizableValues;
  List<ProductTypeValues>? visibitlityValues;
  List<ProductTypeValues>? manufacturingStatusValues;
  String? image;
  List<CustomFields>? customFields;
  bool? mandatory;

  Product(
      {this.id,
      this.name,
      this.garmentTypeValues,
      this.segmentTypeValues,
      this.description,
      this.sizeValues,
      this.fabricValues,
      this.constructionValues,
      this.weightValues,
      this.trims,
      this.colorValues,
      this.colorCode,
      this.costing,
      this.unitMeasureValues,
      this.insertedOn,
      this.updatedOn,
      this.quantity,
      this.workflowValues,
      this.customizableValues,
      this.visibitlityValues,
      this.manufacturingStatusValues,
      this.image,
      this.customFields,
      this.mandatory});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['garmentTypeValues'] != null) {
      garmentTypeValues = <ProductTypeValues>[];
      json['garmentTypeValues'].forEach((v) {
        garmentTypeValues!.add(ProductTypeValues.fromJson(v));
      });
    }
    if (json['segmentTypeValues'] != null) {
      segmentTypeValues = <ProductTypeValues>[];
      json['segmentTypeValues'].forEach((v) {
        segmentTypeValues!.add(ProductTypeValues.fromJson(v));
      });
    }
    description = json['description'];
    if (json['sizeValues'] != null) {
      sizeValues = <ProductTypeValues>[];
      json['sizeValues'].forEach((v) {
        sizeValues!.add(ProductTypeValues.fromJson(v));
      });
    }
    if (json['fabricValues'] != null) {
      fabricValues = <ProductTypeValues>[];
      json['fabricValues'].forEach((v) {
        fabricValues!.add(ProductTypeValues.fromJson(v));
      });
    }
    if (json['constructionValues'] != null) {
      constructionValues = <ProductTypeValues>[];
      json['constructionValues'].forEach((v) {
        constructionValues!.add(ProductTypeValues.fromJson(v));
      });
    }
    if (json['weightValues'] != null) {
      weightValues = <ProductTypeValues>[];
      json['weightValues'].forEach((v) {
        weightValues!.add(ProductTypeValues.fromJson(v));
      });
    }
    if (json['trims'] != null) {
      trims = <ProductTypeValues>[];
      json['trims'].forEach((v) {
        trims!.add(ProductTypeValues.fromJson(v));
      });
    }
    /*trims = json['trims'];
    if (json['colorValues'] != null) {
      colorValues = <ProductTypeValues>[];
      json['colorValues'].forEach((v) {
        colorValues!.add(ProductTypeValues.fromJson(v));
      });
    }*/
    colorCode = json['colorCode'];
    costing = json['costing'];
    if (json['unitMeasureValues'] != null) {
      unitMeasureValues = <ProductTypeValues>[];
      json['unitMeasureValues'].forEach((v) {
        unitMeasureValues!.add(ProductTypeValues.fromJson(v));
      });
    }
    insertedOn = json['insertedOn'];
    updatedOn = json['updatedOn'];
    quantity = json['quantity'];
    if (json['workflowValues'] != null) {
      workflowValues = <ProductTypeValues>[];
      json['workflowValues'].forEach((v) {
        workflowValues!.add(ProductTypeValues.fromJson(v));
      });
    }
    if (json['customizableValues'] != null) {
      customizableValues = <ProductTypeValues>[];
      json['customizableValues'].forEach((v) {
        customizableValues!.add(ProductTypeValues.fromJson(v));
      });
    }
    if (json['visibitlityValues'] != null) {
      visibitlityValues = <ProductTypeValues>[];
      json['visibitlityValues'].forEach((v) {
        visibitlityValues!.add(ProductTypeValues.fromJson(v));
      });
    }
    if (json['manufacturingStatusValues'] != null) {
      manufacturingStatusValues = <ProductTypeValues>[];
      json['manufacturingStatusValues'].forEach((v) {
        manufacturingStatusValues!.add(ProductTypeValues.fromJson(v));
      });
    }
    image = json['image'];
    if (json['customFields'] != null) {
      customFields = <CustomFields>[];
      json['customFields'].forEach((v) {
        customFields!.add(CustomFields.fromJson(v));
      });
    }
    mandatory = json['mandatory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (garmentTypeValues != null) {
      data['garmentTypeValues'] =
          garmentTypeValues!.map((v) => v.toJson()).toList();
    }
    if (segmentTypeValues != null) {
      data['segmentTypeValues'] =
          segmentTypeValues!.map((v) => v.toJson()).toList();
    }
    data['description'] = description;
    if (sizeValues != null) {
      data['sizeValues'] = sizeValues!.map((v) => v.toJson()).toList();
    }
    if (fabricValues != null) {
      data['fabricValues'] = fabricValues!.map((v) => v.toJson()).toList();
    }
    if (constructionValues != null) {
      data['constructionValues'] =
          constructionValues!.map((v) => v.toJson()).toList();
    }
    if (weightValues != null) {
      data['weightValues'] = weightValues!.map((v) => v.toJson()).toList();
    }
    // data['trims'] = trims;
    if (trims != null) {
      data['trims'] = trims!.map((v) => v.toJson()).toList();
    }
    if (colorValues != null) {
      data['colorValues'] = colorValues!.map((v) => v.toJson()).toList();
    }
    data['colorCode'] = colorCode;
    data['costing'] = costing;
    if (unitMeasureValues != null) {
      data['unitMeasureValues'] =
          unitMeasureValues!.map((v) => v.toJson()).toList();
    }
    data['insertedOn'] = insertedOn;
    data['updatedOn'] = updatedOn;
    data['quantity'] = quantity;
    if (workflowValues != null) {
      data['workflowValues'] = workflowValues!.map((v) => v.toJson()).toList();
    }
    if (customizableValues != null) {
      data['customizableValues'] =
          customizableValues!.map((v) => v.toJson()).toList();
    }
    if (visibitlityValues != null) {
      data['visibitlityValues'] =
          visibitlityValues!.map((v) => v.toJson()).toList();
    }
    if (manufacturingStatusValues != null) {
      data['manufacturingStatusValues'] =
          manufacturingStatusValues!.map((v) => v.toJson()).toList();
    }
    data['image'] = image;
    if (customFields != null) {
      data['customFields'] = customFields!.map((v) => v.toJson()).toList();
    }
    data['mandatory'] = mandatory;
    return data;
  }
}

class ProductTypeValues {
  int? id;
  String? name;
  int? statusId;
  bool? isSelected;
  int? garmentTypeId;
  int? manufactureRoleCategoryId;
  int? manufacturerId;

  ProductTypeValues({this.id, this.name, this.statusId, this.isSelected = false, this.garmentTypeId, this.manufactureRoleCategoryId, this.manufacturerId});

  ProductTypeValues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    statusId = json['statusId'];
    if(json['garmentTypeId'] != null) {
      garmentTypeId = json['garmentTypeId'];
    }
    if(json['manufactureRoleCategoryId'] != null) {
      manufactureRoleCategoryId = json['manufactureRoleCategoryId'];
    }
    if(json['manufacturerId'] != null) {
      manufacturerId = json['manufacturerId'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['statusId'] = statusId;
    if(garmentTypeId != null) {
      data['garmentTypeId'] = garmentTypeId;
    }
    if(manufactureRoleCategoryId != null) {
      data['manufactureRoleCategoryId'] = manufactureRoleCategoryId;
    }
    if(manufacturerId != null) {
      data['manufacturerId'] = manufacturerId;
    }
    return data;
  }
}

class CustomFields {
  int? id;
  int? manufacturerId;
  String? name;
  String? description;
  int? segmentId;

  CustomFields(
      {this.id,
      this.manufacturerId,
      this.name,
      this.description,
      this.segmentId});

  CustomFields.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    manufacturerId = json['manufacturerId'];
    name = json['name'];
    description = json['description'];
    segmentId = json['segmentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['manufacturerId'] = manufacturerId;
    data['name'] = name;
    data['description'] = description;
    data['segmentId'] = segmentId;
    return data;
  }
}
