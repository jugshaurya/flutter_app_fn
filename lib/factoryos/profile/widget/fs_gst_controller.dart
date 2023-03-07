import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fs_app/factoryos/profile/model/gst_details_response.dart';
import 'package:get/get.dart';

import '../../../utils/app_utils.dart';
import 'fs_gst_repo.dart';

class GSTController extends GetxController {
  var isLoading = false.obs;
  var isGstAPIHit = false.obs;
  var lastGstValue = ''.obs;
  var isGstFetched = false.obs;
  TextEditingController gstController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();

  var gstNumber = "".obs;
  var gstCompanyAddress = "".obs;
  var gstCompanyName = "".obs;
  GSTDetailsRepo repository = Get.find<GSTDetailsRepo>();

  @override
  void onInit() {
    super.onInit();
    gstNumber.value = gstController.text;
    // gstCompanyAddress.value = companyAddressController.text;
    // gstCompanyName.value = companyNameController.text;
    gstController.addListener((){
      gstNumber.value = gstController.text;
      if(gstNumber.value.length == 15  && isGstAPIHit.value == false && gstNumber.value != lastGstValue.value){
        // isLoading.value = true;
        isGstAPIHit.value = true;
        lastGstValue.value = gstNumber.value;
        getGSTDetails();
        Future.delayed(const Duration(seconds: 2)).then((value) {
          isGstAPIHit.value = false;
          lastGstValue.value = "";
        });
      }
    });
    // isLoading.value = false;
  }

  @override
  void onClose() {
    gstNumber.value = "";
    companyAddressController.clear();
    companyNameController.clear();
    super.onClose();
  }

  Future<void> getGSTDetails() async {
    GSTDetailsResponse? gstResponse =
    await repository.getGSTDetails(gstNumber.value);
    isLoading.value = false;
    if (gstResponse != null) {
      isGstFetched.value = true;
      gstCompanyAddress.value = gstResponse.companyAddress!;
      gstCompanyName.value = gstResponse.companyName!;
      companyAddressController.text = gstCompanyAddress.value;
      companyNameController.text = gstCompanyName.value;
    }else{
      isGstFetched.value=false;
      companyAddressController.value = TextEditingValue(text:"");
      companyNameController.value = TextEditingValue(text:"");
      // Future.delayed(const Duration(seconds: 5)).then((value) {
      //   if(!isGstFetched.value) {
      //     AppUtils.bottomSnackbar("Warning", "Please enter a valid GST");
      //   }
      // });
    }
  }

}
