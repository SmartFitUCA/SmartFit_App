import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/Modele/activity.dart';


import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/Modele/activity.dart';

class User extends ChangeNotifier {
  String? username;
  String? email;
  String? token;
  List<ActivityOfUser> listActivity = [];


  void addActivity(ActivityOfUser activity) {
    listActivity.add(activity);
    notifyListeners();
  }		  
}
