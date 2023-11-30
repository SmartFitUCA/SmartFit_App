import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/setting_row.dart';
import 'package:smartfit_app_mobile/view/profile/contact_us_view.dart';
import 'package:smartfit_app_mobile/view/profile/policy_view.dart';

class ProfileOther extends StatelessWidget {
  const ProfileOther(this.otherArr, {super.key});

  final List otherArr;

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
            "Autre",
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
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: otherArr.length,
            itemBuilder: (context, index) {
              var iObj = otherArr[index] as Map? ?? {};
              return SettingRow(
                icon: iObj["image"].toString(),
                title: iObj["name"].toString(),
                onPressed: () {
                  if (iObj["tag"] == "6") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyView(),
                      ),
                    );
                  } else if (iObj["tag"] == "5") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContactUsView(),
                      ),
                    );
                  } else {
                    // Autre logique si nécessaire pour d'autres éléments de la liste
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }
}
