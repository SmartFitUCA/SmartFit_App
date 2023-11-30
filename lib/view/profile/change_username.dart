import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/view/profile/mobile/mobile_change_username.dart';
import 'package:smartfit_app_mobile/view/profile/web/web_change_username.dart';

class ChangeUsernameView extends StatefulWidget {
  const ChangeUsernameView({super.key});

  @override
  State<ChangeUsernameView> createState() => _ChangeUsernameViewState();
}

class _ChangeUsernameViewState extends State<ChangeUsernameView> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const MobileChangeUsernameView(),
      desktop: (_) => const WebChangeUsernameView(),
    );
  }
}
