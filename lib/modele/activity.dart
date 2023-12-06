import 'package:flutter/foundation.dart';

class ActivityOfUser {
  // A afficher
  late String _categorie;
  late String _date;
  late String _fileUuid;
  late String _nameFile;
  // ------------ //
  late String _imageName;

  List<List<dynamic>> _contentActivity = List.empty(growable: true);
  Map<String, int> _enteteCSV = {};

  String get fileUuid => _fileUuid;
  String get nameFile => _nameFile;
  String get categorie => _categorie;
  String get date => _date;
  Map<String, int> get enteteCSV => _enteteCSV;

  // -- Getter/Setter -- Ancien //
  List<List<dynamic>> get contentActivity => _contentActivity;
  set contentActivity(List<List<dynamic>> content) {
    _contentActivity = content;
    for (int i = 0; i < content.first.length; i++) {
      _enteteCSV.addAll({content.first[i]: i});
    }
    _contentActivity.removeAt(0);
  }

  ActivityOfUser(
      String date, String categorie, String fileUuid, String nameFile) {
    _categorie = categorie;
    _date = date;
    _fileUuid = fileUuid;
    _nameFile = nameFile;

    // Mettre dans une fonction appart
    if (categorie == "Walking") {
      _imageName = "assets/img/workout1.svg";
    } else {
      // Mettre des conditions pour d'autre type d'activité
      _imageName = "assets/img/workout1.svg";
    }
  }

  // -------------------------- FIN Localisation  ---------------------- //

  Map<String, dynamic> toMap() {
    return {'categorie': _categorie, 'image': _imageName, 'date': _date};
  }
}
