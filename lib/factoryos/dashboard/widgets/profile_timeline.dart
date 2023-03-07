import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/services/shared_preference_service.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../../constant/text_const.dart';
import '../dashboard_controller.dart';
import '../model/section.dart';

class ProfileTimeline extends StatelessWidget {
  final Section section;
  ProfileTimeline(this.section);
  SharedPreferenceService preferenceService = Get.find<SharedPreferenceService>();


  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: ColorConst.factoryBgColor,
            ),
        child: Row(children: [
          _buildTimeLine(section.done, section.isFirst, section.isLast, section.isActive),
          Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                _buildCard(section),
              ]))
        ]));
  }

  Widget _buildCard(Section section) {
    return Expanded(
      child: GestureDetector(
        onTap: (){
          if(section.isActive == true || section.done == true) {
            preferenceService.setInt(TextConst.activeProfileSection, section.activeSectionId ?? 1);
            preferenceService.setInt(TextConst.activeProfileSectionProfile, section.activeSectionId ?? 1);
            Get.toNamed(section.action ?? AppRoute.dashboard);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
          child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: section.isActive == true ?
                      Border.all(color: ColorConst.white, width: 1): null,
                  color: ColorConst.factoryBoxColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(section.iconPath!,
                      height: 24, width: 24, fit: BoxFit.contain),
                  const SizedBox(width: 18.0),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(section.title!,
                              style: AppTextStyle.normalBlack12
                                  .copyWith(color: ColorConst.white.withOpacity(0.6)),
                              textAlign: TextAlign.left),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(section.subTitle!,
                              style: AppTextStyle.mediumBlack15.copyWith(
                                  color:
                                      section.done! ? ColorConst.white :
                                      section.isActive! ? ColorConst.white: ColorConst.white.withOpacity(0.6)),
                              textAlign: TextAlign.left)
                        ]),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildTimeLine(bool? done, bool? isFirst, bool? isLast, bool? isActive) {
    return Container(
        height: 95,
        width: 34,
        child: TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0,
          isFirst: isFirst!,
          isLast: isLast!,
          indicatorStyle: (isActive != null && isActive != false) ?
          IndicatorStyle(
              width: 34,
              height: 74,
              color: ColorConst.factoryBgColor,
              indicator: SvgPicture.asset(ImageConst.activefilledCirle))
              :
          done != null && done != false
              ? IndicatorStyle(
                  width: 34,
                  height: 74,
                  color: ColorConst.factoryBgColor,
                  indicator: SvgPicture.asset(ImageConst.successTickSvg))
              : IndicatorStyle(
                  width: 34,
                  height: 74,
                  color: ColorConst.factoryBgColor,
                  indicator: SvgPicture.asset(ImageConst.greyfilledCirle)),
          afterLineStyle: done != null && done != false
              ? const LineStyle(thickness: 4, color: ColorConst.white):
          const LineStyle(thickness: 4, color: ColorConst.timeLineShadow),
          beforeLineStyle: (done != null && done != false) || (isActive != null && isActive != false)
              ? const LineStyle(thickness: 4, color: ColorConst.white):
          const LineStyle(thickness: 4, color: ColorConst.timeLineShadow),
        ));
  }
}
