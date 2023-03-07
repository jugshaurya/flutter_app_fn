import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/factoryos/profile/model/profile_section_attr_response.dart';
import 'package:fs_app/factoryos/profile/widget/profile_bottom_sheet_content.dart';
import 'package:fs_app/theme/text_style.dart';

class ProfileSingleDropdown extends StatefulWidget {
  final ProfileSectionsAttributes profileSectionsAttributes;
  final String label;
  final String text;
  final Function(dynamic v, dynamic i) onChanged;

  const ProfileSingleDropdown({
    Key? key,
    required this.profileSectionsAttributes,
    required this.text,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  State<ProfileSingleDropdown> createState() => _ProfileSingleDropdownState();
}

class _ProfileSingleDropdownState extends State<ProfileSingleDropdown> {
  late final TextEditingController controller;
  List selectedList = [];
  var selectedValue = "";

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    selectedValue = "";
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
          showBottomSheet(widget
              .profileSectionsAttributes.profileSectionsAttributeValues);
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
                hintStyle: AppTextStyle.normalBlackGrey12,
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

  showBottomSheet(
      List<ProfileSectionsAttributeValues>? profileSectionsAttributeValueList) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
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
            height: MediaQuery.of(context).size.height * 0.6,
            child: ProfileBottomSheetContent(
              profileSectionsAttributes: widget.profileSectionsAttributes,
              onListItemTap: (v) {
                ProfileSectionsAttributeValues value =
                v as ProfileSectionsAttributeValues;
                selectedValue = _setDropdownValue(value.name!);
                controller.text = selectedValue;
                widget.onChanged(selectedValue, v.id);
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
    selectedValue = selectedList.last;
    return selectedValue;
  }
}
