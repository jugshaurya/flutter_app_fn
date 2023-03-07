import 'dart:ui';

import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/img_const.dart';
import 'package:fs_app/routes/app_routes.dart';

class Section{
     String? iconPath;
     Color? bgColor;
     String? title;
     String? subTitle;
     String? btnTextStyle;
     bool? done;
     bool? isActive;
     bool isFirst;
     bool isLast;
     String? action;
     int? currentSectionIndex;
     int? activeSectionId;
     Section({
          this.iconPath,
          this.bgColor,
          this.title,
          this.subTitle,
          this.btnTextStyle,
          this.isActive,
          this.done,
          this.isFirst = false,
          this.isLast = false,
          this.action,
          this.currentSectionIndex,
          this.activeSectionId
});

     static String getIconPath(int index){
         switch(index){
              case 0:
                   return ImageConst.dashboardProfileIcon;
              case 1:
                   return ImageConst.dashboardContactIcon;
              case 2:
                   return ImageConst.dashboardDocumentIcon;
              case 3:
                   return ImageConst.dashboardWorkflowIcon;
         }
         return "";
     }

     static String getTitle(int index){
          switch(index){
               case 0:
                    return "Profile";
               case 1:
                    return "Inventory";
               case 2:
                    return "Vendors";
               case 3:
                    return "Workflow";
          }
          return "";

     }
     static String getSubTitle(int index){
          switch(index){
               case 0:
                    return "Complete Profile";
               case 1:
                    return "Add Products";
               case 2:
                    return "Add Vendors";
               case 3:
                    return "Manage Workflow";
          }
          return "";
     }

     static String getAction(int index){
          switch(index){
               case 0:
                    return AppRoute.profile;
               case 1:
                    return "";
               case 2:
                    return "";
               case 3:
                    return "";
          }
          return "";
     }

     static List<Section> generateSections(){
          // List<Section> detailList = [];
          // SectionList.asMap().forEach((index, value){
          //
          //      detailList.add(Section(
          //                     iconPath:getIconPath(index),
          //                     bgColor: ColorConst.shadowWhite,
          //                     btnTextStyle: "labelWhite12",
          //                     title: getTitle(index),
          //                     subTitle: getSubTitle(index),
          //                     done: false,
          //                     isFirst: index == 0,
          //                     action: getAction(index)
          //             ));
          // });
          // return detailList;
          return [
               Section(
                    iconPath: ImageConst.industryStatus,
                    bgColor: ColorConst.shadowWhite,
                    btnTextStyle: "labelWhite12",
                    title: "Step 1",
                    subTitle: "Industry Details",
                    done: false,
                    isActive: false,
                    isFirst: true,
                    isLast: false,
                    action: AppRoute.profileRole2Screen,
                    currentSectionIndex: 0,
                    activeSectionId: 1,
               ),
               Section(
                   iconPath: ImageConst.productStatus,
                   bgColor: ColorConst.shadowWhite,
                   btnTextStyle: "labelWhite12",
                   title: "Step 2",
                   subTitle: "Product Details",
                    done: false,
                    isActive: false,
                    isFirst: false,
                   isLast: false,
                   action: AppRoute.dashboard,
                    currentSectionIndex: 1,
                    activeSectionId: 1,
               ),
               Section(
                    iconPath: ImageConst.factoryStatus,
                    bgColor: ColorConst.shadowWhite,
                    btnTextStyle: "labelWhite12",
                    title: "Step 3",
                    subTitle: "Company Details",
                    done: false,
                    isActive: false,
                    isFirst: false,
                    isLast: false,
                    action: AppRoute.dashboard,
                    currentSectionIndex: 1,
                    activeSectionId: 2,
               ),
               Section(
                    iconPath: ImageConst.locationStatus,
                    bgColor: ColorConst.shadowWhite,
                    btnTextStyle: "labelWhite12",
                    title: "Step 4",
                    subTitle: "Factory Details",
                    done: false,
                    isActive: false,
                    isFirst: false,
                    isLast: true,
                    action: AppRoute.dashboard,
                    currentSectionIndex: 1,
                    activeSectionId: 3,
               )
          ];
     }



}