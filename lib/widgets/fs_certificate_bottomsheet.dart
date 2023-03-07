import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/factoryos/profile/model/certificate_list_values.dart';
import 'package:fs_app/theme/text_style.dart';

import '../../../constant/img_const.dart';

class CertificateBottomSheetContent extends StatefulWidget {
  final CertificateSectionsAttributes certificateSectionsAttributes;
  final Function(dynamic v, int index) onListItemTap;
  final Function(dynamic v, int index,String? fileName) onListItemViewTap;
  final dynamic selectedImages;
  const CertificateBottomSheetContent(
      {Key? key, required this.certificateSectionsAttributes,
        required this.onListItemTap,
        required this.onListItemViewTap,
        required this.selectedImages
      })
      : super(key: key);

  @override
  State<CertificateBottomSheetContent> createState() => _CertificateBottomSheetContentState();
}

class _CertificateBottomSheetContentState extends State<CertificateBottomSheetContent> {
  late List<CertificateListValues> certificateListValues;

  @override
  void initState() {
    super.initState();
    certificateListValues = widget.certificateSectionsAttributes.certificateListValues ??=[];
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      key: UniqueKey(),
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
                        "${widget.certificateSectionsAttributes.name!}",
                        style: AppTextStyle.mediumBlack14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  certificateListValues.isEmpty
                      ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: const Center(
                      child: Text(
                        'No item found!',
                        style: AppTextStyle.mediumBlack14,
                      ),
                    ),
                  )
                      :
                  _listItem

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
      var imageItem = widget.selectedImages[index];
      CertificateListValues profileSectionsAttributeValue =
      certificateListValues[index];
      return Column(
          key: UniqueKey(),
          children:[
            Container(
              decoration: imageItem != null && imageItem != "" ? null: const BoxDecoration(
                  border: Border(
                      bottom:  BorderSide(
                          width: 2,
                          color: ColorConst.shadowGreyColor
                      )
                  )
              ),
            child:ListTile(
              onTap: () =>
                  onListTap(profileSectionsAttributeValue.isSelected, index),
              title: Align(
                  alignment: Alignment.centerLeft,
                  child:Text(
                profileSectionsAttributeValue.name!,
                style: AppTextStyle.mediumBlueLabel14,
              )),
              trailing: imageItem != null && imageItem != ""  ? null:
              _buildSelectIcon()
          ),
            ),
            imageItem != null && imageItem != "" ?
            Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:  BorderSide(
                            width: 2,
                            color: ColorConst.shadowGreyColor
                        )
                    )
                ),
              child: ListTile(
                  onTap: () =>
                      onListTap(profileSectionsAttributeValue.isSelected, index),
                  title: Align(
                      alignment: Alignment.centerLeft,
                      child:Text(
                        imageItem!,
                        style: AppTextStyle.mediumBlack14,
                      )),
                  trailing: GestureDetector(
                    onTap: (){
                      onListViewTap(profileSectionsAttributeValue.isSelected, index, imageItem);
                    },
                    child:const Padding(
                      padding: EdgeInsets.all(6),
                      child:Text(
                        "View",
                        style: AppTextStyle.mediumRedLabel14,

                      )
                    )
                  ),
              )
            )
                :
                SizedBox()
          ]
      );
    },
    itemCount: certificateListValues.length,
    shrinkWrap: true,
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.vertical,
  );

  Widget _buildSelectIcon() {
    return Padding(
        padding: const EdgeInsets.all(6),
        child:SvgPicture.asset(ImageConst.uploadIcpon,
            height: 16, width: 8, fit: BoxFit.scaleDown));
  }

  void onListTap(bool isSelected, int index) {
    setState(() {
      certificateListValues[index].isSelected = !isSelected;
      widget.onListItemTap(certificateListValues[index], index);
    });
  }

  void onListViewTap(bool isSelected, int index, String? fileName) {
    setState(() {
      certificateListValues[index].isSelected = !isSelected;
      widget.onListItemViewTap(certificateListValues[index], index, fileName);
    });
  }
}
