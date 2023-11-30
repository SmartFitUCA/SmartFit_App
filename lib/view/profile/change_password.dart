import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/view/profile/mobile/mobile_change_password.dart';
import 'package:smartfit_app_mobile/view/profile/web/web_change_password.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const MobileChangePasswordView(),
      desktop: (_) => const WebChangePasswordView(),
    );
  }
}
