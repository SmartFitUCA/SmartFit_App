import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common_widget/title_subtitle_cell.dart';

class ProfileInfoUser extends StatelessWidget {
  const ProfileInfoUser({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: TitleSubtitleCell(
            title: "??? cm",
            subtitle: "Taille",
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: TitleSubtitleCell(
            title: "?? kg",
            subtitle: "Poids",
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: TitleSubtitleCell(
            title: "?? ans",
            subtitle: "Age",
          ),
        ),
      ],
    );
  }
}
