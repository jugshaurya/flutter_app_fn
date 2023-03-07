import 'package:flutter/material.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/inventory/model/product_model.dart';
import 'package:fs_app/factoryos/inventory/product/product_controller.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CustomFieldList extends StatefulWidget {
  const CustomFieldList({Key? key}) : super(key: key);

  @override
  State<CustomFieldList> createState() => _CustomFieldListState();
}

class _CustomFieldListState extends State<CustomFieldList> {
  final ProductController controller = Get.find<ProductController>();
SharedPreferenceService preferenceService = Get.find<SharedPreferenceService>();

  AppBar get _appBar => AppBar(
        backgroundColor: ColorConst.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorConst.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Edit fields',
          style: AppTextStyle.mediumBlack18,
        ),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: () => Get.back(), // Get.offAllNamed(AppRoute.product,),
            child: const Center(
              child: Text(
                'Done',
                style: AppTextStyle.semiMediumBlue18,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int manufacturerId = preferenceService.getInt(TextConst.manufacturer_id) ?? 0;
      controller.getCustomFields(manufacturerId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
          backgroundColor: ColorConst.screenBackground,
          appBar: _appBar,
          body: LoadingOverlay(
            isLoading: controller.isLoading.value,
            child: controller.isLoading.value
                ? const SizedBox.shrink()
                : Container(
                    margin: const EdgeInsets.all(20),
                    child: controller.customFieldList.isEmpty
                        ? _emptyWidget
                        : _listItem),
          ),
        ),
      ),
    );
  }

  Widget get _listItem => ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 16,
          );
        },
        itemBuilder: (context, index) {
          CustomFields customFields = controller.customFieldList[index]!;
          return _listRow(customFields);
        },
        itemCount: controller.customFieldList.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
      );

  _listRow(CustomFields customFields) => Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: InkWell(
          onTap: () => _showConfirmation(context, customFields),
          //controller.deleteCustomFields(customFields),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                customFields.name ?? "",
                style: AppTextStyle.mediumBlue12,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                customFields.description ?? "",
                style: AppTextStyle.labelGray12,
              ),
            ),
            trailing: Container(
              constraints: const BoxConstraints(minWidth: 20.0, maxWidth: 20),
              height: double.infinity,
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.delete,
                  size: 24,
                  color: ColorConst.primary,
                ),
                /*SvgPicture.asset(
                  ImageConst.removeIcon,
                  fit: BoxFit.cover,
                ),*/
              ),
            ),
          ),
        ),
      );

  Widget get _emptyWidget => Center(
        child: TextButton(
          onPressed: () => Get.toNamed(AppRoute.createField),
          child: Text(
            'Add new field',
            style: AppTextStyle.normalBlackGrey14.copyWith(
              color: const Color(0XFF0078EB),
            ),
          ),
        ),
      );

  void _showConfirmation(BuildContext context, CustomFields customFields) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(
              'Custom Field',
              style: AppTextStyle.mediumWhite16
                  .copyWith(color: ColorConst.primary),
            ),
            content: const Text(
              'Are you sure you want to delete?',
              style: AppTextStyle.normalBlackGrey14,
            ),
            actions: [
              Row(
                children: [
                  const Spacer(),
                  SizedBox(
                      height: 40.0,
                      width: 100.0,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          controller.deleteCustomFields(customFields);
                        },
                        child: const Text('Yes',
                            style: AppTextStyle.normalBlackGrey14),
                      )),
                  const Spacer(),
                  SizedBox(
                    height: 40.0,
                    width: 100.0,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'No',
                          style: AppTextStyle.normalBlackGrey14,
                        )),
                  ),
                  Spacer(),
                ],
              ),
            ],
          );
        });
  }
}
