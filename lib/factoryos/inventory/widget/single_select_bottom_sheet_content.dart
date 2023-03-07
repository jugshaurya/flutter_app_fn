import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/factoryos/inventory/model/product_model.dart';
import 'package:fs_app/theme/text_style.dart';

class SingleSelectBottomSheetContent extends StatefulWidget {
  final List<ProductTypeValues> productTypeList;
  final String label;
  final Function(dynamic v) onListItemTap;

  const SingleSelectBottomSheetContent(
      {Key? key,
      required this.productTypeList,
      required this.label,
      required this.onListItemTap})
      : super(key: key);

  @override
  State<SingleSelectBottomSheetContent> createState() =>
      _SingleSelectBottomSheetContentState();
}

class _SingleSelectBottomSheetContentState
    extends State<SingleSelectBottomSheetContent> {
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
          return ListTile(
              onTap: () => onListTap(true, index),
              title: Text(
                productTypeValues.name!,
                style: AppTextStyle.mediumBlack14,
              ),
              leading: _buildSelectIcon(productTypeValues.isSelected ?? false));
        },
        itemCount: widget.productTypeList.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
      );

  Widget _buildSelectIcon(bool isSelected) {
    return isSelected
        ? Padding(
            padding: const EdgeInsets.all(6),
            child: SvgPicture.asset(ImageConst.selectedRadio,
                height: 16, width: 8, fit: BoxFit.scaleDown))
        : Padding(
            padding: const EdgeInsets.all(6),
            child: SvgPicture.asset(ImageConst.unSelectedRadio,
                height: 16, width: 8, fit: BoxFit.scaleDown));
  }

  void onListTap(bool isSelected, int index) {
    setState(() {
      for (int i = 0; i < widget.productTypeList.length; i++) {
        if (i == index) {
          widget.productTypeList[i].isSelected = isSelected;
        } else {
          widget.productTypeList[i].isSelected = false;
        }
      }
      widget.onListItemTap(widget.productTypeList[index]);
      Navigator.of(context).pop();
    });
  }
}
