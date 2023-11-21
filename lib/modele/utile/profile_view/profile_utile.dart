import 'package:smartfit_app_mobile/modele/api/i_data_strategy.dart';
import 'package:smartfit_app_mobile/modele/api/request_api.dart';

class ProfileUtil {
  final IDataStrategy _dataStrategy = RequestApi();

  void modifyDataUser(String token, String attribut, String newUsername) {
    _dataStrategy.modifAttribut(token, attribut, newUsername);
  }
}
