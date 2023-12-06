import 'package:flutter/material.dart';
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
  // --- Time --- //
  double getTotalTimeAllActivity() {
    double totalTime = 0.0;
    for (ActivityOfUser activity in listActivity) {
      totalTime += activity.activityInfo.timeOfActivity;
    }
    return totalTime;
  }

  // ------------ Walking -------------- //
  // ---- Denivelé ---- //
  double getTotalDenivelePositifAllActivity() {
    double totalDevPos = 0.0;
    for (ActivityOfUser activity in listActivity) {
      totalDevPos += activity.activityInfo.denivelePositif;
    }
    return totalDevPos;
  }

  double getTotalDeniveleNegatifAllActivity() {
    double totalDevNeg = 0.0;
    for (ActivityOfUser activity in listActivity) {
      totalDevNeg += activity.activityInfo.deniveleNegatif;
    }
    return totalDevNeg;
  }

  // ------------ Volume -------------- //
  Map<String, dynamic> getVolumeWhithDuration(Duration timeSoustract) {
    List<ActivityOfUser> liste = [];
    for (ActivityOfUser activityOfUser in listActivity) {
      // Si l'activité à commencer après la dateActuelle moins 7 jours
      if (activityOfUser.activityInfo.startTime
          .isAfter(DateTime.now().subtract(timeSoustract))) {
        liste.add(activityOfUser);
      }
    }
    return _getVolume(liste);
  }

  Map<String, dynamic> getVolumeAllTime() {
    return _getVolume(listActivity);
  }

  Map<String, dynamic> _getVolume(List<ActivityOfUser> listeActivity) {
    Map<String, dynamic> map = {};
    ManagerSelectedActivity managerSelectedActivity = ManagerSelectedActivity();
    managerSelectedActivity.activitySelected = listActivity;

    map["nbActovity"] = managerSelectedActivity.activitySelected.length;
    managerSelectedActivity.getTimeAllActivitySelected();
    map["bpmAvg"] = managerSelectedActivity.getBpmAvgAllActivitieSelected();
    map["denivelePositif"] =
        managerSelectedActivity.getTotalDenivelePositifAllActivitySelected();
    map["speedAvg"] = managerSelectedActivity.getAvgSpeedAllActivitySelected();
    return map;
  }
}
