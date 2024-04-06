import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/ui/profile/profile.vm.dart';
import 'package:mxe_mobile/utils/file-picker-utils.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/input.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      onModelReady: (m) => m.editProfileInitialization(),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar("", bgColor: AppColors.bgColor),
        body: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header("Edit Profile"),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    38.sbH,
                    ValueListenableBuilder(
                      valueListenable: model.imageFile,
                      builder: (context, file, _) => GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => openFilePicker(
                            context, (v) => model.imageFile.value = v,
                            showDocs: false),
                        child: Badge(
                            padding: EdgeInsets.zero,
                            alignment: Alignment.topRight,
                            offset: const Offset(0, 0),
                            largeSize: 30,
                            isLabelVisible: true,
                            backgroundColor: Colors.transparent,
                            label: SvgPicture.asset('edit-image'.svg),
                            child: file.path.isNotNullNorEmpty
                                ? ClipOval(
                                    child: Container(
                                      width: 200.0,
                                      height: 200.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(file.path),
                                            fit: BoxFit.fill),
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0)),
                                      ),
                                    ),
                                  )
                                : SvgPicture.asset('image_ph'.svg)),
                      ),
                    ),
                    12.sbH,
                    AutoSizeText(
                      "${model.userService.userCredentials.value.MXETag}",
                      style: AppTextStyle.labelMdRegular
                          .copyWith(color: AppColors.bgContrast),
                    ),
                    32.sbH,
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.disabledBg,
                                borderRadius: BorderRadius.circular(12)),
                            child: Input(
                              readOnly: true,
                              enabled: false,
                              autofocus: false,
                              prefixText:
                                  "${model.userService.userCredentials.value.firstName}",
                              hintText:
                                  "${model.userService.userCredentials.value.firstName}",
                              onChanged: (v) => {},
                            ),
                          ),
                          16.sbH,
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.disabledBg,
                                borderRadius: BorderRadius.circular(12)),
                            child: Input(
                              readOnly: true,
                              enabled: false,
                              autofocus: false,
                              prefixText:
                                  "${model.userService.userCredentials.value.lastName}",
                              hintText:
                                  "${model.userService.userCredentials.value.lastName}",
                              onChanged: (v) => {},
                            ),
                          ),
                          16.sbH,
                          Input(
                            hintText: "Phone Number",
                            prefixWidget: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                16.sbW,
                                SvgPicture.asset('ngn-flag'.svg),
                                5.sbW,
                                const Text("+234"),
                                5.sbW,
                                const Icon(Icons.keyboard_arrow_down_rounded)
                              ],
                            ),
                            readOnly: true,
                            onChanged: (v) => {},
                            controller: model.phoneNumberController,
                          ),
                          16.sbH,
                          Input(
                            hintText: "Email",
                            readOnly: true,
                            onChanged: (v) => {},
                            controller: model.emailController,
                          ),
                        ],
                      ),
                    ),
                    16.sbH,
                    32.sbH,
                    24.sbH,
                    ValueListenableBuilder(
                      valueListenable: model.imageFile,
                      builder: (context, file, _) => UiButton(
                        text: "Continue",
                        onPressed: file.path.isNotNullNorEmpty
                            ? () => model.uploadPhoto(file: file)
                            : null,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
