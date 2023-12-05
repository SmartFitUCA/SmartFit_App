import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/container/container_stats.dart';

class WebLigneContainerStats extends StatelessWidget {
  const WebLigneContainerStats(
      this.value1,
      this.value2,
      this.value3,
      this.designation1,
      this.designation2,
      this.designation3,
      this.icon1,
      this.icon2,
      this.icon3,
      {Key? key})
      : super(key: key);

  final String value1;
  final String value2;
  final String value3;

  final String designation1;
  final String designation2;
  final String designation3;

  final IconData icon1;
  final IconData icon2;
  final IconData icon3;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
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
        const SizedBox(height: 20),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ContainerStats(value1, designation1, icon1),
                const SizedBox(width: 20),
                ContainerStats(value2, designation2, icon2),
                const SizedBox(width: 20),
                ContainerStats(value3, designation3, icon3),
              ],
            )),
        const Divider(height: 30),
      ],
    );
  }
}
