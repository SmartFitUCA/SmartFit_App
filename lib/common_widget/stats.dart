import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/modele/convertisseur.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';

class Stats extends StatelessWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String calories = Provider.of<User>(context, listen: false)
        .managerSelectedActivity
        .getCalorieAllActivitySelected()
        .toString();
    String heartrate = Provider.of<User>(context, listen: false)
        .managerSelectedActivity
        .activitySelected
        .first
        .activityInfo
        .bpmAvg
        .toString();
    String time = Convertisseur.secondeIntoMinute(
            Provider.of<User>(context, listen: false)
                .managerSelectedActivity
                .getTimeAllActivitySelected())
        .toStringAsFixed(0);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              const Text(
                'Statistiques',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.pie_chart_rounded,
                size: 15,
                color: TColor.secondaryColor1,
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 15),
              InfoStat(
                icon: Icons.timer,
                iconColor: const Color.fromARGB(255, 255, 255, 255),
                iconBackground: const Color(0xff6131AD),
                time: '+5s',
                label: 'Time',
                value: '$time min',
              ),
              const SizedBox(width: 15),
              InfoStat(
                icon: Icons.favorite_outline,
                iconColor: const Color.fromARGB(255, 255, 255, 255),
                iconBackground: const Color(0xff6131AD),
                time: '+5s',
                label: 'Heart Rate',
                value: "$heartrate BPM",
              ),
              const SizedBox(width: 15),
              InfoStat(
                icon: Icons.bolt,
                iconColor: const Color.fromARGB(255, 255, 255, 255),
                iconBackground: const Color(0xff6131AD),
                time: '+5s',
                label: 'Energy',
                value: "$calories kCal",
              ),
              const SizedBox(width: 30),
            ],
          ),
        )
      ],
    );
  }
}

class InfoStat extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String time;
  final String label;
  final String value;

  const InfoStat({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.time,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 110,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color(0xffe1e1e1),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(3, 3),
              blurRadius: 3,
            ),
          ]),
      child: Stack(
        children: [
          StatIcon(
            icon: icon,
            iconColor: iconColor,
            iconBackground: iconBackground,
            sizeIcon: 8.0,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 10),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StatIcon extends StatelessWidget {
  const StatIcon({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.sizeIcon,
  }) : super(key: key);

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final double? sizeIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: iconBackground,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Icon(icon, size: sizeIcon, color: iconColor),
    );
  }
}
