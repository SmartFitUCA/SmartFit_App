import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/modele/activity.dart';
import 'package:smartfit_app_mobile/modele/manager_selected_activity.dart';

class User extends ChangeNotifier {
  String username = "VOID";
  String email = "VOID";
  String token = "VOID";
  List<ActivityOfUser> listActivity = List.empty(growable: true);
  ManagerSelectedActivity managerSelectedActivity = ManagerSelectedActivity();

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

  // ------------ Fonction Calcul -------- //

  double getTotalTimeAllActivity() {
    double totalTime = 0.0;
    for (ActivityOfUser activity in listActivity) {
      totalTime += activity.time;
    }
    return totalTime;
  }

  double getTotalDenivelePositif() {
    double totalDevPos = 0.0;
    for (ActivityOfUser activity in listActivity) {
      totalDevPos += activity.denivelePos;
    }
    return totalDevPos;
  }

  double getTotalDeniveleNegatif() {
    double totalDevNeg = 0.0;
    for (ActivityOfUser activity in listActivity) {
      totalDevNeg += activity.denivelePos;
    }
    return totalDevNeg;
  }
}
