import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/setting_row.dart';
import 'package:smartfit_app_mobile/view/profile/change_email.dart';
import 'package:smartfit_app_mobile/view/profile/change_password.dart';
import 'package:smartfit_app_mobile/view/profile/change_username.dart';

class ProfileCompte extends StatelessWidget {
  const ProfileCompte(this.accountArr, {super.key});

  final List accountArr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
          color: TColor.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Compte",
            style: TextStyle(
              color: TColor.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: accountArr.length,
            itemBuilder: (context, index) {
              var iObj = accountArr[index];
              return SettingRow(
                icon: iObj["image"]!,
                title: iObj["name"]!,
                onPressed: () {
                  if (iObj["tag"] == "1") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangeUsernameView(),
                      ),
                    );
                  } else if (iObj["tag"] == "2") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangePasswordView(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangeEmailView(),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
