import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:provider/provider.dart';

import 'base.vm.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child)? builder;
  final Function(T)? onModelReady;
  const BaseView({Key? key, this.builder, this.onModelReady}) : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  T model = getIt<T>();

  @override
  void initState() {
    super.initState();
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => model,
      child: Consumer<T>(
        builder: (_, model, __) => Stack(
          children: [
            widget.builder!.call(_, model, __),
            if (model.isLoading)
              Stack(children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: ModalBarrier(
                    color: Colors.white.withOpacity(.7),
                    dismissible: false,
                  ),
                ),
                Center(
                    child: Image.asset(
                  "assets/animation/Loader.gif",
                  height: 100,
                  width: 100,
                ))
              ])
            else
              const SizedBox(),
            if (model.hasError)
              Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(children: [
                  ModalBarrier(
                    color: Colors.black12.withOpacity(.8),
                    dismissible: false,
                  ),
                  Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      50.sbH,
                      Text(
                        model.errorMessage!,
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp),
                        textAlign: TextAlign.center,
                      ),
                      32.sbH,
                      if (model.retryFunction != null)
                        GestureDetector(
                            onTap: () => model.retryFunction!(),
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 32.w),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(32)),
                              child: Center(
                                child: Text(
                                  "Retry",
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )),
                      16.sbH,
                      GestureDetector(
                          onTap: () => model.clearError(),
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 32.w),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(32)),
                            child: Center(
                              child: Text(
                                "Close",
                                style: TextStyle(
                                    color: AppColors.primaryDark,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          )),
                      const Spacer(),
                    ],
                  ))
                ]),
              )
            else
              const SizedBox(),
          ],
        ),
      ),
    );
  }
}
