class ProductListModel {
  int? status;
  String? message;
  List<ProductData>? product;
  String? timeStamp;
  bool? sucess;

  ProductListModel(
      {this.status, this.message, this.product, this.timeStamp, this.sucess});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      product = <ProductData>[];
      json['data'].forEach((v) {
        product!.add(ProductData.fromJson(v));
      });
    }
    timeStamp = json['timeStamp'];
    sucess = json['sucess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (product != null) {
      data['data'] = product!.map((v) => v.toJson()).toList();
    }
    data['timeStamp'] = timeStamp;
    data['sucess'] = sucess;
    return data;
  }
}

class ProductData {
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
  String? updatedOn;
  String? quantity;
  String? workflowValue;
  String? customizableValue;
  String? visibitlityValue;
  List<String>? imageString;
  int? manufacturerId;
  int? statusId;
  String? productDetailsJson;
  String? sku;
  int? availableStock;

  ProductData(
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
        this.sku,
        this.availableStock});

  ProductData.fromJson(Map<String, dynamic> json) {
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
    data['productDetailsJson'] = productDetailsJson;
    data['sku'] = sku;
    data['availableStock'] = availableStock;
    return data;
  }
}