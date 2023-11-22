import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/common_widget/button/round_button.dart';
import 'package:smartfit_app_mobile/common_widget/text_field/round_text_field.dart';
import 'package:smartfit_app_mobile/view/profile/mobile/mobile_change_password.dart';
import 'package:smartfit_app_mobile/view/profile/web/web_change_password.dart';

import '../../common/colo_extension.dart';

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
