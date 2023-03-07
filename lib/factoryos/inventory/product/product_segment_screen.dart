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

class ProductSegmentScreen extends StatefulWidget {
  const ProductSegmentScreen({Key? key}) : super(key: key);

  @override
  State<ProductSegmentScreen> createState() => _ProductSegmentScreenState();
}

class _ProductSegmentScreenState extends State<ProductSegmentScreen> {
  SharedPreferenceService preferenceService =
  Get.find<SharedPreferenceService>();
  ProductController productController = Get.find<ProductController>();

  RxList<File> imageFileList = <File>[].obs;
  RxList<String> imageList = <String>[].obs;

  Map<String, dynamic> dataMap = <String, dynamic>{};
  var formKey = GlobalKey<FormState>();
  RxInt garmentId = 0.obs;

  @override
  void initState() {
    super.initState();
    int manufacturerId = preferenceService.getInt(TextConst.manufacturer_id) ?? 0;
    var roleCategoryId = preferenceService.getInt(TextConst.manufacturer_sub_role) ?? 1;
    var roleId = preferenceService.getInt(TextConst.manufacturer_role) ?? 0;

    dataMap["manufactureId"] = manufacturerId;
    dataMap["manufactureRoleCategoryId"] = roleCategoryId;
    productController.getProducts(manufacturerId, roleCategoryId);
    productController.getCustomFields(manufacturerId);
    productController.getProfileSectionAttributes(roleId, 1);

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
      onPressed: () => Get.offNamed(AppRoute.factoryDashboard,arguments: {"pageState":"normal"}),
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

  var _selected;

  // var base64ImgString = "";


  @override
  Widget build(BuildContext context) {
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
                margin: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  productController.product.value != null?
                      FsSingleSelectDropdown(
                          product: productController.product.value!,
                          listValues: productController.profileSectionAttrList.value.length > 0 && productController.profileSectionAttrList.value != null  && productController.profileSectionAttrList.value[1] != null?
                          (productController.profileSectionAttrList.value[1]?.profileSectionsAttributeValues) ?? [] : [],
                          type: TypeValue.garmentTypeValues,
                          text: "Garment Type",
                          isMandatory: true,
                          onChanged: (value) {
                            garmentId.value = value.garmentTypeId;
                            dataMap["garmentTypeName"] = value.name;
                          }): const SizedBox(height: 12,),
                      const SizedBox(
                        height: 12,
                      ),
        productController.product.value != null?
                      FsSingleSelectDropdown(
                          product: productController.product.value!,
                          type: TypeValue.segmentTypeValues,
                          listValues: [],
                          text: "Segment",
                          isMandatory: true,
                          garmentId: garmentId.value,
                          onChanged: (value) {
                            dataMap["segmentTypeName"] = value.name;
                          }): const SizedBox(height: 12,),
                      const SizedBox(
                        height: 100,
                      ),
        productController.product.value != null?
                      FsButton(
                          text: "Next",
                          height: 35,
                          width: MediaQuery.of(context).size.width * 0.5,
                          onSubmit: () async {
                            if (formKey.currentState!.validate()) {
                              Log.logger.i(json.encode(dataMap));
                              preferenceService.setString(TextConst.inventory_dataMap, jsonEncode(dataMap));
                              Get.offNamed(AppRoute.product);
                            }
                          }): const SizedBox(height: 12,),
                      const SizedBox(
                        height: 12,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    imageList.clear();
    imageFileList.clear();
  }
}
