import 'dart:convert';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:fit_tool/fit_tool.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smartfit_app_mobile/modele/data_file.dart';

class ManagerFile {
  // -- Field
  final String _fieldTimestamp = "timestamp";
  final String _fieldPositionLatitue = "position_lat";
  final String _fieldPositionLongitude = "position_long";
  final String _fieldDistance = "distance";
  final String _fieldBPM = "heart_rate";
  final String _fieldSpeed = "speed";
  final String _fieldAltitude = "altitude";
  final String _fieldTotalStep = "total_strides";
  final String _fieldTotalCalorie = "total_calories";
  final String _fieldTemperature = "temperature";

  // -- Not in CSV -- //
  final String _session = "session";
  final String _startTime = "start_time";
  final String _sport = "sport";

  // -- Getter field
  String get fieldTimeStamp => _fieldTimestamp;
  String get fieldPositionLatitude => _fieldPositionLatitue;
  String get fieldPositionLongitude => _fieldPositionLongitude;
  String get fieldDistance => _fieldDistance;
  String get fielBPM => _fieldBPM;
  String get fieldSpeed => _fieldSpeed;
  String get fieldAltitude => _fieldAltitude;
  String get fieldTotalStep => _fieldTotalStep;
  String get fieldTotalCalories => _fieldTotalCalorie;
  String get fieldTemperature => _fieldTemperature;

  List<String> allowedFieldWalking = List.empty(growable: true);

  ManagerFile() {
    allowedFieldWalking = [
      _fieldTimestamp,
      _fieldPositionLatitue,
      _fieldPositionLongitude,
      _fieldDistance,
      _fieldBPM,
      _fieldSpeed,
      _fieldAltitude,
      _fieldTotalStep,
      _fieldTotalCalorie,
      _fieldTemperature
    ];
  }

  DataFile convertBytesFitFileIntoCSVList(Uint8List bytes) {
    FitFile fitFile = FitFile.fromBytes(bytes);

    // ----------- Lire le fit et extarire les données qu'on choisi ----------- //
    List<Map<String, Map<String, String>>> dataResult =
        List.empty(growable: true);
    // -- Start Time default -- //
    String startTime = "2000-01-01";
    // -- Category Default -- //
    String category = "Generic";
    // -- Denivelé positif et négatif -- //
    double denivelePositif = 0.0;
    double deniveleNegatif = 0.0;
    double lastDenivele = 0.0;

    // --------------------------------------- //

    for (Record element in fitFile.records) {
      List listeField = element.toRow();
      Map<String, Map<String, String>> ligneDataResult = {};
      // -- Skip ligne whith no data -- //
      bool skip = true;
      // -- Session -- //
      bool sesssionLigne = false;

      if (listeField[0] != "Data") {
        continue;
      }

      for (int i = 0; i < listeField.length;) {
        // -- Check si c'est une ligne session --//
        if (i == 0 && listeField[2] == _session) {
          sesssionLigne = true;
        }
        // -- Si ligne session && starttime -- //
        if (sesssionLigne && listeField[i] == _startTime) {
          startTime =
              DateTime.fromMillisecondsSinceEpoch(listeField[i + 1] as int)
                  .toIso8601String();
        }
        // -- Si ligne session && sport -- //
        if (sesssionLigne && listeField[i] == _sport) {
          category = _getCategoryById(listeField[i + 1] as int);
        }

        // Calcul denivelé positif et négatif
        if (listeField[i] == _fieldAltitude) {
          if (listeField[i + 1] > lastDenivele) {
            denivelePositif += listeField[i + 1] - lastDenivele;
          } else {
            deniveleNegatif += (listeField[i + 1] - lastDenivele) * -1;
          }
          lastDenivele = listeField[i + 1];
        }
        //------//

        if (allowedFieldWalking.contains(listeField[i])) {
          Map<String, String> tmp = {};
          tmp["Value"] = listeField[i + 1].toString();
          tmp["Unite"] = listeField[i + 2].toString();
          ligneDataResult[listeField[i]] = tmp;
          i += 2;
          skip = false;
        }
        i += 1;
      }
      if (!skip) {
        dataResult.add(ligneDataResult);
      }
    }
    // -------- FIN ---------- //

    // ------- Création du csv ----- //
    // --- Création de l'entête -- //
    List<String> enteteCSV = [];
    for (String field in allowedFieldWalking) {
      enteteCSV.add("Value_$field");
      enteteCSV.add("Unite_$field");
    }

    List<List<String>> csvData = List.empty(growable: true);
    //
    for (Map<String, Map<String, String>> ligne in dataResult) {
      List<String> tmpLigne = List.empty(growable: true);
      for (String field in allowedFieldWalking) {
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
    return DataFile(
        csvData, category, startTime, denivelePositif, deniveleNegatif);
  }

  // -- Read the byte of file CSV -- //
  List<List<dynamic>> convertByteIntoCSV(Uint8List bytes) {
    return const CsvToListConverter().convert(utf8.decode(bytes));
  }

  String _getCategoryById(int id) {
    switch (id) {
      case 0:
        return "generic";
      case 2:
        return "cycling";
      case 11:
        return "walking";
      default:
        return "generic";
    }
  }

  // ------------- Get The path of application --- //
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  /*
  // ----- Read csv File ------- //
  Future<List<dynamic>> readCSVFile(String path) async {
    if (File(path).exists() == false) return List.empty();
    final input = File(path).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    return fields;
  }
  
  // ----- Read a file FIT  --- //
  Future<List<dynamic>> readFitFile(String path) async {
    if (File(path).existsSync() == false) return List.empty();

    final file = File(path);
    final bytes = await file.readAsBytes();
    final fitFile = FitFile.fromBytes(bytes);

    return fitFile.toRows();
  }

  Future<List<dynamic>> readFitFileWhithFile(File file) async {
    final bytes = await file.readAsBytes();
    final fitFile = FitFile.fromBytes(bytes);
    return fitFile.toRows();
  }

  List<dynamic> readFitFileWeb(Uint8List bytes) {
    final fitFile = FitFile.fromBytes(bytes);
    return fitFile.toRows();
  }*/

  /*
  // --- A modifier si utilisé --- //
  Future<bool> saveFileLocal(String nameFileWithExtension, String path) async {
    /*
    final outFile = File("${await localPath}\\Files\\$nameFileWithExtension");
    if (outFile.existsSync() == false) {
      outFile.createSync(recursive: true);
    }
    await outFile.writeAsString(await file.readAsString());
    return true;*/
  }*/
  /*
  // -- Check si le fichier existe localement -- //
  Future<bool> fileExist(String filname) async {
    Directory directory = Directory("${await localPath}\\Files\\");
    if (!directory.existsSync()) {
      print("Le dossier n'existe pas !");
      return false;
    }
    List<FileSystemEntity> files = directory.listSync();
    for (FileSystemEntity file in files) {
      if (file.path.split("\\").last == filname) {
        return true;
      }
    }
    return false;
  }*/

  // --- Ligne utile --- //
  //final csv = const ListToCsvConverter().convert(fitFile.toRows());
  //await outFile.writeAsString(csv);*/
}
