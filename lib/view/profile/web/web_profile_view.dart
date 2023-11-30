import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/view/profile/all_platforme/profile_view_allplatforme.dart';

class WebProfileView extends StatefulWidget {
  const WebProfileView({super.key});

  @override
  State<WebProfileView> createState() => _WebProfileView();
}

class _WebProfileView extends State<WebProfileView> {
  bool positive = false;

  List accountArr = [
    {
      "image": "assets/img/p_personal.png",
      "name": "Changer son pseudo ",
      "tag": "1"
    },
    {
      "image": "assets/img/p_personal.png",
      "name": "Changer son email ",
      "tag": "3"
    },
    {
      "image": "assets/img/p_personal.png",
      "name": "Changer son mot de passe ",
      "tag": "2"
    },
  ];

  List otherArr = [
    {
      "image": "assets/img/p_contact.png",
      "name": "Nous contacter !!",
      "tag": "5"
    },
    {
      "image": "assets/img/p_privacy.png",
      "name": "Politique de confidentialité",
      "tag": "6"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ProfileViewAllPlatforme(positive, accountArr, otherArr);
  }
}
