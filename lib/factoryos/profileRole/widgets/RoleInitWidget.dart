import 'package:flutter/material.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/constant/text_const.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:get/get.dart';
import '../../../services/shared_preference_service.dart';


class RoleInitWidget extends StatefulWidget {
  final PageController pageController;
  final int currentIndex;
  final SharedPreferenceService preferenceService;
  final Function onPageChanged;

  const RoleInitWidget(
      {Key? key,
        required this.pageController,
        required this.currentIndex,
      required this.preferenceService,
      required this.onPageChanged})
      : super(key: key);

  @override
  State<RoleInitWidget> createState() => _RoleInitWidgetState();
}

class _RoleInitWidgetState extends State<RoleInitWidget> {
  SharedPreferenceService preferenceService = Get.find<SharedPreferenceService>();
  String? fullName;

  @override
  void initState() {
   fullName = preferenceService.getString(TextConst.full_name) ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var fullName = preferenceService.getString(TextConst.full_name);
    return SafeArea(
      child:Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size(0, 80),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: AppBar(
              toolbarHeight: 90,
              backgroundColor: ColorConst.white,
              shadowColor: ColorConst.white,
              elevation: 0,
              titleTextStyle: AppTextStyle.boldBlack16,
              title: SizedBox(),
              actions: [
                GestureDetector(
                    onTap: (){
                      preferenceService.clearData();
                      Get.offAndToNamed(AppRoute.login);
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: RichText(
                            textAlign: TextAlign.start,
                            text: const TextSpan(
                              text: "Logout",
                              style: AppTextStyle.w700Blue16,
                            )
                        )
                    )
                ),
                // IconButton(
                //   onPressed: () {},
                //   icon: SvgPicture.asset(
                //       "assets/icons/svgs/notification.svg"),
                // ),
                // IconButton(
                //   onPressed: () {},
                //   icon: SvgPicture.asset("assets/icons/svgs/chat.svg"),
                // ),
              ],
            ),
          ),
        ),
        body:SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text("Hi $fullName !",
                          textAlign: TextAlign.left,
                          style: AppTextStyle.w700textBlack24.copyWith(fontSize: 36)),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        child: const Text("We want some information about you!",
                            textAlign: TextAlign.left,
                            style: AppTextStyle.labelGrayQuardernary24,)
                      ),
                    ),
                    SizedBox(height: 120,),
                    SizedBox(
                      height: 336,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: ColorConst.greyBorderColor)
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                            children: [
                              const Text(
                                  "Tell us who you’re providing  for and give us a few details about yourself.",
                            textAlign: TextAlign.left,
                            style: AppTextStyle.w700labelGray24),
                              const SizedBox(height: 100,),
                              Container(
                                  alignment: Alignment.bottomCenter,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: ColorConst.primary
                                  ),

                                  child: InkWell(
                                    onTap: () {
                                      widget.pageController.nextPage(
                                          duration: const Duration(milliseconds: 10),
                                          curve: Curves.bounceIn);
                                    },
                                    child: const Center(
                                      child: Text(
                                        "Add",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                           ]
                      )
                    ),
                      )
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}


