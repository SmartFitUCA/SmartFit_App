import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/modele/activity.dart';
import 'package:smartfit_app_mobile/modele/activity_info/activity_info.dart';
import 'package:smartfit_app_mobile/modele/api/api_wrapper.dart';
import 'package:smartfit_app_mobile/modele/manager_selected_activity.dart';
import 'package:smartfit_app_mobile/modele/utile/info_message.dart';
import 'package:tuple/tuple.dart';

class User extends ChangeNotifier {
  String username = "VOID";
  String email = "VOID";
  String token = "VOID";
  List<ActivityOfUser> listActivity = List.empty(growable: true);
  ManagerSelectedActivity managerSelectedActivity = ManagerSelectedActivity();

  User();

  User.create(this.username, this.email, this.token);

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

  Map<String, dynamic> _getVolume(List<ActivityOfUser> list) {
    Map<String, dynamic> map = {};
    ManagerSelectedActivity selected = ManagerSelectedActivity();
    selected.activitySelected = list;

    map["nbActivity"] = selected.activitySelected.length;
    map["bpmAvg"] = selected.getBpmAvgAllActivitieSelected();
    map["denivelePositif"] =
        selected.getTotalDenivelePositifAllActivitySelected();
    map["speedAvg"] = selected.getAvgSpeedAllActivitySelected();
    map["durationActiviy"] = selected.getTimeAllActivitySelected();
    return map;
  }

  Future<Tuple2<bool, ActivityInfo>> predictActivity(
      DateTime date, String category, InfoMessage infoManager) async {
    ApiWrapper wrapper = ApiWrapper();
    Tuple2 result = await wrapper.getModeleAI(token, category, infoManager);

    if (!result.item1) return Tuple2(false, ActivityInfo());

    // Appel pour avoir le model
    //String jsonString =
    //    '{"coef": [270.63861280635473, 74.69699263779908, 1.9946527172333637, 0.03215810401413792, 0.3256805192289063], "intercept": [-335635.9890148213, -91874.0527070619, -2065.450392327813, -38.79838022998388, -291.590235396687]}';
    Map<String, dynamic> jsonMap = json.decode(result.item2);
    // Transformer la date
    int dateMilli = date.millisecondsSinceEpoch;

    ActivityInfo activityInfo = ActivityInfo();
    activityInfo.distance =
        jsonMap["coef"][0] * dateMilli + jsonMap["intercept"][0];
    activityInfo.timeOfActivity =
        jsonMap["coef"][1] * dateMilli + jsonMap["intercept"][1];
    activityInfo.denivelePositif =
        jsonMap["coef"][2] * dateMilli + jsonMap["intercept"][2];
    activityInfo.vitesseAvg =
        jsonMap["coef"][3] * dateMilli + jsonMap["intercept"][3];
    activityInfo.bpmAvg =
        jsonMap["coef"][4] * dateMilli + jsonMap["intercept"][4];

    return Tuple2(true, activityInfo);
  }
}
