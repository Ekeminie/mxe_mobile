import 'package:flutter/material.dart';
import 'package:mxe_mobile/core/services/user.service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/ui/auth/login/new-user/phone-number-auth.dart';

class AuthWrapper extends StatelessWidget {
  final userService = getIt<UserService>();
  final Widget child;

  AuthWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (userService.isLoggedIn) {
      // User is logged in, allow access to the child widget
      return child;
    } else {
      // User is not logged in, redirect to login page
      return const PhoneNumberAuthPage();
    }
  }
}
