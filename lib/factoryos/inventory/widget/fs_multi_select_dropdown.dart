import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/factoryos/inventory/model/TypeValue.dart';
import 'package:fs_app/factoryos/inventory/model/product_model.dart';
import 'package:fs_app/factoryos/inventory/widget/multi_select_bottom_sheet_content.dart';
import 'package:fs_app/theme/text_style.dart';

class FsMultiSelectDropdown extends StatefulWidget {
  final Product product;
  final TypeValue type;
  final String text;
  final bool isMandatory;
  final Function(dynamic v) onChanged;

  const FsMultiSelectDropdown({
    Key? key,
    required this.product,
    required this.type,
    required this.text,
    required this.isMandatory,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<FsMultiSelectDropdown> createState() => _FsMultiSelectDropdownState();
}

class _FsMultiSelectDropdownState extends State<FsMultiSelectDropdown> {
  late final TextEditingController controller;
  List selectedList = [];
  var selectedValue = "";

  List<ProductTypeValues> productTypeList = [];

  getProductTypeValues() async {
    switch (widget.type) {
      case TypeValue.sizeValues:
        productTypeList = widget.product.sizeValues ?? [];
        break;
      case TypeValue.trims:
        productTypeList = widget.product.trims ?? [];
        break;
      case TypeValue.constructionValues:
        productTypeList = widget.product.constructionValues ?? [];
        break;
      case TypeValue.weightValues:
        productTypeList = widget.product.weightValues ?? [];
        break;
      case TypeValue.colorValues:
        productTypeList = widget.product.colorValues ?? [];
        break;
      case TypeValue.unitMeasureValues:
        productTypeList = widget.product.unitMeasureValues ?? [];
        break;
      case TypeValue.workflowValues:
        productTypeList = widget.product.workflowValues ?? [];
        break;
      case TypeValue.customizableValues:
        productTypeList = widget.product.customizableValues ?? [];
        break;
      case TypeValue.visibitlityValues:
        productTypeList = widget.product.visibitlityValues ?? [];
        break;
      case TypeValue.manufacturingStatusValues:
        productTypeList = widget.product.manufacturingStatusValues ?? [];
        break;
      default:
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
    selectedValue = "";
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
                showBottomSheet(productTypeList);
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
                      hintStyle: AppTextStyle.normalBlackGrey16
                          .copyWith(color: const Color(0XFF979797)),
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
            child: MultiSelectBottomSheetContent(
              productTypeList: productTypeList,
              label: widget.text,
              onListItemTap: (v) {
                ProductTypeValues value = v as ProductTypeValues;
                selectedValue = _setDropdownValue(value.name!);
                controller.text = selectedValue;
                widget.onChanged(selectedValue);
              },
            ),
          );
        });
      },
    );
  }

  String _setDropdownValue(String value) {
    if (selectedValue.isEmpty) {
      selectedList.add(value);
    } else {
      selectedList.contains(value)
          ? selectedList.remove(value)
          : selectedList.add(value);
    }
    selectedValue = selectedList.join(" | ");
    return selectedValue;
  }
}
