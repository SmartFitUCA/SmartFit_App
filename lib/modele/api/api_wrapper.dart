import 'package:smartfit_app_mobile/modele/api/i_data_strategy.dart';
import 'package:smartfit_app_mobile/modele/api/request_api.dart';
import 'package:smartfit_app_mobile/modele/utile/info_message.dart';
import 'package:email_validator/email_validator.dart';
import 'package:tuple/tuple.dart';

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
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
