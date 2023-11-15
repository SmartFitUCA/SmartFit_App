import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/view/login/mobile/android_login_view.dart';
import 'package:smartfit_app_mobile/view/login/web/web_login_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (_) => const MobileLoginView(),
        desktop: (_) => const WebLoginView());
  }
}
