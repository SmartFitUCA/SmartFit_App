import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/modele/activity.dart';

class User extends ChangeNotifier {
  String username = "VOID";
  String email = "VOID";
  String token = "VOID";
  List<ActivityOfUser>? listActivity;
}
