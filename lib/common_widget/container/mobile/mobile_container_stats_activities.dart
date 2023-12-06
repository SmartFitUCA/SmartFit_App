import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/stats.dart';

class MobileContainerStatsActivities extends StatelessWidget {
  const MobileContainerStatsActivities(
    this.value,
    this.designation,
    this.icon, {
    Key? key,
  }) : super(key: key);

  final String value;
  final String designation;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Container(
      height: media.width * 0.4,
      width: media.width * 0.27,
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
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Centrer horizontalement
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          StatIcon(
            icon: icon,
            iconColor: TColor.white,
            iconBackground: TColor.secondaryColor1,
            sizeIcon: 30.0,
          ),
          const SizedBox(height: 20), // Espacement entre l'icône et le texte
          Text(
            designation,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
