import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_attr_response.dart';
import 'package:fs_app/theme/text_style.dart';

import '../../../constant/img_const.dart';

class ProfileBottomSheetContent extends StatefulWidget {
  final ProfileSectionsAttributes profileSectionsAttributes;
  final Function(dynamic v) onListItemTap;

  const ProfileBottomSheetContent(
      {Key? key, required this.profileSectionsAttributes, required this.onListItemTap})
      : super(key: key);

  @override
  State<ProfileBottomSheetContent> createState() => _ProfileBottomSheetContentState();
}

class _ProfileBottomSheetContentState extends State<ProfileBottomSheetContent> {
  late List<ProfileSectionsAttributeValues> profileSectionsAttributeValues;

  @override
  void initState() {
    super.initState();
    profileSectionsAttributeValues = widget.profileSectionsAttributes.profileSectionsAttributeValues ??=[];
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
                        "${widget.profileSectionsAttributes.name!}",
                        style: AppTextStyle.mediumBlack14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  profileSectionsAttributeValues.isEmpty
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
          ProfileSectionsAttributeValues profileSectionsAttributeValue =
              profileSectionsAttributeValues[index];
          return Container(
              decoration: const BoxDecoration(
                      border: Border(
                          bottom:  BorderSide(
                              width: 2,
                              color: ColorConst.lightGrey
                          )
                      )
                  ),
              child:ListTile(
              onTap: () =>
                  onListTap(profileSectionsAttributeValue.isSelected, index),
              title: Text(
                profileSectionsAttributeValue.name!,
                style: AppTextStyle.mediumBlack14,
              ),
              leading:
                  _buildSelectIcon(profileSectionsAttributeValue.isSelected)));
        },
        itemCount: profileSectionsAttributeValues.length,
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
      profileSectionsAttributeValues[index].isSelected = !isSelected;
      widget.onListItemTap(profileSectionsAttributeValues[index]);
    });
  }
}
