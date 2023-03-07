import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/factoryos/profile/model/certificate_list_values.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:fs_app/utils/app_utils.dart';
import 'package:fs_app/utils/log.dart';
import 'package:fs_app/widgets/fs_certificate_bottomsheet.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../constant/img_const.dart';

class FsCertificatePicker extends StatefulWidget {
  final String label;
  final String hint;
  final String text;
  final bool isManadatory;
  final Function(dynamic index,dynamic fileName, dynamic base64String) onSelect;

  const FsCertificatePicker({
    Key? key,
    required this.label,
    required this.hint,
    required this.text,
    required this.onSelect,
    this.isManadatory = false,
  }) : super(key: key);

  @override
  _FsImagePickerState createState() => _FsImagePickerState();
}

class _FsImagePickerState extends State<FsCertificatePicker> {
  late final TextEditingController controller;

  File? image;
  late var _selected;
  late var _viewImage;
  late var _finalSelected = {0:controller.text != null ?
  controller.text: "", 1: controller.text != null  ? controller.text : ""};
  late var _fileMap={};
  var base64ImgString = "";

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
    List<String> imageList = widget.text.split(",");
    imageList.asMap().forEach((key, value) {
      _finalSelected[key] = value;
      _fileMap[key] = value;
    });
    setState(() {
      _fileMap= {..._fileMap};
      _finalSelected= {..._finalSelected};
    });

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    key: UniqueKey(),
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      /*Text(
            widget.label,
            style: AppTextStyle.normalBlackGrey14,
          ),*/
      // const SizedBox(height: 4),
      GestureDetector(
        onTap: (){
          showBottomSheet(
            CertificateListValues.getCertificateList()
          );
          // _chooseOptionDialog(context)
        },
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if(value == null || value.isEmpty){
              if(widget.isManadatory) {
                return widget.hint;
              }
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          enabled: false,
          decoration: InputDecoration(
          label: RichText(
          text: TextSpan(
          text: widget.label,
          style: AppTextStyle.normalhintGrey14,
          children: [
          TextSpan(
          text: widget.isManadatory ? ' *' : "",
          style: const TextStyle(
          color: Colors.red,
          fontSize: 16))
          ],),
          ),
          hintText: widget.hint,
          hintStyle: AppTextStyle.normalhintGrey12,
          border: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorConst.lightGrey)),
          focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorConst.lightGrey)),
          enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorConst.lightGrey)),
          disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorConst.lightGrey)),
          floatingLabelStyle:
          MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
          final Color color = states.contains(MaterialState.error)
          ? ColorConst.lightGrey
              : ColorConst.lightGrey;
          return TextStyle(color: color, letterSpacing: 1.3);
          }),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
      ),
      const SizedBox(height: 20),
    ],
  );


  showBottomSheet(
      List<CertificateListValues>? profileSectionsAttributeValueList) {
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
            key: UniqueKey(),
            height: MediaQuery.of(context).size.height * 0.6,
            child: CertificateBottomSheetContent(
                key: UniqueKey(),
                selectedImages: _finalSelected.isNotEmpty ? _finalSelected : {},
                certificateSectionsAttributes: CertificateSectionsAttributes.getCertificateAttribute(),
              onListItemTap: (v, index) {
                CertificateListValues value =
                v as CertificateListValues;
                if(value != null) {
                  Log.logger.e("In here value selection", value);
                  _chooseOptionDialog(context, index);
                }
              },
                onListItemViewTap:(v, index, fileName) {
                  CertificateListValues value =
                  v as CertificateListValues;
                  Log.logger.e("In here value selection",value);
                  _displayDialog(context, index, fileName);
                },
            ),
          );
        });
      },
    );
  }

  _displayDialog(BuildContext context, int index, String? fileName) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 0),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(
          key: UniqueKey(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children:<Widget> [
                  GestureDetector(
                      onTap: () {},
                      child: Container(
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Align(
                                      alignment: Alignment.centerLeft,
                                      child:Text(
                                        "Image Selected",
                                        style: AppTextStyle.w700textBlack24,
                                      )),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).pop();
                                    },
                                    child:   Container(
                                      height: 40,
                                      width: 40,
                                      child: Center(
                                          child: SvgPicture.asset(ImageConst.crossIcon, width: 10,)
                                      ),
                                      decoration: BoxDecoration(color: ColorConst.shadowColor, borderRadius: BorderRadius.circular(99)),
                                    )

                                  )
                                ]
                              )
                              ),
                              const SizedBox(height: 30,),
                              _fileMap[_finalSelected[index]]!= null && _fileMap[_finalSelected[index]].indexOf("https://") == -1 ?
                              getImagenBase64(_fileMap[_finalSelected[index]]):
                              getImagenSrc(fileName ?? _fileMap[index]),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                   MaterialButton(
                                       shape: RoundedRectangleBorder(
                                           borderRadius: BorderRadius.circular(8)
                                       ),
                                       color: ColorConst.redPrimary,
                                       onPressed:() {
                                         _fileMap[_finalSelected[index]] = "";
                                         _finalSelected[index] = "";
                                         _fileMap= {..._fileMap, _finalSelected[index]: ""};
                                         _finalSelected= {..._finalSelected, index:""};
                                         setState(() {
                                           _fileMap= {..._fileMap, _finalSelected[index]: ""};
                                           _finalSelected= {..._finalSelected, index:""};
                                         });
                                         widget.onSelect(index,_finalSelected[index], "");
                                         Navigator.of(context).pop();
                                         Navigator.of(context).pop();
                                         showBottomSheet(
                                             CertificateListValues.getCertificateList()
                                         );
                                       },
                                     child:const Text(
                                         "Remove",
                                         style: TextStyle(
                                           color: Colors.white,
                                           fontFamily: "Inter",
                                           fontWeight: FontWeight.bold,
                                           fontSize: 16,
                                         ),
                                       ),
                                   ),
                                  const SizedBox(
                                    width: 30
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    color: ColorConst.redPrimary,
                                    onPressed:() {
                                      Navigator.of(context).pop();
                                      _chooseOptionDialog(context, index);
                                    },
                                    child:const Text(
                                      "Replace",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ]
                        )
                      )
                  )
                ],
            ),
          ),
        );
      },
    );
  }

  Widget getImagenBase64(String imagen) {
    const Base64Codec base64 = Base64Codec();
    if (imagen == null) return new Container();
    var bytes = base64.decode(imagen);
    return Image.memory(
      bytes,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.6,
      fit: BoxFit.fitWidth,

    );
  }

  Widget getImagenSrc(String imagen) {
    if (imagen == null) return new Container();
    return Image.network(
      imagen,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.6,
      fit: BoxFit.fitWidth,
    );
  }

  _chooseOptionDialog(BuildContext context, int index) async {
    _selected = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: SimpleDialog(
            title: const Text(
              'Choose',
              style: AppTextStyle.mediumBlack14,
            ),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, "Camera");
                },
                child: const Text(
                  'Pick Image from Camera',
                  style: AppTextStyle.normalBlackGrey12,
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, "Gallery");
                },
                child: const Text(
                  'Pick Image from Gallery',
                  style: AppTextStyle.normalBlackGrey12,
                ),
              ),
            ],
            elevation: 10,
            //backgroundColor: Colors.green,
          ),
        );
      },
    );

    if (_selected != null) {
      setState(() {
        _selected = _selected;
        _finalSelected= {..._finalSelected, index:_selected};
        pickImage(index);
      });
    }
  }



  Future pickImage(int index) async {
    try {
      final image = await ImagePicker().pickImage(
          source: StringUtils.equalsIgnoreCase(_selected, 'camera')
              ? ImageSource.camera
              : ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      List<int> imageBytes = imageTemp.readAsBytesSync();
      base64ImgString = base64Encode(imageBytes);
      controller.text = imageTemp.path;
      _finalSelected = {..._finalSelected, index: imageTemp.path};
      _fileMap = {..._fileMap, image.path: base64ImgString};
      _finalSelected[index]= imageTemp.path;
      _fileMap[image.path]= base64ImgString;
      _finalSelected[index]= imageTemp.path;
      _fileMap[image.path]= base64ImgString;
      _finalSelected = _finalSelected;
      _fileMap = _fileMap;
      Navigator.of(context).pop();
      showBottomSheet(
          CertificateListValues.getCertificateList()
      );  
      widget.onSelect(index , imageTemp.path, [_fileMap[_finalSelected[0]],_fileMap[_finalSelected[1]]].join(","));


    } on PlatformException catch (e) {
      Log.logger.e('Failed to pick image: $e');
      AppUtils.bottomSnackbar("Warning:", "Failed to Upload Certificate!");
    }
  }

  FilePickerResult? result;
  PlatformFile? file;

  void pickFiles(String? filetype) async {
    switch (filetype) {
      case 'Image':
        result = await FilePicker.platform.pickFiles(type: FileType.image);
        if (result == null) return;
        file = result!.files.first;
        setState(() {
          _finalSelected=_finalSelected;
          _fileMap=_fileMap;
        });
        break;
      case 'Video':
        result = await FilePicker.platform.pickFiles(type: FileType.video);
        if (result == null) return;
        file = result!.files.first;
        setState(() {
          _finalSelected=_finalSelected;
          _fileMap=_fileMap;
        });
        break;
      case 'Audio':
        result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.audio);
        if (result == null) return;
        file = result!.files.first;
        setState(() {
          _finalSelected=_finalSelected;
          _fileMap=_fileMap;
        });
        break;
      case 'All':
        result = await FilePicker.platform.pickFiles(allowMultiple: false);
        if (result == null) return;
        file = result!.files.first;
        setState(() {
          _finalSelected=_finalSelected;
          _fileMap=_fileMap;
        });
        break;
      case 'MultipleFile':
        result = await FilePicker.platform.pickFiles(allowMultiple: true);
        if (result == null) return;
        loadSelectedFiles(result!.files);
        break;
    }
  }
  // multiple file selected
  // navigate user to 2nd screen to show selected files
  void loadSelectedFiles(List<PlatformFile> files){

  }
  // open the picked file
  void viewFile(PlatformFile file) {
    // OpenFile.open(file.path);
  }

}
