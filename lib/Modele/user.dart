import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/Modele/activity.dart';

class User extends ChangeNotifier {
  // A modifier
  late String _username;
  late String _email;
  late String _passwordHash;
  late List<ActivityOfUser> _listActivity;

  String get username => _username;
  String get email => _email;
  String get passwordHash => _passwordHash;
  List<ActivityOfUser> get listActivity => _listActivity;

  User(String username, String email, String passwordHash) {
    _username = username;
    _email = email;
    _passwordHash = passwordHash;
    _listActivity = List.empty(growable: true);
  }

  void addActivity(ActivityOfUser activity) {
    listActivity.add(activity);
    notifyListeners();
  }
}
