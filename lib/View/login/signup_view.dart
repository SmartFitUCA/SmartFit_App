import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/view/login/Mobile/android_signup_view.dart';
import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/view/login/web/web_signup_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const MobileSignUpView(),
      desktop: (_) => const WebSignUpView(),
    );
  }
}
