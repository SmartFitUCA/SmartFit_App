import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/container/container_stats.dart';

class LigneContainerStats extends StatelessWidget {
  const LigneContainerStats(this.value1, this.value2, this.value3,
      this.designation1, this.designation2, this.designation3,
      {Key? key})
      : super(key: key);

  final String value1;
  final String value2;
  final String value3;

  final String designation1;
  final String designation2;
  final String designation3;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(height: 30),
        
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
              SizedBox(width: 8),
              Icon(
                Icons.pie_chart_rounded,
                size: 15,
                color: TColor.secondaryColor1,
              ),
            ],
          ),
        ),

        SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 25),
        ContainerStats(value1, designation1, Icons.timer ),
        const SizedBox(width: 25),
        ContainerStats(value2, designation2, Icons.favorite_outline),
        const SizedBox(width: 25),
        ContainerStats(value3, designation3,  Icons.bolt),
      ],
    ),
    Divider(height: 30),
      ],
    );
    
    
  }
}
