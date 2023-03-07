import 'package:flutter/material.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/inventory/model/TypeValue.dart';
import 'package:fs_app/factoryos/inventory/product/product_controller.dart';
import 'package:fs_app/factoryos/inventory/widget/fs_multi_select_dropdown.dart';
import 'package:fs_app/factoryos/inventory/widget/fs_simple_text_field.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:fs_app/utils/log.dart';
import 'package:fs_app/widgets/fs_button.dart';
import 'package:get/get.dart';

class CreateCustomField extends StatefulWidget {
  const CreateCustomField({Key? key}) : super(key: key);

  @override
  State<CreateCustomField> createState() => _CreateCustomFieldState();
}

class _CreateCustomFieldState extends State<CreateCustomField> {
  SharedPreferenceService preferenceService = Get.find<SharedPreferenceService>();
  ProductController productController = Get.find<ProductController>();
  Map<String, dynamic> dataMap = <String, dynamic>{};
  var formKey = GlobalKey<FormState>();

  AppBar get _appBar => AppBar(
        backgroundColor: ColorConst.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorConst.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Create field',
          style: AppTextStyle.mediumBlack18,
        ),
        centerTitle: true,
      );

  @override
  void initState() {
    super.initState();
    var manufacturerId = preferenceService.getInt(TextConst.manufacturer_id) ?? 0;
    dataMap["manufacturerId"] = manufacturerId;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConst.screenBackground,
        appBar: _appBar,
        body: Form(
          key: formKey,
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                FsSimpleTextField(
                    isManadatory: true,
                    label: "Name",
                    text: "",
                    onChanged: (text) {
                      dataMap["name"] = text;
                    },
                    hint: "Name "),
                /*const SizedBox(
                  height: 24,
                ),
                FsProductDropdown(
                    product: productController.product.value!,
                    type: TypeValue.segmentTypeValues,
                    text: "Segment",
                    isMandatory: true,
                    onChanged: (value) {
                      dataMap["segmentId"] = value;
                    }),*/
                const SizedBox(
                  height: 24,
                ),
                FsSimpleTextField(
                    isManadatory: true,
                    label: "Description",
                    text: "",
                    onChanged: (text) {
                      dataMap["description"] = text;
                    },
                    hint: "Description"),
                const SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: FsButton(
                        text: "Done",
                        height: 35,
                        width: MediaQuery.of(context).size.width * 0.5,
                        onSubmit: () async {
                          if (formKey.currentState!.validate()) {
                            bool result = await productController.saveCustomFields(dataMap);
                            if(result){
                              Get.back();
                            }
                          }
                        }),
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
