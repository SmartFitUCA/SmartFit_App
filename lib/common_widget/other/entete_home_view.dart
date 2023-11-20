import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/view/home/notification_view.dart';

class EnteteHomeView extends StatelessWidget {
  const EnteteHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bienvenue,",
              style: TextStyle(color: TColor.gray, fontSize: 12),
            ),
            Text(
              "Benjelloun Othmane",
              style: TextStyle(
                  color: TColor.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationView(),
                ),
              );
            },
            icon: Image.asset(
              "assets/img/notification_active.png",
              width: 25,
              height: 25,
              fit: BoxFit.fitHeight,
            ))
      ],
    );
  }
}
