import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/container/profile/profile_compte.dart';
import 'package:smartfit_app_mobile/common_widget/container/profile/profile_entete.dart';
import 'package:smartfit_app_mobile/common_widget/container/profile/profile_info_user.dart';
import 'package:smartfit_app_mobile/common_widget/container/profile/profile_notification.dart';
import 'package:smartfit_app_mobile/common_widget/container/profile/profile_other.dart';
import 'package:smartfit_app_mobile/modele/api/api_wrapper.dart';
import 'package:smartfit_app_mobile/modele/user.dart';

class ProfileViewAllPlatforme extends StatefulWidget {
  final bool positive;
  final List accountArr;
  final List otherArr;
  const ProfileViewAllPlatforme(this.positive, this.accountArr, this.otherArr,
      {super.key});

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
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 20,
              width: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: TColor.lightGray,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                "assets/img/more_btn.png",
                width: 15,
                height: 15,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
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
              ProfileNotification(widget.positive),
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
