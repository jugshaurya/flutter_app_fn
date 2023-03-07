import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/inventory/model/product_response.dart';
import 'package:fs_app/factoryos/inventory/product/product_controller.dart';
import 'package:fs_app/factoryos/inventory/widget/fs_simple_text_field.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:fs_app/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ProductSuccessScreen extends StatefulWidget {
  const ProductSuccessScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductSuccessScreen> createState() => _ProductSuccessScreenState();
}

class _ProductSuccessScreenState extends State<ProductSuccessScreen> {
  ProductController controller = Get.find<ProductController>();
  PageController pageController = PageController(initialPage: 0);
  var currentIndex = 0.obs;
  SharedPreferenceService preferenceService = Get.find<SharedPreferenceService>();
  @override
  void initState() {
    super.initState();
    if(controller.productRes.value == null){
      var productUploadedMap = (jsonDecode(preferenceService.getString(TextConst.activeProductDetail) ?? "{}"));
      controller.productRes.value = ProductRes.fromJson(productUploadedMap);
    }
   /* WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(()=>{

      });
    });*/

    AppUtils.bottomSnackbar("Product", "Product uploaded successfully");
  }

  AppBar get _appBar => AppBar(
        backgroundColor: ColorConst.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorConst.black),
          onPressed: () => Get.offAndToNamed(AppRoute
              .inventory), //Get.until((route) => Get.currentRoute == AppRoute.inventory,),
        ),
        title: const Text(
          'Product Detail',
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

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.screenBackground,
      appBar: _appBar,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 12,
              ),
              _pageView,
              const SizedBox(
                height: 12,
              ),
              _name,
              const SizedBox(
                height: 12,
              ),
              _id,
              const SizedBox(
                height: 12,
              ),
              _productItem,
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      )
    );
  }*/

  _getColor(String? qty) {
    int quantity = 0;
    if (qty == null || qty.isEmpty) {
      quantity = 0;
      return const Color(0XFFFF2929);
    }
    quantity = int.parse(qty);
    if (quantity >= 10) {
      return const Color(0XFF7BC660);
    } else if (quantity > 0 && quantity < 10) {
      return const Color(0XFFFF9900);
    } else if (quantity == 0) {
      return const Color(0XFFFF2929);
    }
  }

  Widget get _customFieldItem => Obx(
        () => ListView.separated(
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 12,
        );
      },
      itemBuilder: (context, index) {
        String key = controller.productRes.value!.customFieldMap!.keys.elementAt(index);
        return FsSimpleTextField(
            isManadatory: false,
            isEnabled: false,
            label: key,
            text: '${controller.productRes.value!.customFieldMap![key] ?? ""}',
            onChanged: (text) {},
            hint: "");
      },
      itemCount: controller.productRes.value!.customFieldMap!.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConst.white,
        appBar: _appBar,
        body:Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _pageView,
                const SizedBox(
                  height: 12,
                ),
                _name,
                const SizedBox(
                  height: 12,
                ),
                _id,
                const SizedBox(
                  height: 12,
                ),
                FsSimpleTextField(
                    isManadatory: false,
                    isEnabled: false,
                    label: "Name",
                    text: controller.productRes.value == null ? controller.productRes.value!.name ?? "": "",
                    onChanged: (text) {},
                    hint: ""),
                const SizedBox(
                  height: 12,
                ),
                FsSimpleTextField(
                    isManadatory: false,
                    isEnabled: false,
                    label: "Garment Type",
                    text: controller.productRes.value != null ? controller.productRes.value!.garmentTypeName ?? "": "",
                    onChanged: (text) {},
                    hint: ""),
                const SizedBox(
                  height: 12,
                ),
                FsSimpleTextField(
                    isManadatory: false,
                    isEnabled: false,
                    label: "Description",
                    text: controller.productRes.value != null ? controller.productRes.value!.description ?? "": "",
                    onChanged: (text) {},
                    hint: ""),
                const SizedBox(
                  height: 12,
                ),
                FsSimpleTextField(
                    isManadatory: false,
                    isEnabled: false,
                    label: "Size",
                    text: controller.productRes.value != null ? controller.productRes.value!.sizeValue ?? "": "",
                    onChanged: (text) {},
                    hint: ""),
                const SizedBox(
                  height: 12,
                ),
                FsSimpleTextField(
                    isManadatory: false,
                    isEnabled: false,
                    label: "Fabric",
                    text: controller.productRes.value != null ? controller.productRes.value!.fabricValue ?? "": "",
                    onChanged: (text) {},
                    hint: ""),
                const SizedBox(
                  height: 12,
                ),
                FsSimpleTextField(
                    isManadatory: false,
                    isEnabled: false,
                    label: "Construction",
                    text: controller.productRes.value != null ? controller.productRes.value!.constructionValue ?? "": "",
                    onChanged: (text) {},
                    hint: ""),
                const SizedBox(
                  height: 12,
                ),
                FsSimpleTextField(
                    isManadatory: false,
                    isEnabled: false,
                    label: "Weight",
                    text: controller.productRes.value != null ? controller.productRes.value!.weightValue ?? "": "",
                    onChanged: (text) {},
                    hint: ""),
                const SizedBox(
                  height: 12,
                ),
                FsSimpleTextField(
                    isManadatory: false,
                    isEnabled: false,
                    label: "Trims",
                    text: controller.productRes.value != null ? controller.productRes.value!.trims ?? "": "",
                    onChanged: (text) {},
                    hint: ""),
                const SizedBox(
                  height: 12,
                ),
                FsSimpleTextField(
                    isManadatory: false,
                    isEnabled: false,
                    label: "Colour",
                    text: controller.productRes.value != null ? controller.productRes.value!.colorValue ?? "": "",
                    onChanged: (text) {},
                    hint: ""),
                const SizedBox(
                  height: 12,
                ),
                FsSimpleTextField(
                    isManadatory: false,
                    isEnabled: false,
                    label: "Colour Code",
                    text: controller.productRes.value != null ? controller.productRes.value!.colorCode ?? "": "",
                    onChanged: (text) {},
                    hint: ""),
                const SizedBox(
                  height: 12,
                ),
                FsSimpleTextField(
                    isManadatory: false,
                    isEnabled: false,
                    label: "Costing",
                    text: controller.productRes.value != null ? controller.productRes.value!.costing ?? "": "",
                    onChanged: (text) {},
                    hint: ""),
                const SizedBox(
                  height: 12,
                ),
                FsSimpleTextField(
                    isManadatory: false,
                    isEnabled: false,
                    label: "Quantity",
                    text: controller.productRes.value != null ? controller.productRes.value!.quantity ?? "": "",
                    onChanged: (text) {},
                    hint: ""),
                const SizedBox(height: 12,),
                _customFieldItem,
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _pageView => Obx(
        () => SizedBox(
          height: MediaQuery.of(context).size.height * 0.24,
          child: PageView(
            controller: pageController,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) {
              currentIndex.value = index;
            },
            children: List<Widget>.generate(
              controller.productRes.value != null ? controller.productRes.value!.imageString!.length: 0,
              (index) {
                return controller.productRes.value != null ? _imageSlider(
                      controller.productRes.value!.imageString![index]): null;
              },
            ),
          ),
        ),
      );

  _imageSlider(String imageUrl) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.18,
            margin: const EdgeInsets.only(top: 2, bottom: 2, left: 1, right: 1),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              shape: BoxShape.rectangle,
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => const CircularProgressIndicator(
                color: ColorConst.primary,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          _pageIndicator,
        ],
      );

  Widget get _pageIndicator => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
          controller.productRes.value != null ?  controller.productRes.value!.imageString!.length: 0,
          (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 3000),
              height: 5,
              width: 30,
              margin: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: (index == currentIndex.value)
                    ? const Color(0xFF333333)
                    : const Color(0xFFE0E0E0),
              ),
            );
          },
        ),
      );

  Widget get _name => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 2.0, bottom: 2),
            child: Text(
              controller.productRes.value != null ?  controller.productRes.value!.name ?? "": "",
              style: AppTextStyle.boldBlackGrey18.copyWith(
                color: const Color(0XFF13172E),
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: _getColor(controller.productRes.value != null ? controller.productRes.value!.quantity: "30")),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, top: 4, bottom: 4),
              child: Center(
                child: Text(
                  '${controller.productRes.value != null ? controller.productRes.value!.quantity ?? 0: 0}',
                  style: AppTextStyle.normalWhite12,
                ),
              ),
            ),
          ),
        ],
      );

  Widget get _id => SizedBox(
        width: 150,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0XFFE3E3E3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16, top: 4, bottom: 4),
                child: Text(
                  '${controller.productRes.value != null ? controller.productRes.value!.id ?? 0: 0}',
                  style: AppTextStyle.normalBlackGrey16,
                ),
              ),
              SvgPicture.asset(
                ImageConst.copyIcon,
                height: 15,
                width: 15,
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      );

  /*List imageString = <dynamic>[].obs;
  RxString name = "".obs;
  RxInt id = 0.obs;
  RxString qty = "".obs;

  Widget get _pageView => Obx(
        () => SizedBox(
          height: MediaQuery.of(context).size.height * 0.24,
          child: PageView(
            controller: pageController,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) {
              currentIndex.value = index;
            },
            children: List<Widget>.generate(
              imageString.length,
              (index) {
                return _imageSlider(index);
              },
            ),
          ),
        ),
      );

  _imageSlider(int index) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    // crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.18,
        margin:
        const EdgeInsets.only(top: 2, bottom: 2, left: 1, right: 1),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          shape: BoxShape.rectangle,
        ),
        child: CachedNetworkImage(
          imageUrl: imageString[index],
          placeholder: (context, url) => const CircularProgressIndicator(
            color: ColorConst.primary,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      const SizedBox(
        height: 12,
      ),
      _pageIndicator,
    ],
  );

  Widget get _pageIndicator => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(
            imageString.length,
            (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 3000),
                height: 5,
                width: 30,
                margin: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: (index == currentIndex.value)
                      ? const Color(0xFF333333)
                      : const Color(0xFFE0E0E0),
                ),
              );
            },
          ),
      );

  Widget get _name => Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 2.0, bottom: 2),
              child: Text(
                name.value,
                style: AppTextStyle.boldBlackGrey18.copyWith(
                  color: const Color(0XFF13172E),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: _getColor(qty.value)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16, top: 4, bottom: 4),
                child: Center(
                  child: Text(
                    qty.value,
                    style: AppTextStyle.normalWhite12,
                  ),
                ),
              ),
            ),
          ],
        ),
      );*/

  /*Widget get _id => Obx(() => SizedBox(
    width: 150,
    child: DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color(0XFFE3E3E3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16, top: 4, bottom: 4),
            child: Text(
              '${id.value}',
              style: AppTextStyle.normalBlackGrey16,
            ),
          ),
          SvgPicture.asset(
            ImageConst.copyIcon,
            height: 15,
            width: 15,
            fit: BoxFit.cover,
          )
        ],
      ),
    ),
  ),);*/

  /*Widget get _productItem => Obx(
        () => ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 12,
            );
          },
          itemBuilder: (context, index) {
            String key = controller.productRes.keys.elementAt(index);
            if(key == "updatedOn" || key == "insertedOn" || key == "manufacturerId" || key == "statusId" || key == "productDetailsJson"){
              return const SizedBox();
            } else if (key == "imageString") {
              imageString = controller.productRes[key];
              return const SizedBox();
            } else if (key == "name") {
              name.value = controller.productRes[key];
              return const SizedBox();
            } else if (key == "id") {
              id.value = controller.productRes[key];
              return const SizedBox();
            } else if (key == "quantity") {
              qty.value = controller.productRes[key];
              return const SizedBox();
            }
            return FsSimpleTextField(
                isManadatory: false,
                isEnabled: false,
                label: _getLabel(key),
                text: '${controller.productRes[key] ?? ""}',
                onChanged: (text) {},
                hint: "");
          },
          itemCount: controller.productRes.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
        ),
      );

  String _getLabel(String key){
    String label;
    switch(key){
      case 'name':
        label = "Name";
        break;
      case 'garmentTypeName':
        label = "Garment Type";
        break;
      case 'segmentTypeName':
        label = "Segment";
        break;
      case 'description':
        label = "Description";
        break;
      case 'sizeValue':
        label = "Size";
        break;
      case 'fabricValue':
        label = "Fabric";
        break;
      case 'constructionValue':
        label = "Construction";
        break;
      case 'weightValue':
        label = "Weight";
        break;
      case 'trims':
        label = "Trims";
        break;
      case 'colorValue':
        label = "Color";
        break;
      case 'colorCode':
        label = "Color code";
        break;
      case 'costing':
        label = "Costing";
        break;
      case 'unitMeasureValue':
        label = "Unit Measure";
        break;
      case 'quantity':
        label = "Quantity";
        break;
      case 'workflowValue':
        label = "Workflow";
        break;
      case 'customizableValue':
        label = "Customizable";
        break;
      case 'visibilityValue':
        label = "Visibility";
        break;
      case 'availableStock':
        label = "Available Stock";
        break;
      default:
        label = key;
        break;
    }
    return label;
  }*/
}
