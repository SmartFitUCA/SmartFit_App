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

  void removeActivity(ActivityOfUser activity) {
    listActivity.remove(activity);
    notifyListeners();
  }

  // Method to insert an activity at a specific position
  void insertActivity(int index, ActivityOfUser activity) {
    listActivity.insert(index, activity);
    notifyListeners();
  }
}
