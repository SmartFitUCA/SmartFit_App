import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/container/profile/profile_compte.dart';
import 'package:smartfit_app_mobile/common_widget/container/profile/profile_entete.dart';
import 'package:smartfit_app_mobile/common_widget/container/profile/profile_info_user.dart';
import 'package:smartfit_app_mobile/common_widget/container/profile/profile_notification.dart';
import 'package:smartfit_app_mobile/common_widget/container/profile/profile_other.dart';
import 'package:smartfit_app_mobile/modele/user.dart';

class ProfileViewAllPlatforme extends StatefulWidget {
  const ProfileViewAllPlatforme(this.positive, this.accountArr, this.otherArr,
      {super.key});
  final bool positive;
  final List accountArr;
  final List otherArr;

  @override
  State<ProfileViewAllPlatforme> createState() => _ProfileViewAllPlatforme();
}

class _ProfileViewAllPlatforme extends State<ProfileViewAllPlatforme> {
  @override
  Widget build(BuildContext context) {
    String username = context.watch<User>().username;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leadingWidth: 0,
        title: Text(
          "Profile",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileEntete(username),
              const SizedBox(
                height: 15,
              ),
              const ProfileInfoUser(),
              const SizedBox(
                height: 25,
              ),
              ProfileCompte(widget.accountArr),
              const SizedBox(
                height: 25,
              ),
             
              ProfileOther(widget.otherArr)
            ],
          ),
        ),
      ),
    );
  }
}
