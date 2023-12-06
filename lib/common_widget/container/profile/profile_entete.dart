import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/button/round_button.dart';

class ProfileEntete extends StatelessWidget {
  const ProfileEntete(this.username, {super.key});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(
            "assets/img/u1.png",
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                  color: TColor.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Course à pied",
                style: TextStyle(
                  color: TColor.gray,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
        
      ],
    );
  }
}
