import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/factoryos/inventory/model/TypeValue.dart';
import 'package:fs_app/factoryos/inventory/model/product_model.dart';
import 'package:fs_app/factoryos/inventory/widget/multi_select_bottom_sheet_content.dart';
import 'package:fs_app/factoryos/inventory/widget/single_select_bottom_sheet_content.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_attr_response.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class FsSingleSelectDropdown extends StatefulWidget {
  final Product product;
  final TypeValue type;
  final String text;
  final bool isMandatory;
  final Function(dynamic v) onChanged;
  final List<ProfileSectionsAttributeValues> listValues;
  final int? garmentId;

  const FsSingleSelectDropdown({
    Key? key,
    required this.product,
    required this.type,
    required this.text,
    required this.isMandatory,
    required this.onChanged,
    required this.listValues,
    this.garmentId,
  }) : super(key: key);

  @override
  State<FsSingleSelectDropdown> createState() => _FsSingleSelectDropdownState();
}

class _FsSingleSelectDropdownState extends State<FsSingleSelectDropdown> {
  late final TextEditingController controller;
  RxList<ProductTypeValues> productTypeList = <ProductTypeValues>[].obs;

  getProductTypeValues() async {
    switch (widget.type) {
      case TypeValue.garmentTypeValues:
        productTypeList.value = widget.product.garmentTypeValues.toString() != "[]" ? (widget.product.garmentTypeValues ?? widget.listValues as List<ProductTypeValues>) : (widget.listValues as List<ProductTypeValues>);
        break;
      case TypeValue.segmentTypeValues:
        productTypeList.value = widget.product.segmentTypeValues ?? widget.listValues as List<ProductTypeValues>;
        break;
      case TypeValue.fabricValues:
        productTypeList.value = widget.product.fabricValues ?? widget.listValues as List<ProductTypeValues>;
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    getProductTypeValues();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        flex: 4,
        child: RichText(
          text: TextSpan(
            text: widget.text,
            style: AppTextStyle.normalBlackGrey16,
            children: [
              TextSpan(
                  text: widget.isMandatory ? ' *' : "",
                  style: const TextStyle(color: Colors.red, fontSize: 16))
            ],
          ),
        ),
      ),
      Expanded(
        flex: 6,
        child: InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            if(widget.type == TypeValue.segmentTypeValues){
              productTypeList.value =
                  widget.product.segmentTypeValues!.where((element) => element
                      .garmentTypeId == widget.garmentId).toList();
            }
            switch (widget.type) {
              case TypeValue.garmentTypeValues:
                showBottomSheet((widget.product.garmentTypeValues.toString() != "[]" ? (widget.product.garmentTypeValues ?? widget.listValues as List<ProductTypeValues>) : (widget.listValues as List<ProductTypeValues>)));
                break;
              case TypeValue.segmentTypeValues:
                showBottomSheet(widget.product.segmentTypeValues ?? widget.listValues as List<ProductTypeValues>);
                break;
              case TypeValue.fabricValues:
                showBottomSheet(widget.product.fabricValues ?? widget.listValues as List<ProductTypeValues>);
                break;
            }
          },
          //widget.callback(),
          child: IgnorePointer(
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  if (widget.isMandatory) {
                    return 'Select ${widget.text}';
                  }
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              // enabled: true,
              // readOnly: true,
              decoration: InputDecoration(
                  hintText: 'Select',
                  hintStyle: AppTextStyle.normalBlackGrey16.copyWith(color:const Color(0XFF979797)),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorConst.lightGrey)),
                  disabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorConst.lightGrey)),
                  suffixIcon: SvgPicture.asset(ImageConst.blackDownIcon,
                      height: 16, width: 8, fit: BoxFit.scaleDown)),
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
    ],
  );

  showBottomSheet(List<ProductTypeValues> productTypeList) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: ColorConst.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, snapshot) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: SingleSelectBottomSheetContent(
              productTypeList: productTypeList,
              label: widget.text,
              onListItemTap: (v) {
                ProductTypeValues value = v as ProductTypeValues;
                controller.text = value.name!;
                widget.onChanged(value);
              },
            ),
          );
        });
      },
    );
  }
}
