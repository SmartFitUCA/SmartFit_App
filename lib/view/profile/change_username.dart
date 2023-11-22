import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/common_widget/button/round_button.dart';
import 'package:smartfit_app_mobile/common_widget/text_field/round_text_field.dart';
import 'package:smartfit_app_mobile/view/profile/mobile/mobile_change_username.dart';
import 'package:smartfit_app_mobile/view/profile/web/web_change_username.dart';

import '../../common/colo_extension.dart';

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
