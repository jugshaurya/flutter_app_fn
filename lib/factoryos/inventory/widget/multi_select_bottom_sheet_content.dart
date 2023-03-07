import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/factoryos/inventory/model/product_model.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_attr_response.dart';
import 'package:fs_app/theme/text_style.dart';

class MultiSelectBottomSheetContent extends StatefulWidget {
  final List<ProductTypeValues> productTypeList;
  final String label;
  final Function(dynamic v) onListItemTap;

  const MultiSelectBottomSheetContent(
      {Key? key, required this.productTypeList, required this.label, required this.onListItemTap})
      : super(key: key);

  @override
  State<MultiSelectBottomSheetContent> createState() => _MultiSelectBottomSheetContentState();
}

class _MultiSelectBottomSheetContentState extends State<MultiSelectBottomSheetContent> {
  // bool isSelected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(left: 12.0, right: 12, top: 12),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "${widget.label}",
                        style: AppTextStyle.mediumBlack14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  widget.productTypeList.isEmpty
                      ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: const Center(
                      child: Text(
                        'No item found!',
                        style: AppTextStyle.mediumBlack14,
                      ),
                    ),
                  )
                      : _listItem
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget get _listItem => ListView.builder(
    itemBuilder: (builder, index) {
      ProductTypeValues productTypeValues = widget.productTypeList[index];
      return Container(
          decoration: const BoxDecoration(
          border: Border(
          bottom:  BorderSide(
          width: 2,
          color: ColorConst.shadowGreyColor
      )
      )
      ),
      child:ListTile(
          onTap: () =>
              onListTap(productTypeValues.isSelected ?? false, index),
          title: Text(
            productTypeValues.name!,
            style: AppTextStyle.mediumBlack14,
          ),
          leading:
          _buildSelectIcon(productTypeValues.isSelected ?? false)));
    },
    itemCount: widget.productTypeList.length,
    shrinkWrap: true,
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.vertical,
  );

  Widget _buildSelectIcon(bool isSelected) {
    return isSelected
        ?  Padding(
        padding: EdgeInsets.all(6),
        child:SvgPicture.asset(ImageConst.checkedTickSvg,
            height: 40, width: 40, fit: BoxFit.scaleDown))
        : Padding(
        padding: EdgeInsets.all(6),
        child:SvgPicture.asset(ImageConst.unCheckedTickSvg,
            height: 40, width: 40, fit: BoxFit.scaleDown));
  }

  void onListTap(bool isSelected, int index) {
    setState(() {
      widget.productTypeList[index].isSelected = !isSelected;
      widget.onListItemTap(widget.productTypeList[index]);
    });
  }
}
