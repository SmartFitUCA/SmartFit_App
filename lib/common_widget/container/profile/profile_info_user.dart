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
            title: "X",
            subtitle: "Nombre d'activité",
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: TitleSubtitleCell(
            title: "h/j",
            subtitle: "Temps en activité",
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: TitleSubtitleCell(
            title: "+ m",
            subtitle: "Total dénivelé positif",
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: TitleSubtitleCell(
            title: "- m",
            subtitle: "Total dénivelé négatif",
          ),
        ),
      ],
    );
  }
}
