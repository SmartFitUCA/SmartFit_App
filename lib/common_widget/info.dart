import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/Modele/user.dart';

class Info extends StatelessWidget {
  Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String distance= Provider.of<User>(context, listen: false).listActivity[0].getTotalDistance();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
  
        Stats(value: distance, unit: 'm', label: 'Distance'),

      ],
    );
  }
}

class Stats extends StatelessWidget {
  String value;
  String unit;
  String label;

  Stats({
    Key? key,
    required this.value,
    required this.unit,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
              text: value,
              style:  TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
              children: [
                 TextSpan(text: ' '),
                TextSpan(
                  text: unit,
                  style:  TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ]),
        ),
         SizedBox(height: 6),
        Text(
          label,
          style:  TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}