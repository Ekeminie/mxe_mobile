import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/constant/palette.dart';
import 'package:mxe_mobile/core/model/request/auth.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/auth/login/login.vm.dart';
import 'package:mxe_mobile/utils/keyboard-utils.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/input.dart';

class LoginPage extends StatefulWidget {
  final LoginRequest? request;
  const LoginPage({Key? key, this.request}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
        onModelReady: (m) => m.prefillDetails(widget.request),
        builder: (context, model, child) => SafeArea(
                child: Scaffold(
              resizeToAvoidBottomInset: true,
              extendBody: true,
              // backgroundColor: Colors.black26,
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      width: width(context),
                      height: height(context),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("loginBg".png),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                      left: 20,
                      top: 50,
                      child: Image.asset(
                        'logo'.png,
                        height: 35.h,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          54.sbH,
                          52.sbH,
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 48.w),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40.r),
                                    topLeft: Radius.circular(40.r)),
                                color: Colors.white.withOpacity(0.5)),
                            child: AutofillGroup(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  50.sbH,
                                  20.sbH,
                                  Input(
                                    autofillHints: const [AutofillHints.email],
                                    key: const Key("email"),
                                    onChanged: (v) => model.email = v,
                                    textColor: AppColors.primaryDark,
                                    hintText: "Email",
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    controller: model.emailController,
                                    labelText: 'Email Address',
                                    hintStyleColor:
                                        AppColors.primaryDark.withOpacity(0.3),
                                    underlineBorderStyle: BorderSide(
                                        width: 1,
                                        color:
                                            AppColors.white.withOpacity(0.5)),
                                  ),
                                  16.0.sbH,
                                  Input(
                                    autofillHints: const [
                                      AutofillHints.password
                                    ],
                                    key: const Key("password"),
                                    textColor: AppColors.primaryDark,
                                    onChanged: (v) => model.password = v,
                                    hintText: "",
                                    textInputAction: TextInputAction.done,
                                    // keyboardType: TextInputType.,
                                    obscureText: model.obscurePassword,
                                    controller: model.passwordController,
                                    labelText: 'Password',
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () =>
                                              model.togglePasswordVisibility(),
                                          icon: model.obscurePassword
                                              ? const Icon(
                                                  Icons.visibility_off_outlined,
                                                  color: AppColors.primaryDark,
                                                )
                                              : const Icon(
                                                  Icons.visibility_outlined,
                                                  color: AppColors.primaryDark,
                                                ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SvgPicture.asset(
                                            'fingerprint'.svg,
                                            width: 20.w,
                                            height: 20.h,
                                            color: AppColors.primaryDark,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onSubmit: (v) => {
                                      dropKeyboard(),
                                      model.isValidInput
                                          ? model.login()
                                          : model.showValidationMessage(),
                                    },
                                    onSaved: (v) => {
                                      dropKeyboard(),
                                      model.isValidInput
                                          ? model.login()
                                          : model.showValidationMessage(),
                                    },
                                    hintStyleColor:
                                        AppColors.primaryDark.withOpacity(0.3),
                                    underlineBorderStyle: BorderSide(
                                        width: 1,
                                        color:
                                            AppColors.white.withOpacity(0.5)),
                                  ),
                                  20.sbH,
                                  GestureDetector(
                                    onTap: () => model.navigationService
                                        .navigateTo(Routes.forgotPasswordRoute),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Forgot Password ?',
                                        style: GoogleFonts.inter(
                                            color: AppColors.primaryDark,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp),
                                      ),
                                    ),
                                  ),
                                  46.sbH,
                                  UiButton(
                                    text: "Login",
                                    onPressed: () => model.isValidInput
                                        ? model.login()
                                        : model.showValidationMessage(),
                                    color: AppColors.primaryColor,
                                    textColor: white,
                                  ),
                                  12.sbH,
                                  10.sbH,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Don't have an account?",
                                        style: TextStyle(
                                            color: textDark,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp),
                                      ),
                                      GestureDetector(
                                        onTap: () => //Routes.signupRoute
                                            Navigator.pushNamed(context,
                                                Routes.reportPageRoute),
                                        child: Text(
                                          " Sign up",
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                  50.sbH,
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                // child: SizedBox(
                //   height: height(context),
                //   child: Stack(
                //     children: [
                //       Container(
                //         width: width(context),
                //         height: height(context),
                //         decoration: BoxDecoration(
                //             image: DecorationImage(
                //                 image: AssetImage("loginBg".png),
                //                 fit: BoxFit.cover)),
                //       ),
                //       Positioned(
                //         left: 20,
                //         top: 50,
                //         child: Image.asset(
                //           'logo'.png,
                //           height: 35.h,
                //         ),
                //       ),
                //       Align(
                //         alignment: Alignment.bottomCenter,
                //         // bottom: 0,
                //         // right: 0,
                //         // left: 0,
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           mainAxisSize: MainAxisSize.min,
                //           children: [
                //             54.sbH,
                //             52.sbH,
                //             Container(
                //               padding:
                //                   EdgeInsets.symmetric(horizontal: 48.w),
                //               width: double.infinity,
                //               decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.only(
                //                       topRight: Radius.circular(40.r),
                //                       topLeft: Radius.circular(40.r)),
                //                   color: Colors.white.withOpacity(0.5)),
                //               child: SingleChildScrollView(
                //                 physics: AlwaysScrollableScrollPhysics(),
                //                 child: Column(
                //                   crossAxisAlignment:
                //                       CrossAxisAlignment.start,
                //                   mainAxisAlignment: MainAxisAlignment.end,
                //                   children: [
                //                     42.sbH,
                //                     Text(
                //                       "Welcome Back!",
                //                       style: TextStyle(
                //                           color: AppColors.primaryDark,
                //                           fontWeight:
                //                               NCStyles.getWeightFromString(
                //                                   'semi-bold'),
                //                           fontSize: 28.sp),
                //                     ),
                //                     Text(
                //                         "Navigate wealth creation with secure access.",
                //                         style: NCStyles.body.copyWith(
                //                             fontWeight: NCStyles
                //                                 .getWeightFromString(
                //                                     'light'),
                //                             color: AppColors.primaryDark)),
                //                     20.sbH,
                //                     Input(
                //                       key: const Key("email"),
                //                       onChanged: (v) => model.email = v,
                //                       textColor: AppColors.primaryDark,
                //                       hintText: "Email",
                //                       textInputAction: TextInputAction.next,
                //                       keyboardType:
                //                           TextInputType.emailAddress,
                //                       controller: model.emailController,
                //                       labelText: 'Email Address',
                //                       hintStyleColor: AppColors.primaryDark
                //                           .withOpacity(0.3),
                //                       underlineBorderStyle: BorderSide(
                //                           width: 1,
                //                           color: AppColors.white
                //                               .withOpacity(0.5)),
                //                     ),
                //                     16.0.sbH,
                //                     Input(
                //                       key: const Key("password"),
                //                       textColor: AppColors.primaryDark,
                //                       onChanged: (v) => model.password = v,
                //                       hintText: "",
                //                       textInputAction: TextInputAction.done,
                //                       // keyboardType: TextInputType.,
                //                       obscureText: model.obscurePassword,
                //                       controller: model.passwordController,
                //                       labelText: 'Password',
                //                       suffixIcon: Row(
                //                         mainAxisSize: MainAxisSize.min,
                //                         children: [
                //                           IconButton(
                //                             onPressed: () => model
                //                                 .togglePasswordVisibility(),
                //                             icon: model.obscurePassword
                //                                 ? const Icon(
                //                                     Icons
                //                                         .visibility_off_outlined,
                //                                     color: AppColors
                //                                         .primaryDark,
                //                                   )
                //                                 : const Icon(
                //                                     Icons
                //                                         .visibility_outlined,
                //                                     color: AppColors
                //                                         .primaryDark,
                //                                   ),
                //                           ),
                //                           Padding(
                //                             padding:
                //                                 const EdgeInsets.all(10),
                //                             child: SvgPicture.asset(
                //                               'fingerprint'.svg,
                //                               width: 20.w,
                //                               height: 20.h,
                //                               color: AppColors.primaryDark,
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                       onSubmit: (v) => {
                //                         dropKeyboard(),
                //                         model.isValidInput
                //                             ? model.login()
                //                             : model.showValidationMessage(),
                //                       },
                //                       onSaved: (v) => {
                //                         dropKeyboard(),
                //                         model.isValidInput
                //                             ? model.login()
                //                             : model.showValidationMessage(),
                //                       },
                //                       hintStyleColor: AppColors.primaryDark
                //                           .withOpacity(0.3),
                //                       underlineBorderStyle: BorderSide(
                //                           width: 1,
                //                           color: AppColors.white
                //                               .withOpacity(0.5)),
                //                     ),
                //                     54.0.sbH,
                //                     32.sbH,
                //                     UiButton(
                //                       text: "Login",
                //                       onPressed: () => model.isValidInput
                //                           ? model.login()
                //                           : model.showValidationMessage(),
                //                       color: AppColors.primaryColor,
                //                       textColor: white,
                //                     ),
                //                     12.sbH,
                //                     GestureDetector(
                //                       onTap: () => model.navigationService
                //                           .navigateTo(
                //                               Routes.forgotPasswordRoute),
                //                       child: Center(
                //                         child: Text(
                //                           'Forgot Password ?',
                //                           style: GoogleFonts.inter(
                //                               color: AppColors.primaryDark,
                //                               fontWeight: FontWeight.w600,
                //                               fontSize: 14.sp),
                //                         ),
                //                       ),
                //                     ),
                //                     16.sbH,
                //                     50.sbH,
                //                   ],
                //                 ),
                //               ),
                //             )
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // )
              ),
            )));
  }
}

class SkipToHomeButton extends StatelessWidget {
  const SkipToHomeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, Routes.homeRoute),
      child: Text(
        "Skip",
        style: GoogleFonts.manjari(
            color: primaryColor, fontWeight: FontWeight.w700, fontSize: 16.sp),
      ),
    );
  }
}
