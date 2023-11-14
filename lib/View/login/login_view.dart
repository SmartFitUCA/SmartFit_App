import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/Modele/Api/i_data_strategy.dart';
import 'package:smartfit_app_mobile/Modele/Api/request_api.dart';
import 'package:smartfit_app_mobile/Modele/user.dart';
import 'package:smartfit_app_mobile/View/login/Mobile/android_login_view.dart';
import 'package:smartfit_app_mobile/View/login/web/web_login_view.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

String getPlatforme() {
  if (kIsWeb) {
    return "Web";
  }
  if (Platform.isAndroid) {
    return "Android";
  }
  if (Platform.isWindows) {
    return "Windows";
  }
  if (Platform.isMacOS) {
    return "MacOS";
  }
  return "Null";
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _obscureText = true;
  String _msgError = "";
  bool _errorLogin = false;
  IDataStrategy api = RequestApi();
  String platforme = getPlatforme();

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

  void fillUser(BuildContext context, Map<String, dynamic> map, String token) {
    context.read<User>().email = map["email"];
    context.read<User>().username = map["username"];
    context.read<User>().token = token;
    context.read<User>().listActivity = List.empty(growable: true);
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _printMsgError(String msgError) {
    _msgError = msgError;
    _errorLogin = true;
  }

  @override
  Widget build(BuildContext context) {
    if (platforme == "Android") {
      return AndroidLoginView(_obscureText, _errorLogin, _msgError, _toggle,
          _printMsgError, getUserInfo, checkLoginAndPassword, fillUser);
    } else {
      return WebLoginView(_obscureText, _errorLogin, _msgError, _toggle,
          _printMsgError, getUserInfo, checkLoginAndPassword, fillUser);
    }
  }
}
