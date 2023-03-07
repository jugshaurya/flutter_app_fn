import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/inventory/inventory_dashboard_controller.dart';
import 'package:fs_app/factoryos/inventory/model/product_list_model.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class InventoryDashboardScreen extends StatefulWidget {
  const InventoryDashboardScreen({Key? key}) : super(key: key);

  @override
  State<InventoryDashboardScreen> createState() =>
      _InventoryDashboardScreenState();
}

class _InventoryDashboardScreenState extends State<InventoryDashboardScreen> {
  SharedPreferenceService preferenceService =
      Get.find<SharedPreferenceService>();
  InventoryDashboardController controller =
      Get.find<InventoryDashboardController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var manufacturerId = preferenceService.getInt(TextConst.manufacturer_id) ?? 0;
      int roleCategoryId = preferenceService.getInt(TextConst.manufacturer_sub_role)??0;
      controller.getProducts(manufacturerId, roleCategoryId);
      controller.getProductStat(manufacturerId, roleCategoryId);
    });
  }

  AppBar get _appBar => AppBar(
        backgroundColor: ColorConst.white,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: ColorConst.black),
            onPressed: () => Get.back(),
            ),
        title: const Text(
          'Inventory',
          style: AppTextStyle.mediumBlack18,
        ),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: () => Get.toNamed(AppRoute.productSegment),
            child: const Center(
              child: Text(
                'ADD',
                style: AppTextStyle.normalblack16,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    var manufacturerId = preferenceService.getInt(TextConst.manufacturer_id) ?? 0;
    int roleCategoryId = preferenceService.getInt(TextConst.manufacturer_sub_role)??0;
    controller.getProducts(manufacturerId, roleCategoryId);
    controller.getProductStat(manufacturerId, roleCategoryId);
    return Scaffold(
      backgroundColor: ColorConst.backgroundColor,
      appBar: _appBar,
      body: Obx(
        () => LoadingOverlay(
            isLoading: controller.isLoading.value,
            child: controller.isLoading.value
                ? const SizedBox.shrink()
                : Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Expanded(child: _productStatItem),
                        const SizedBox(
                          height: 20,
                        ),
                        controller.productList.isEmpty
                            ? Expanded(flex: 7, child: _emptyScreen)
                            : Expanded(flex: 7, child: _listItem),
                      ],
                    ))),
      ),
    );
  }

  Widget get _listItem => ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 20,
          );
        },
        itemBuilder: (context, index) {
          ProductData product = controller.productList[index]!;
          return _listRow(product);
        },
        itemCount: controller.productList.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
      );

  _listRow(ProductData product) => Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 10),
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
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              flex: 2,
              child: CircleAvatar(
                backgroundColor: Color(0XFFC4C4C4),
                radius: 20,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 2.0, bottom: 2),
                    child: Text(
                      '${product.name ?? ""} ( ID : ${product.id})',
                      style: AppTextStyle.semiMediumBlack12.copyWith(
                        color: const Color(0XFF13172E),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 2.0, bottom: 2),
                    child: Text(
                      product.description ?? "",
                      style: AppTextStyle.normalBlackGrey12,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 2.0, bottom: 2),
                    child: Text(
                      (product.segmentTypeName ?? "") +
                          '|' +
                          (product.garmentTypeName ?? ""),
                      style: AppTextStyle.normalBlackGrey12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: _getColor(product)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 2.0, right: 2, top: 4, bottom: 4),
                      child: Center(
                        child: Text(
                          '${product.quantity ?? 0}',
                          style: AppTextStyle.normalWhite12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  _getColor(ProductData product) {
    int quantity = int.parse(product.quantity ?? "0");
    if (quantity >= 20) {
      return const Color(0XFF7BC660);
    } else if (quantity > 0 && quantity < 20) {
      return const Color(0XFFFF9900);
    } else if (quantity == 0) {
      return const Color(0XFFFF2929);
    }
  }

  Widget get _emptyScreen => Column(
        // mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 150),
          Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 2.0, bottom: 2),
            child: Center(
              child: Text(
                'OOPS! You have no inventory.',
                style: AppTextStyle.mediumBlack18
                    .copyWith(color: ColorConst.textBlack),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 2.0, bottom: 2),
            child: Center(
              child: Text(
                'Add product to begin',
                style: AppTextStyle.normalBlackGrey16
                    .copyWith(color: const Color(0XFF252525).withOpacity(0.7)),
              ),
            ),
          ),
          const SizedBox(height: 100),
          Center(
            child: TextButton(
              onPressed: () => Get.toNamed(AppRoute.productSegment),
              child: Text(
                'Add Product',
                style: AppTextStyle.normalBlackGrey14.copyWith(
                  color: const Color(0XFF0078EB),
                ),
              ),
            ),
          ),
        ],
      );

  Widget get _productStatItem => Obx(
        () => ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 12,
            );
          },
          itemBuilder: (context, index) {
            String key = controller.productStat.keys.elementAt(index);
            return _productStatRow(
                _getKeyLabel(key), controller.productStat[key]);
          },
          itemCount: controller.productStat.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
        ),
      );

  _productStatRow(String label, dynamic value) => Container(
        width: 110,
        height: 110,
        // padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: ColorConst.black,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                value.toString(),
                style: AppTextStyle.semiMediumBlue18
                    .copyWith(color: ColorConst.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                label,
                style: AppTextStyle.labelWhite12,
              ),
            )
          ],
        ),
      );

  _getKeyLabel(String key) {
    switch (key) {
      case 'totalAvailableStock':
        return 'In-stock';
      case 'totalOutOfStock':
        return 'Out of stock';
      case 'totalLowStock':
        return 'Low stock';
    }
  }
}
