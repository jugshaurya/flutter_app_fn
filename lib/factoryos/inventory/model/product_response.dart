import 'dart:convert' as lib;

class ProductResponse {
  int? status;
  String? message;
  ProductRes? data;
  String? timeStamp;
  bool? sucess;

  ProductResponse(
      {this.status, this.message, this.data, this.timeStamp, this.sucess});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ProductRes.fromJson(json['data']) : null;
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

class ProductRes {
  int? id;
  String? name;
  String? garmentTypeName;
  String? segmentTypeName;
  String? description;
  String? sizeValue;
  String? fabricValue;
  String? constructionValue;
  String? weightValue;
  String? trims;
  String? colorValue;
  String? colorCode;
  String? costing;
  String? unitMeasureValue;
  String? insertedOn;
  Null? updatedOn;
  String? quantity;
  String? workflowValue;
  String? customizableValue;
  String? visibitlityValue;
  List<String>? imageString;
  int? manufacturerId;
  int? statusId;
  String? productDetailsJson;
  Map<String, dynamic>? customFieldMap = {};
  String? sku;
  int? availableStock;

  ProductRes(
      {this.id,
        this.name,
        this.garmentTypeName,
        this.segmentTypeName,
        this.description,
        this.sizeValue,
        this.fabricValue,
        this.constructionValue,
        this.weightValue,
        this.trims,
        this.colorValue,
        this.colorCode,
        this.costing,
        this.unitMeasureValue,
        this.insertedOn,
        this.updatedOn,
        this.quantity,
        this.workflowValue,
        this.customizableValue,
        this.visibitlityValue,
        this.imageString,
        this.manufacturerId,
        this.statusId,
        this.productDetailsJson,
        this.customFieldMap,
        this.sku,
        this.availableStock});

  ProductRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    garmentTypeName = json['garmentTypeName'];
    segmentTypeName = json['segmentTypeName'];
    description = json['description'];
    sizeValue = json['sizeValue'];
    fabricValue = json['fabricValue'];
    constructionValue = json['constructionValue'];
    weightValue = json['weightValue'];
    trims = json['trims'];
    colorValue = json['colorValue'];
    colorCode = json['colorCode'];
    costing = json['costing'];
    unitMeasureValue = json['unitMeasureValue'];
    insertedOn = json['insertedOn'];
    updatedOn = json['updatedOn'];
    quantity = json['quantity'];
    workflowValue = json['workflowValue'];
    customizableValue = json['customizableValue'];
    visibitlityValue = json['visibitlityValue'];
    imageString = json['imageString'].cast<String>();
    manufacturerId = json['manufacturerId'];
    statusId = json['statusId'];
    productDetailsJson = json['productDetailsJson'];
    customFieldMap = (productDetailsJson != null && productDetailsJson!.isNotEmpty) ? lib.json.decode(productDetailsJson!) : {};
    sku = json['sku'];
    availableStock = json['availableStock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['garmentTypeName'] = garmentTypeName;
    data['segmentTypeName'] = segmentTypeName;
    data['description'] = description;
    data['sizeValue'] = sizeValue;
    data['fabricValue'] = fabricValue;
    data['constructionValue'] = constructionValue;
    data['weightValue'] = weightValue;
    data['trims'] = trims;
    data['colorValue'] = colorValue;
    data['colorCode'] = colorCode;
    data['costing'] = costing;
    data['unitMeasureValue'] = unitMeasureValue;
    data['insertedOn'] = insertedOn;
    data['updatedOn'] = updatedOn;
    data['quantity'] = quantity;
    data['workflowValue'] = workflowValue;
    data['customizableValue'] = customizableValue;
    data['visibitlityValue'] = visibitlityValue;
    data['imageString'] = imageString;
    data['manufacturerId'] = manufacturerId;
    data['statusId'] = statusId;
    // data['productDetailsJson'] = productDetailsJson;
    if (customFieldMap != null) {
      data['productDetailsJson'] = lib.json.encode(customFieldMap);
    } else {
      data['productDetailsJson'] = productDetailsJson;
    }
    data['sku'] = sku;
    data['availableStock'] = availableStock;
    return data;
  }
}