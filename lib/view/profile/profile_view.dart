import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/view/profile/mobile/mobile_profile_view.dart';
import 'package:smartfit_app_mobile/view/profile/web/web_profile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const MobileProfileView(),
      desktop: (_) => const WebProfileView(),
    );
  }
}
