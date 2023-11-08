import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  // A modifier
  late String _username;
  late String _email;
  late String _passwordHash;

  String get username => _username;
  String get email => _email;
  String get passwordHash => _passwordHash;

  User(String username, String email, String passwordHash) {
    _username = username;
    _email = email;
    _passwordHash = passwordHash;
  }
}
