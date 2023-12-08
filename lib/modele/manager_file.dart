import 'dart:convert';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:fit_tool/fit_tool.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smartfit_app_mobile/modele/activity_info/activity_info.dart';
import 'package:tuple/tuple.dart';

class ManagerFile {
  // -- Field
  final String _fieldTimestamp = "timestamp";
  final String _fieldPositionLatitue = "position_lat";
  final String _fieldPositionLongitude = "position_long";
  final String _fieldDistance = "distance";
  final String _fieldBPM = "heart_rate";
  final String _fieldSpeed = "speed";
  final String _fieldAltitude = "altitude";
  final String _fieldTemperature = "temperature";

  // -- Not in CSV (Ligne session) -- //
  static const String _session = "session";
  static const String _startTime = "start_time";
  static const String _sport = "sport";
  static const String _timeActivity = "total_elapsed_time";
  static const String _totalDistance = "total_distance";
  static const String _totalCalories = "total_calories";
  static const String _totalStep = "total_strides";

  // -- Getter field
  String get fieldTimeStamp => _fieldTimestamp;
  String get fieldPositionLatitude => _fieldPositionLatitue;
  String get fieldPositionLongitude => _fieldPositionLongitude;
  String get fieldDistance => _fieldDistance;
  String get fielBPM => _fieldBPM;
  String get fieldSpeed => _fieldSpeed;
  String get fieldAltitude => _fieldAltitude;
  String get fieldTemperature => _fieldTemperature;

  // -- Categorie -- //
  static const String _generic = "generic";
  static const String _velo = "cycling";
  static const String _marche = "walking";

  // -- Getter categorie
  String get marche => _marche;
  String get generic => _generic;

  List<String> allowedFieldWalking = List.empty(growable: true);
  List<String> allowedFieldGeneric = List.empty(growable: true);
  List<String> allowedFieldCycling = List.empty(growable: true);

  ManagerFile() {
    allowedFieldWalking = [
      _fieldTimestamp,
      _fieldPositionLatitue,
      _fieldPositionLongitude,
      _fieldDistance,
      _fieldBPM,
      _fieldSpeed,
      _fieldAltitude,
      _fieldTemperature
    ];

    allowedFieldGeneric = [_fieldTimestamp, _fieldBPM];

    allowedFieldCycling = [
      _fieldTimestamp,
      _fieldPositionLatitue,
      _fieldPositionLongitude,
      _fieldDistance,
      _fieldBPM,
      _fieldSpeed,
      _fieldAltitude,
      _fieldTemperature
    ];
  }

  // -- Read the byte of file CSV -- //
  List<List<dynamic>> convertByteIntoCSV(Uint8List bytes) {
    return const CsvToListConverter().convert(utf8.decode(bytes));
  }

  String _getCategoryById(int id) {
    switch (id) {
      case 0:
        return _generic;
      case 2:
        return _velo;
      case 11:
        return _marche;
      default:
        return _generic;
    }
  }

  // ------------- Get The path of application --- //
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Tuple4<bool, List<List<String>>, ActivityInfo, String>
      convertBytesFitFileIntoCSVListAndGetInfo(Uint8List bytes) {
    List<Record> fitFile = FitFile.fromBytes(bytes).records;
    String categorie;
    List<String> fieldAllowed = [];
    ActivityInfo info = ActivityInfo();
    // -- Chercher ligne session -- //
    List<dynamic> ligneSession = _getLigneSession(fitFile);
    if (ligneSession.isEmpty) {
      return Tuple4(false, List.empty(), ActivityInfo(), "");
    }
    categorie =
        _getCategoryById(int.parse(_getXfromListe(_sport, ligneSession)));

    // -- Si la catégorie est pas prévu == généric -- //
    switch (categorie) {
      case (_marche):
        fieldAllowed = allowedFieldWalking;
        break;
      case (_generic):
        fieldAllowed = allowedFieldGeneric;
        break;
      default:
        // A REMETRE EN GENERIC
        //fieldAllowed = allowedFieldGeneric;
        //info = ActivityInfoGeneric();
        //categorie = _generic;
        fieldAllowed = allowedFieldWalking;
        break;
    }

    // -------- Transformation en CSV ----------- //
    List<List<String>> csvData = transformDataMapIntoCSV(
        getDataOfListeOfRecord(fitFile, fieldAllowed), fieldAllowed);

    // ------ Remplir info avec la ligne session --------- //
    info.startTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(_getXfromListe(_startTime, ligneSession)));
    info.timeOfActivity =
        double.parse(_getXfromListe(_timeActivity, ligneSession));
    info.distance = double.parse(_getXfromListe(_totalDistance, ligneSession));
    info.calories = int.parse(_getXfromListe(_totalCalories, ligneSession));
    info.steps = int.parse(_getXfromListe(_totalStep, ligneSession));
    // ----------------------------------------------------- //
    // -- Extraire les données en fonction de la catégorie -- //
    switch (categorie) {
      case (_marche):
        info.getDataWalking(csvData);
      case (_velo):
        info.getDataCycling(csvData);
      default:
        info.getDataGeneric(csvData);
    }

    //print("Fin :  ManagerFile -> convertBytesFitFileIntoCSVListAndGetInfo ");
    return Tuple4(true, csvData, info, categorie);
  }

  List<dynamic> _getLigneSession(List<Record> listRecord) {
    for (int i = listRecord.length - 1; i != listRecord.length - 5; i--) {
      List<dynamic> tmpListe = listRecord[i].toRow();
      if (tmpListe[0] == "Data" && tmpListe[2] == _session) {
        return tmpListe;
      }
    }
    return List.empty();
  }

  String _getXfromListe(String x, List<dynamic> liste) {
    for (int i = 0; i < liste.length; i++) {
      if (liste[i] == x) {
        return liste[i + 1].toString();
      }
    }
    return "0";
  }

  List<Map<String, Map<String, String>>> getDataOfListeOfRecord(
      List<Record> listeRecord, List<String> allowedField) {
    List<Map<String, Map<String, String>>> dataResult =
        List.empty(growable: true);

    for (Record element in listeRecord) {
      List listeField = element.toRow();
      Map<String, Map<String, String>> ligneDataResult = {};
      // -- Skip ligne whith no data -- //
      bool skip = true;
      int nbData = 0;

      // -- Si ce n'est pas de la data on pass -- //
      if (listeField[0] != "Data") {
        continue;
      }
      for (int i = 0; i < listeField.length;) {
        if (allowedField.contains(listeField[i])) {
          Map<String, String> tmp = {};
          tmp["Value"] = listeField[i + 1].toString();
          tmp["Unite"] = listeField[i + 2].toString();
          ligneDataResult[listeField[i]] = tmp;
          i += 2;
          nbData += 1;
          if (nbData >= 2) {
            skip = false;
          }
        }

        // -- Pour boucler -- //
        i += 1;
      }
      if (!skip) {
        dataResult.add(ligneDataResult);
      }
    }
    return dataResult;
  }

  List<List<String>> transformDataMapIntoCSV(
      List<Map<String, Map<String, String>>> listeMap,
      List<String> fieldAllowed) {
    // ------- Création du csv ----- //
    // --- Création de l'entête -- //
    List<String> enteteCSV = [];
    for (String field in fieldAllowed) {
      enteteCSV.add("Value_$field");
      enteteCSV.add("Unite_$field");
    }

    List<List<String>> csvData = List.empty(growable: true);
    //
    for (Map<String, Map<String, String>> ligne in listeMap) {
      List<String> tmpLigne = List.empty(growable: true);
      for (String field in fieldAllowed) {
        if (!ligne.containsKey(field)) {
          tmpLigne.add("null");
          tmpLigne.add("null");
        } else {
          tmpLigne.add(ligne[field]!["Value"]!);
          tmpLigne.add(ligne[field]!["Unite"]!);
        }
      }
      csvData.add(tmpLigne);
    }
    csvData.insert(0, enteteCSV);
    // ------- FIN --------------- //
    return csvData;
  }
}
