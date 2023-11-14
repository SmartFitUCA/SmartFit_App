import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:smartfit_app_mobile/Modele/Api/i_data_strategy.dart';
import 'package:smartfit_app_mobile/Modele/Api/request_api.dart';
import 'package:tuple/tuple.dart';

class SignUp {
  final IDataStrategy api = RequestApi();

  Future<Tuple2<bool, String>> createUser(
      String email, String username, String password) async {
    return await api.postUser(
        email, sha256.convert(utf8.encode(password)).toString(), username);
  }
}
