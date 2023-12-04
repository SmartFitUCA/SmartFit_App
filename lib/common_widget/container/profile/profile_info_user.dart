import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common_widget/title_subtitle_cell.dart';
import 'package:smartfit_app_mobile/modele/user.dart';

class ProfileInfoUser extends StatelessWidget {
  const ProfileInfoUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TitleSubtitleCell(
            title: context.watch<User>().listActivity.length.toString(),
            subtitle: "Nombre d'activité",
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: TitleSubtitleCell(
            title: context.watch<User>().getTotalTimeAllActivity().toString(),
            subtitle: "Temps en activité",
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: TitleSubtitleCell(
            title:
                "${context.watch<User>().getTotalDenivelePositif().toString()} + m",
            subtitle: "Total dénivelé positif",
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: TitleSubtitleCell(
            title:
                "${context.watch<User>().getTotalDeniveleNegatif().toString()} - m",
            subtitle: "Total dénivelé négatif",
          ),
        ),
      ],
    );
  }
}
