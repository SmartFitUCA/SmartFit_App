import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/Modele/user.dart';
import 'package:smartfit_app_mobile/common_widget/helpers.dart';
import 'package:flutter/material.dart';

class Steps extends StatelessWidget {
  const Steps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("lhwaa");

    String steps = Provider.of<User>(context, listen: false).listActivity[0].getTotalSteps();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text(
            steps,
            style: const TextStyle(
              fontSize: 33,
              fontWeight: FontWeight.w900,
            ),
          ),
          const Text(
            'Total Steps',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              height: 2,
            ),
          ),
        ],
      ),
    );
  }
}