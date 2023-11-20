import 'package:flutter/material.dart';
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
    return Row(
      children: [
        const SizedBox(width: 20),
        ContainerStats(value1, designation1),
        const SizedBox(width: 20),
        ContainerStats(value2, designation2),
        const SizedBox(width: 20),
        ContainerStats(value3, designation3),
      ],
    );
  }
}
