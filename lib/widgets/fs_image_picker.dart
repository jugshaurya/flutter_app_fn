import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fs_app/constant/color_const.dart';
import 'package:fs_app/theme/text_style.dart';
import 'package:fs_app/utils/log.dart';
import 'package:image_picker/image_picker.dart';

class FsImagePicker extends StatefulWidget {
  final String label;
  final String hint;
  final String text;
  final bool isManadatory;
  final Function(dynamic fileName, dynamic base64String) onSelect;

  const FsImagePicker({
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

class _FsImagePickerState extends State<FsImagePicker> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: widget.label,
              style: AppTextStyle.normalBlackGrey14,
              children: [
                TextSpan(
                    text: widget.isManadatory ? ' *' : "",
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16))
              ],),
          ),
          /*Text(
            widget.label,
            style: AppTextStyle.normalBlackGrey14,
          ),*/
          // const SizedBox(height: 4),
          GestureDetector(
            onTap: () => _chooseOptionDialog(context),
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
                hintText: widget.hint,
                hintStyle: AppTextStyle.normalBlackGrey12,
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorConst.lightGrey)),
                disabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorConst.lightGrey)),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      );

  _chooseOptionDialog(BuildContext context) async {
    _selected = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
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
        );
      },
    );

    if (_selected != null) {
      setState(() {
        _selected = _selected;
        pickImage();
      });
    }
  }

  File? image;
  late var _selected;
  var base64ImgString = "";

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
          source: StringUtils.equalsIgnoreCase(_selected, 'camera')
              ? ImageSource.camera
              : ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      List<int> imageBytes = imageTemp.readAsBytesSync();
      base64ImgString = base64Encode(imageBytes);
      // setState(() => this.image = imageTemp);
      controller.text = imageTemp.path;
      widget.onSelect(imageTemp.path, base64ImgString);
    } on PlatformException catch (e) {
      Log.logger.e('Failed to pick image: $e');
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
        setState(() {});
        break;
      case 'Video':
        result = await FilePicker.platform.pickFiles(type: FileType.video);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'Audio':
        result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.audio);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'All':
        result = await FilePicker.platform.pickFiles(allowMultiple: false);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
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
