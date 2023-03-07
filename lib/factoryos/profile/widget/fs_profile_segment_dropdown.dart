import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/factoryos/inventory/model/TypeValue.dart';
import 'package:fs_app/factoryos/inventory/model/product_model.dart';
import 'package:fs_app/factoryos/inventory/widget/multi_select_bottom_sheet_content.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_attr_response.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:get/get.dart';

class FsMultiSegmentSelectDropdown extends StatefulWidget {
  final ProfileSectionsAttributes profileSectionsAttributes;
  final Product? product;
  final TypeValue type;
  final String text;
  final String label;
  final bool isMandatory;
  final Function(dynamic v, dynamic w) onChanged;
  final List<dynamic>? garmentId;

  const FsMultiSegmentSelectDropdown({
    Key? key,
    required this.profileSectionsAttributes,
    required this.product,
    required this.type,
    required this.text,
    required this.label,
    required this.isMandatory,
    required this.onChanged,
    this.garmentId,
  }) : super(key: key);

  @override
  State<FsMultiSegmentSelectDropdown> createState() => _FsSingleSelectDropdownState();
}

class _FsSingleSelectDropdownState extends State<FsMultiSegmentSelectDropdown> {
  late final TextEditingController controller;
  List<ProductTypeValues> productTypeList = [];
  List selectedList = [];
  List<dynamic> selectedIdList = [];
  var selectedValue = "";

  getProductTypeValues() async {
    switch (widget.type) {
      case TypeValue.segmentTypeValues:
        productTypeList =
            widget.product != null ?
            widget.product!.segmentTypeValues ?? []: [];
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
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      /*Text(
            widget.profileSectionsAttributes.name!,
            style: AppTextStyle.normalBlackGrey14,
          ),*/
      // const SizedBox(height: 4),
      InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          SharedPreferenceService preferenceService = Get.find<SharedPreferenceService>();
          var garmentList = preferenceService.getString(TextConst.garmentTypes) ?? "";
          if(widget.type == TypeValue.segmentTypeValues){
            productTypeList =
                widget.product != null && widget.product!.segmentTypeValues != null && garmentList != "" ? widget.product!.segmentTypeValues!.where((element) => garmentList.indexOf(element.garmentTypeId.toString()) != -1).toList() : [];
          }

          showBottomSheet(productTypeList);
          }, //widget.callback(),
        child: IgnorePointer(
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                if (widget.profileSectionsAttributes.isMandatory!) {
                  return 'Select ${widget.profileSectionsAttributes.name}';
                }
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // enabled: true,
            // readOnly: true,
            decoration: InputDecoration(
                label: RichText(
                  text: TextSpan(
                    text: widget.label,
                    style: AppTextStyle.normalhintGrey14,
                    children: [
                      TextSpan(
                          text: widget.profileSectionsAttributes.isMandatory! ? ' *' : "",
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16))
                    ],),
                ),
                hintText: 'Select',
                hintStyle: AppTextStyle.normalhintGrey12,
                errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: ColorConst.redPrimary)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: ColorConst.lightGrey)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: ColorConst.lightGrey)),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: ColorConst.lightGrey)),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                floatingLabelStyle:
                MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                  final Color color = states.contains(MaterialState.error)
                      ? ColorConst.lightGrey
                      : ColorConst.lightGrey;
                  return TextStyle(color: color, letterSpacing: 1.3);
                }),
                suffixIcon: SvgPicture.asset(ImageConst.arrowDownImage,
                    height: 16, width: 8, fit: BoxFit.scaleDown)),
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
              label: widget.label,
              onListItemTap: (v) {
                ProductTypeValues value = v as ProductTypeValues;
                selectedValue = _setDropdownValue(value.name!, value);
                controller.text = selectedValue;
                widget.onChanged(selectedValue, selectedIdList);
              },
            ),
          );
        });
      },
    );
  }

  String _setDropdownValue(String value, ProductTypeValues val) {
    if (selectedValue.isEmpty) {
      selectedList.add(value);
      selectedIdList.add({"id":val.id, "name": val.name!});
    } else {
      selectedIdList.add({"id":val.id, "name": val.name!});
      if(selectedList.contains(value)){
        selectedList.remove(value);
      }else{
        selectedList.add(value);
      }
    }
    selectedValue = selectedList.join(" | ");
    return selectedValue;
  }
}
