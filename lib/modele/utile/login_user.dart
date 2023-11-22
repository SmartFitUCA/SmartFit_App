import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/modele/api/request_api.dart';
import 'package:smartfit_app_mobile/modele/api/i_data_strategy.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:tuple/tuple.dart';

class Login {
  final IDataStrategy api = RequestApi();

  Future<Tuple2<bool, String>> checkLoginAndPassword(
      String email, String password) async {
    Tuple2<bool, String> result = await api.connexion(
        email, sha256.convert(utf8.encode(password)).toString());
    return result;
  }

  Future<Tuple2<bool, Map<dynamic, dynamic>>> getUserInfo(String token) async {
    Tuple2 result = await api.getInfoUser(token);
    if (result.item1 == false) {
      return const Tuple2(false, <String, String>{"Empty": "Empty"});
    }
    return Tuple2(true, result.item2);
  }

  void fillUser(BuildContext context, Map<dynamic, dynamic> map, String token) {
    context.read<User>().email = map["email"];
    context.read<User>().username = map["username"];
    context.read<User>().token = token;
  }
}
