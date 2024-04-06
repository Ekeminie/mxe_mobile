import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../constant/palette.dart';

openFilePicker(BuildContext context, ValueChanged<File> file,
    {bool showDocs = true,
    bool allowMultiple = false,
    ValueChanged<List<File>>? files}) async {
  if (Platform.isAndroid) {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: showDocs ? FileType.custom : FileType.image,
          allowedExtensions:
              showDocs ? ['svg', 'jpg', 'jpeg', 'png', 'pdf'] : null,
          allowMultiple: allowMultiple);
      if (result != null) {
        if (allowMultiple) {
          List<File> v = result.paths.map((path) => File(path!)).toList();
          files!(v);
        } else {
          File v = File(result.files.single.path!);
          file(v);
        }
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  } else if (Platform.isIOS) {
    showDocs
        ? showImageOrFilePickerBottomSheetIos(
            context,
            (f) => file(f),
          )
        : openFilePickerForIOS((f) => file(f), showDocs,
            allowMultiple: allowMultiple, files: (f) => files!(f));
  }
}

//isDocument is false if user selected photos or gallery
openFilePickerForIOS(ValueChanged<File> file, bool isDocument,
    {bool allowMultiple = false, ValueChanged<List<File>>? files}) async {
  if (isDocument) {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['svg', 'doc', 'docx', 'png', 'pdf', 'jpg'],
      );
      if (result != null) {
        File v = File(result.files.single.path!);
        file(v);
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  } else {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: allowMultiple);
      if (result != null) {
        if (allowMultiple) {
          List<File> v = result.paths.map((path) => File(path!)).toList();
          files!(v);
        } else {
          File v = File(result.files.single.path!);
          file(v);
        }
      }
    } catch (e) {
      debugPrint("Error: plus $e");
    }
  }
}

class ImagePickerBottomSheet extends StatelessWidget {
  ValueChanged<File> file;

  ImagePickerBottomSheet({Key? key, required this.file}) : super(key: key);

  XFile? photo;
  final ImagePicker _picker = ImagePicker();

  void getImage({ImageSource_? source}) async {
    photo = ImageSource_.camera_ == source
        ? await _picker.pickImage(source: ImageSource.camera)
        : await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      file(File(photo!.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      borderRadius: BorderRadius.circular(14),
      // maxHeight: height(context) / 2.5,
      minHeight: 180.h,
      panelBuilder: (ScrollController sc) => ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80.w,
                    height: 2,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: grey, width: 1)),
                  ),
                  30.0.sbH,
                  imageBottomSheetTile(
                      title: "Photo",
                      icon: "gallery",
                      callback: () => {
                            openFilePickerForIOS((f) => file(f), false),
                            Navigator.pop(context)
                          }),
                  24.0.sbH,
                  imageBottomSheetTile(
                      title: "Document",
                      icon: "document",
                      callback: () => {
                            openFilePickerForIOS((f) => file(f), true),
                            // getImage(source: ImageSource_.gallery_),
                            Navigator.pop(context)
                          }),
                  // 10.0.sbH,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InkWell imageBottomSheetTile(
      {String? title, String? icon, VoidCallback? callback}) {
    return InkWell(
      onTap: () => callback!(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SizedBox(
          //     height: 30,
          //     width: 30,
          //     child: Padding(
          //       padding: EdgeInsets.all(2),
          //       child: SvgPicture.asset(
          //         icon!.svg,
          //         fit: BoxFit.contain,
          //       ),
          //     )),
          // 10.0.sbW,
          Text(
            title!,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 18.sp, color: textDark),
          )
        ],
      ),
    );
  }
}

showImageOrFilePickerBottomSheetIos(
    BuildContext context, ValueChanged<File> file) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ImagePickerBottomSheet(
          file: (c) => file(c),
        );
      });
}

enum ImageSource_ { camera_, gallery_ }
