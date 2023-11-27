import 'package:smartfit_app_mobile/modele/api/i_data_strategy.dart';
import 'package:smartfit_app_mobile/modele/api/request_api.dart';
import 'package:smartfit_app_mobile/modele/utile/info_message.dart';
import 'package:email_validator/email_validator.dart';
import 'package:tuple/tuple.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class ApiWrapper {
  IDataStrategy api = RequestApi();

  Future<bool> modifyUserInfo(String infoToModify, String value, String token,
      InfoMessage infoManager) async {
    if (infoToModify == 'email' && EmailValidator.validate(value) ||
        infoToModify == 'password' ||
        infoToModify == 'username') {
      Tuple2<bool, String> res =
          await api.modifAttribut(token, infoToModify, value);
      if (res.item1 == true) {
        infoManager.displayMessage(
            "${infoToModify.capitalize()} modified succesfully !", false);
        return true;
      } else {
        infoManager.displayMessage(
            "An error occured :/ Please try again.", true);
        return false;
      }
    } else {
      infoManager.displayMessage(
          "This is not a valid $infoToModify :/ Please try again.", true);
      return false;
    }
  }

  Future<Tuple2<bool, String>> login(
      String password, String email, InfoMessage infoManager) async {
    String hash = sha256.convert(utf8.encode(password)).toString();
    Tuple2<bool, String> res = await api.connexion(email, hash);

    if (res.item1) {
      return Tuple2(true, res.item2); // return token
    } else {
      infoManager.displayMessage(
          "Authentification failed! Enter your actual password carefully.",
          true);
      return const Tuple2(false, "An error occured during connexion!");
    } // need to be better
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
