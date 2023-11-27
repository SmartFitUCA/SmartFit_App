import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/view/profile/mobile/mobile_change_email.dart';
import 'package:smartfit_app_mobile/view/profile/web/web_change_email.dart';

class ChangeEmailView extends StatefulWidget {
  const ChangeEmailView({super.key});

  @override
  State<ChangeEmailView> createState() => _ChangeEmailViewState();
}

class _ChangeEmailViewState extends State<ChangeEmailView> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const MobileChangeEmailView(),
      desktop: (_) => const WebChangeEmailView(),
    );
  }
}
