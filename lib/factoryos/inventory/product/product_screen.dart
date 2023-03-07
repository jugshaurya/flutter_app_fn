import 'dart:convert';
import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/inventory/model/TypeValue.dart';
import 'package:fs_app/factoryos/inventory/model/product_model.dart';
import 'package:fs_app/factoryos/inventory/product/product_controller.dart';
import 'package:fs_app/factoryos/inventory/widget/fs_multi_select_dropdown.dart';
import 'package:fs_app/factoryos/inventory/widget/fs_simple_number_field.dart';
import 'package:fs_app/factoryos/inventory/widget/fs_simple_text_field.dart';
import 'package:fs_app/factoryos/inventory/widget/fs_single_select_dropdown.dart';
import 'package:fs_app/factoryos/inventory/widget/stack_image_widget.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:fs_app/utils/app_utils.dart';
import 'package:fs_app/utils/log.dart';
import 'package:fs_app/widgets/fs_button.dart';
import 'package:fs_app/widgets/fs_switch.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  SharedPreferenceService preferenceService =
      Get.find<SharedPreferenceService>();
  ProductController productController = Get.find<ProductController>();

  RxList<File> imageFileList = <File>[].obs;
  RxList<String> imageList = <String>[].obs;

  Map<String, dynamic> dataMap = <String, dynamic>{};
  Map<String, dynamic> customFieldMap = <String, dynamic>{};
  var formKey = GlobalKey<FormState>();
  RxInt garmentId = 0.obs;

  @override
  void initState() {
    super.initState();
    int manufacturerId = preferenceService.getInt(TextConst.manufacturer_id) ?? 0;
    var roleCategoryId = preferenceService.getInt(TextConst.manufacturer_sub_role) ?? 0;
    dataMap = jsonDecode(preferenceService.getString(TextConst.inventory_dataMap) ?? '{}');
    dataMap["manufactureId"] = manufacturerId;
    dataMap["manufactureRoleCategoryId"] = roleCategoryId;
    productController.getProducts(manufacturerId, roleCategoryId);
    productController.getCustomFields(manufacturerId);

    /* WidgetsBinding.instance.addPostFrameCallback((_) {
      dataMap["manufactureId"] = manufacturerId;
      dataMap["manufactureRoleCategoryId"] = roleCategoryId;
      productController.getProducts(manufacturerId, roleCategoryId);
      productController.getCustomFields(manufacturerId);
    });*/
  }

  AppBar get _appBar => AppBar(
        backgroundColor: ColorConst.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorConst.black),
          onPressed: () =>  Get.offNamed(AppRoute.factoryDashboard , arguments: {"pageState":"normal"}),
        ),
        title: const Text(
          'Add Product Detail',
          style: AppTextStyle.mediumBlack18,
        ),
        centerTitle: true,
        /*actions: <Widget>[
          InkWell(
            // onTap: () => customFieldBottomSheet(),
            child: SvgPicture.asset(
              ImageConst.moreIcon,
              color: ColorConst.black,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
        ],*/
      );

  Widget get _addImage => InkWell(
        onTap: () {
          if (imageFileList.length < 3) {
            _chooseOptionDialog(context);
          } else {
            AppUtils.bottomSnackbar(
                "Info", "You have reached to the max limit");
            return;
          }
        },
        child: const Center(
          child: Text(
            'Add Photo',
            style: AppTextStyle.normalBlue16,
          ),
        ),
      );

  _chooseSingleOptionDialog(BuildContext context, int index) async {
    _selected = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text(
            'Choose',
            style: AppTextStyle.mediumBlack14,
          ),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "Camera");
              },
              child: const Text(
                'Pick Image from Camera',
                style: AppTextStyle.normalBlackGrey12,
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "Gallery");
              },
              child: const Text(
                'Pick Image from Gallery',
                style: AppTextStyle.normalBlackGrey12,
              ),
            ),
          ],
          elevation: 10,
          //backgroundColor: Colors.green,
        );
      },
    );

    if (_selected != null) {
      setState(() {
        _selected = _selected;
        pickSingleImage(index);
      });
    }
  }

  _chooseOptionDialog(BuildContext context) async {
    _selected = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text(
            'Choose',
            style: AppTextStyle.mediumBlack14,
          ),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "Camera");
              },
              child: const Text(
                'Pick Image from Camera',
                style: AppTextStyle.normalBlackGrey12,
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "Gallery");
              },
              child: const Text(
                'Pick Image from Gallery',
                style: AppTextStyle.normalBlackGrey12,
              ),
            ),
          ],
          elevation: 10,
          //backgroundColor: Colors.green,
        );
      },
    );

    if (_selected != null) {
      if (StringUtils.equalsIgnoreCase(_selected, "camera")) {
        setState(() {
          _selected = _selected;
          capturePhoto();
        });
      } else {
        setState(() {
          _selected = _selected;
          pickMultiImage();
        });

        // selectImages();
      }
    }
  }

  File? image;
  var _selected;

  // var base64ImgString = "";

  Future capturePhoto() async {
    try {
      if (imageFileList.isEmpty || imageFileList.length <= 5) {
        final image = await ImagePicker().pickImage(maxWidth: 640, maxHeight: 480, source: ImageSource.camera);
        if (image == null) return;
        final imageTemp = File(image.path);
        List<int> imageBytes = imageTemp.readAsBytesSync();
        var base64ImgString = base64Encode(imageBytes);
        // setState(() => this.image = imageTemp);
        imageFileList.add(imageTemp);
        imageList.add(base64ImgString);
        dataMap["imageString"] = imageList;
      } else {
        AppUtils.bottomSnackbar("Info", "You have reached to the max limit.");
      }
    } on PlatformException catch (e) {
      Log.logger.e('Failed to capture image: $e');
    } catch (e) {
      Log.logger.e('Failed to capture image: $e');
    }
  }

  Future pickSingleImage(int index) async {
    try {
      final image = await ImagePicker().pickImage(maxWidth: 640, maxHeight: 480,
          source: StringUtils.equalsIgnoreCase(_selected, "camera")
              ? ImageSource.camera
              : ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      List<int> imageBytes = imageTemp.readAsBytesSync();
      var base64ImgString = base64Encode(imageBytes);
      // setState(() => this.image = imageTemp);
      imageFileList[index] = imageTemp;
      imageList[index] = base64ImgString;
      dataMap["imageString"] = imageList;
    } on PlatformException catch (e) {
      Log.logger.e('Failed to capture image: $e');
    } catch (e) {
      Log.logger.e('Failed to capture image: $e');
    }
  }

  Future pickMultiImage() async {
    try {
      if (imageFileList.isEmpty || imageFileList.length <= 5) {
        final pickedImages = await ImagePicker().pickMultiImage(maxWidth: 640, maxHeight: 480);
        if (pickedImages != null) {
          for (var element in pickedImages) {
            final imageTemp = File(element.path);
            List<int> imageBytes = imageTemp.readAsBytesSync();
            var base64ImgString = base64Encode(imageBytes);
            imageFileList.add(imageTemp);
            imageList.add(base64ImgString);
            if (imageFileList.length == 5) {
              break;
            }
          }
        }
        setState(() {});
        dataMap["imageString"] = imageList;
      } else {
        AppUtils.bottomSnackbar("Info", "You have reached to the max limit.");
      }
    } on PlatformException catch (e) {
      Log.logger.e('Failed to pick image: $e');
    } catch (e) {
      Log.logger.e('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    int manufacturerId = preferenceService.getInt(TextConst.manufacturer_id) ?? 0;
    productController.getCustomFields(manufacturerId);
    return Scaffold(
      backgroundColor: ColorConst.screenBackground,
      appBar: _appBar,
      body: Obx(
        () => LoadingOverlay(
          isLoading: productController.isLoading.value,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (productController.product.value != null) ...{
                      Container(
                          decoration: BoxDecoration(
                            color: ColorConst.screenBackground,
                            border: Border(
                              bottom: BorderSide(width: 32.0, color: ColorConst.shadowWhiteColor),
                            ),
                              ),
                      child:Container(
                          margin: const EdgeInsets.all(20),
                          child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          StackImageWidget(
                            imageList: imageFileList,
                            addImage: () {
                              _chooseOptionDialog(context);
                            },
                            updateImage: (index) {
                              imageOptionBottomSheet(index);
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          /*_addImage,
                      const SizedBox(
                        height: 24,
                      ),*/
                          FsSimpleTextField(
                              isManadatory: true,
                              label: "Name",
                              text: "",
                              onChanged: (text) {
                                dataMap["name"] = text;
                              },
                              hint: 'Product Name'),
                          const SizedBox(
                            height: 12,
                          ),
                          FsSimpleTextField(
                              isManadatory: true,
                              label: "Description",
                              text: "",
                              onChanged: (text) {
                                dataMap["description"] = text;
                              },
                              hint: "Enter description"),
                          const SizedBox(
                            height: 12,
                          ),

                          FsSingleSelectDropdown(
                              product: productController.product.value!,
                              type: TypeValue.fabricValues,
                              text: "Fabric",
                              listValues: [],
                              isMandatory: true,
                              onChanged: (value) {
                                dataMap["fabricValue"] = value.name;
                              }),
                          const SizedBox(
                            height: 12,
                          ),
                          FsSimpleTextField(
                              isManadatory: false,
                              label: "Fabric details",
                              text: "",
                              onChanged: (text) {
                                dataMap["constructionValue"] = text;
                              },
                              hint: "Enter Fabric details"),

                          /*FsMultiSelectDropdown(
                          product: productController.product.value!,
                          type: TypeValue.constructionValues,
                          text: "Construction",
                          isMandatory: false,
                          onChanged: (value) {
                            dataMap["constructionValue"] = value;
                          }),*/
                          const SizedBox(
                            height: 12,
                          ),
                          FsSimpleTextField(
                              isManadatory: true,
                              label: "Weight",
                              text: "",
                              onChanged: (text) {
                                dataMap["weightValue"] = text;
                              },
                              hint: '"Enter Weight per piece"'),
                          /*FsMultiSelectDropdown(
                          product: productController.product.value!,
                          type: TypeValue.weightValues,
                          text: "Weight",
                          isMandatory: true,
                          onChanged: (value) {
                            dataMap["weightValue"] = value;
                          }),*/
                          const SizedBox(
                            height: 12,
                          ),
                          /*FsSimpleTextField(
                          isManadatory: true,
                          label: "Trims",
                          text: "",
                          onChanged: (text) {
                            dataMap["trims"] = text;
                          },
                          hint: "Trims "),*/

                          FsMultiSelectDropdown(
                              product: productController.product.value!,
                              type: TypeValue.trims,
                              text: "Trims",
                              isMandatory: true,
                              onChanged: (value) {
                                dataMap["trims"] = value;
                              }),

                          /*FsMultiSelectDropdown(
                          product: productController.product.value!,
                          type: TypeValue.colorValues,
                          text: "Colour",
                          isMandatory: false,
                          onChanged: (value) {
                            dataMap["colorValue"] = value;
                          }),*/
                          const SizedBox(
                            height: 12,
                          ),
                          FsSimpleTextField(
                              isManadatory: false,
                              label: "Colour Code",
                              text: "",
                              onChanged: (text) {
                                dataMap["colorCode"] = text;
                              },
                              hint: 'e.g. #FFFFFF'),
                          const SizedBox(
                            height: 12,
                          ),
                          FsSimpleNumberField(
                              isManadatory: true,
                              label: "Cost per piece",
                              text: "",
                              onChanged: (text) {
                                dataMap["costing"] = text;
                              },
                              hint: "Enter Cost per piece"),
                          const SizedBox(
                            height: 12,
                          ),
                          FsMultiSelectDropdown(
                              product: productController.product.value!,
                              type: TypeValue.unitMeasureValues,
                              text: "Unit of measure",
                              isMandatory: true,
                              onChanged: (value) {
                                dataMap["unitMeasureValue"] = value;
                              }),
                          const SizedBox(
                            height: 12,
                          ),
                          FsSimpleNumberField(
                              isManadatory: true,
                              label: "Quantity",
                              text: "",
                              onChanged: (text) {
                                dataMap["quantity"] = text;
                              },
                              hint: "Enter quantity"),
                          const SizedBox(
                            height: 12,
                          ),
                          FsMultiSelectDropdown(
                              product: productController.product.value!,
                              type: TypeValue.workflowValues,
                              text: "Workflow",
                              isMandatory: false,
                              onChanged: (value) {
                                dataMap["workflowValue"] = value;
                              }),

                            /*FsMultiSelectDropdown(
                          product: productController.product.value!,
                          type: TypeValue.customizableValues,
                          text: "Customizable",
                          isMandatory: false,
                          onChanged: (value) {
                            dataMap["customizableValue"] = value;
                          }),*/


                        ]
                      ))),
                    Container(
                    decoration: BoxDecoration(
                    color: ColorConst.screenBackground,
                    border: Border(
                    bottom: BorderSide(width: 32.0, color: ColorConst.shadowWhiteColor),
                    ),
                    ),
                    child:Container(
                    margin: const EdgeInsets.all(20),
                    child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Product Options",
                        style: AppTextStyle.boldBlack20
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                          "Can customize the listed products find the most",
                          style: AppTextStyle.labelGray12
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      FsSimpleTextField(
                          isManadatory: false,
                          label: "Size",
                          text: "",
                          onChanged: (text) {
                            dataMap["sizeValue"] = text;
                          },
                          hint: "Enter Size"),
                      const SizedBox(
                        height: 12,
                      ),
                      FsSimpleTextField(
                          isManadatory: false,
                          label: "Colour",
                          text: "",
                          onChanged: (text) {
                            dataMap["colorValue"] = text;
                          },
                          hint: 'e.g. Crimson red'),
                      const SizedBox(
                        height: 12,
                      ),
                      /* FsMultiSelectDropdown(
                          product: productController.product.value!,
                          type: TypeValue.visibitlityValues,
                          text: "¸",
                          isMandatory: true,
                          onChanged: (value) {
                            dataMap["visibilityValues"] = value;
                          }),*/
                      const SizedBox(
                        height: 12,
                      ),
                      productController.customFieldList.value.length > 0 ? _listItem : const SizedBox(),
                      const SizedBox(
                        height: 50,
                      ),
                      _customWidget,
                      const SizedBox(
                        height: 12,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ]
                    ))),
                      Container(
                          decoration: BoxDecoration(
                            color: ColorConst.screenBackground,
                            border: Border(
                              bottom: BorderSide(width: 32.0, color: ColorConst.shadowWhiteColor),
                            ),
                          ),
                          child:Container(
                              margin: const EdgeInsets.all(20),
                              child:Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                        "Track Inventory",
                                        style: AppTextStyle.boldBlack20
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                        "Can customize the listed products find the most",
                                        style: AppTextStyle.labelGray12
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    FsSwitch(
                                      text: "Track Inventory",
                                      isMandatory: true,
                                      onSwitchChange: (value) {
                                        dataMap["tractInventory"] =
                                        value ? 'true' : 'false';
                                      },
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    FsSimpleNumberField(
                                        isManadatory: true,
                                        label: "Quantity",
                                        text: "",
                                        onChanged: (text) {
                                          dataMap["inventoryQuantity"] = text;
                                        },
                                        hint: "Enter quantity"),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    FsSimpleNumberField(
                                        isManadatory: true,
                                        label: "Weight",
                                        text: "",
                                        onChanged: (text) {
                                          dataMap["inventoryWeight"] = text;
                                        },
                                        hint: "Enter weight"),

                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ]
                              ))),

                      Container(
                          decoration: BoxDecoration(
                            color: ColorConst.screenBackground,
                            border: Border(
                              bottom: BorderSide(width: 32.0, color: ColorConst.shadowWhiteColor),
                            ),
                          ),
                          child:Container(
                              margin: const EdgeInsets.all(20),
                              child:Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                        "Hide This Product",
                                        style: AppTextStyle.boldBlack20
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                        "Can customize the listed products find the most",
                                        style: AppTextStyle.labelGray12
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    FsSwitch(
                                      text: "Private product",
                                      isMandatory: true,
                                      onSwitchChange: (value) {
                                        dataMap["visibilityValues"] =
                                        value ? 'Private' : 'Public';
                                      },
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ]
                              ))),
                      Container(
                          decoration: BoxDecoration(
                            color: ColorConst.screenBackground,
                            border: Border(
                              bottom: BorderSide(width: 32.0, color: ColorConst.shadowWhiteColor),
                            ),
                          ),
                          child:Container(
                              margin: const EdgeInsets.all(20),
                              child:Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                        "Customisable",
                                        style: AppTextStyle.boldBlack20
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                        "Can customize the listed products find the most",
                                        style: AppTextStyle.labelGray12
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    FsSwitch(
                                      text: "Customizable",
                                      isMandatory: false,
                                      onSwitchChange: (value) {
                                        dataMap["customizableValue"] = value ? 'Yes' : 'No';
                                      },
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    _listItem,
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    FsButton(
                                        text: "Submit",
                                        height: 35,
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        onSubmit: () async {
                                          if (formKey.currentState!.validate()) {
                                            if (imageList.isEmpty) {
                                              AppUtils.bottomSnackbar(
                                                  "Message", "Please add image!");
                                              return;
                                            }
                                            // dataMap["imageString"] = imageList.asMap();
                                            dataMap["productDetailsJson"] =
                                                json.encode(customFieldMap);
                                            Log.logger.i(json.encode(dataMap));

                                            bool result =
                                            await productController.saveProduct(dataMap);
                                            if (result) {
                                            Future.delayed(const Duration(seconds: 2)).then((value) {
                                              Get.offNamed(
                                                  AppRoute.productSuccess);
                                            });
                                            }
                                          }
                                        }),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ]
                              ))),

                    }
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _listItem => Obx(
        () => ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 16,
            );
          },
          itemBuilder: (context, index) {
            CustomFields customFields = productController.customFieldList.value[index]!;
            // dataMap["${customFields.name}"] = customFields.description ?? "";
            return _listRow(customFields);
          },
          itemCount: productController.customFieldList.value.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
        ),
      );

  _listRow(CustomFields customFields) => FsSimpleTextField(
      label: customFields.name!,
      text: "",
      onChanged: (text) {
        customFieldMap["${customFields.name}"] = text;
      },
      hint: customFields.description!);

  Widget get _customWidget => Center(
        child: TextButton(
          onPressed: () => customFieldBottomSheet(),
          child: Text(
            'Add custom field',
            textAlign: TextAlign.left,
            style: AppTextStyle.boldBlack16.copyWith(
              color: ColorConst.primary,
            ),
          ),
        ),
      );

  customFieldBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, snapshot) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Center(
                              child: SizedBox(
                                width: 60,
                                child: Divider(
                                  height: 5,
                                  thickness: 5,
                                  color: Color(0XFFC6C6C6),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Center(
                            child: Text(
                              "Options",
                              style: AppTextStyle.mediumBlack14,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                              Get.toNamed(AppRoute.createField);
                            },
                            title: const Text(
                              "Add custom fields",
                              style: AppTextStyle.mediumBlue12,
                            ),
                            subtitle: const Text(
                              "add new fields",
                              style: AppTextStyle.labelGray12,
                            ),
                            leading: Container(
                              constraints: const BoxConstraints(
                                  minWidth: 20.0, maxWidth: 20),
                              height: double.infinity,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SvgPicture.asset(
                                  ImageConst.plusIcon,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                              Get.toNamed(AppRoute.createFieldList);
                            },
                            title: const Text(
                              "Remove custom fields",
                              style: AppTextStyle.mediumBlue12,
                            ),
                            subtitle: const Text(
                              "remove new fields",
                              style: AppTextStyle.labelGray12,
                            ),
                            leading: Container(
                              constraints: const BoxConstraints(
                                  minWidth: 20.0, maxWidth: 20),
                              height: double.infinity,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SvgPicture.asset(
                                  ImageConst.removeIcon,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  imageOptionBottomSheet(int index) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, snapshot) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Center(
                              child: SizedBox(
                                width: 60,
                                child: Divider(
                                  height: 5,
                                  thickness: 5,
                                  color: Color(0XFFC6C6C6),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Center(
                            child: Text(
                              "Options",
                              style: AppTextStyle.mediumBlack14,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                              _chooseSingleOptionDialog(context, index);
                            },
                            title: const Text(
                              "Replace Image",
                              style: AppTextStyle.mediumBlue12,
                            ),
                            subtitle: const Text(
                              "Replace selected image",
                              style: AppTextStyle.labelGray12,
                            ),
                            leading: Container(
                              constraints: const BoxConstraints(
                                  minWidth: 20.0, maxWidth: 20),
                              height: double.infinity,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SvgPicture.asset(
                                  ImageConst.replaceImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                              imageList.removeAt(index);
                              imageFileList.removeAt(index);
                            },
                            title: const Text(
                              "Remove image",
                              style: AppTextStyle.mediumBlue12,
                            ),
                            subtitle: const Text(
                              "Remove selected image",
                              style: AppTextStyle.labelGray12,
                            ),
                            leading: Container(
                              constraints: const BoxConstraints(
                                  minWidth: 20.0, maxWidth: 20),
                              height: double.infinity,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SvgPicture.asset(
                                  ImageConst.removeIcon,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                              final tempImageList = imageList[0];
                              imageList[0] = imageList[index];
                              imageList[index] = tempImageList;

                              final tempImageFileList = imageFileList[0];
                              imageFileList[0] = imageFileList[index];
                              imageFileList[index] = tempImageFileList;
                            },
                            title: const Text(
                              "Set as main image",
                              style: AppTextStyle.mediumBlue12,
                            ),
                            subtitle: const Text(
                              "Set selected image as main image",
                              style: AppTextStyle.labelGray12,
                            ),
                            leading: Container(
                              constraints: const BoxConstraints(
                                  minWidth: 20.0, maxWidth: 20),
                              height: double.infinity,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SvgPicture.asset(
                                  ImageConst.mainImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    imageList.clear();
    imageFileList.clear();
  }
}
