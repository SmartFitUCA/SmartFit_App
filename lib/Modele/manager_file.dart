import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:fit_tool/fit_tool.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smartfit_app_mobile/Modele/Api/i_data_strategy.dart';
import 'package:smartfit_app_mobile/Modele/Api/request_api.dart';
import 'package:smartfit_app_mobile/Modele/activity.dart';

class ManagerFile {
  final IDataStrategy _dataStrategy = RequestApi();
  //List<dynamic>? _contentFile;

  //List<dynamic>? get contentFile => _contentFile;
  // ----- //

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

  // ------ Import File and save it in BDD
  Future<bool> importFileAndSaveInBDD(String path, String tokenUser) async {
    if (File(path).existsSync() == false) return false;
    _dataStrategy.uploadFile(tokenUser, File(path));
    return true;
  }

  // ----- Read a file FIT  --- //
  Future<List<dynamic>> readFitFile(String path) async {
    if (File(path).existsSync() == false) return List.empty();

    final file = File(path);
    final bytes = await file.readAsBytes();
    final fitFile = FitFile.fromBytes(bytes);

    return fitFile.toRows();
  }

  // ------------- Get The path of application --- //
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // --- A modifier si utilisé --- //
  Future<bool> writeFile(String nameFileWithExtension, File file) async {
    final outFile = File("${await _localPath}\\Files\\$nameFileWithExtension");
    if (outFile.existsSync() == false) {
      outFile.createSync(recursive: true);
    }
    await outFile.writeAsString(await file.readAsString());
    return true;
  }

  // --- Ligne utile --- //
  //final csv = const ListToCsvConverter().convert(fitFile.toRows());
  //await outFile.writeAsString(csv);*/

  // ---------------- Fonction to get data --------- //

  List<FlSpot> getHeartRateWithTime(ActivityOfUser activity) {
    List<FlSpot> result = List.empty(growable: true);
    int firtTimeStamp = 0;

    for (List<dynamic> ligne in activity.contentActivity) {
      if (ligne[0] == "Data") {
        if (ligne.length >= 10 && ligne[9] == "heart_rate") {
          if (firtTimeStamp == 0) {
            firtTimeStamp = ligne[4];
          }
          //result.add([(ligne[4] - firtTimeStamp) ~/ 100, ligne[10]]);
          result.add(
              FlSpot((ligne[4] - firtTimeStamp) / 100, ligne[10].toDouble()));
        } else if (ligne.length >= 16 && ligne[15] == "heart_rate") {
          if (firtTimeStamp == 0) {
            firtTimeStamp = ligne[4];
          }
          //result.add([(ligne[4] - firtTimeStamp) ~/ 100, ligne[17]]);
          result.add(
              FlSpot((ligne[4] - firtTimeStamp) / 100, ligne[16].toDouble()));
        }
      }
    }
    return result;
  }

  List<FlSpot> getDistanceWithTime(ActivityOfUser activityOfUser) {
    List<FlSpot> result = List.empty(growable: true);
    int firtTimeStamp = 0;

    for (List<dynamic> ligne in activityOfUser.contentActivity) {
      if (ligne.length >= 8 && ligne[0] == "Data" && ligne[6] == "distance") {
        if (firtTimeStamp == 0) {
          firtTimeStamp = ligne[4];
        }
        //result.add([(ligne[4] - firtTimeStamp) ~/ 100, ligne[7].toInt()]);
        result.add(FlSpot((ligne[4] - firtTimeStamp) ~/ 100, ligne[7]));
      }
    }
    return result;
  }

  List<FlSpot> getAltitudeWithTime(ActivityOfUser activityOfUser) {
    List<FlSpot> result = List.empty(growable: true);
    int firtTimeStamp = 0;

    for (List<dynamic> ligne in activityOfUser.contentActivity) {
      if (ligne.length >= 14 && ligne[0] == "Data" && ligne[12] == "altitude") {
        if (firtTimeStamp == 0) {
          firtTimeStamp = ligne[4];
        }
        //result.add([(ligne[4] - firtTimeStamp) ~/ 100, ligne[13].toInt()]);
        result.add(FlSpot((ligne[4] - firtTimeStamp) ~/ 100, ligne[13]));
      }
    }
    return result;
  }

  int getDistance(ActivityOfUser activity) {
    int result = 0;
    for (int i = activity.contentActivity.length - 1; i >= 0; i--) {
      if (activity.contentActivity[i].length >= 8 &&
          activity.contentActivity[i][0] == "Data" &&
          activity.contentActivity[i][6] == "distance") {
        if (activity.contentActivity[i][7] > result) {
          result = activity.contentActivity[i][7].toInt();
        }
      }
    }
    return result;
  }

  /* En Cours 
  List<FlSpot> getSpeedWithTime(ActivityOfUser activityOfUser) {
    List<FlSpot> result = List.empty(growable: true);
    int firtTimeStamp = 0;

    for (List<dynamic> ligne in activityOfUser.contentActivity) {
      if (ligne[0] == "Data" && ligne[1] == 1) {
        if (firtTimeStamp == 0) {
          firtTimeStamp = ligne[4];
        }
        result
            .add(FlSpot((ligne[4] - firtTimeStamp) ~/ 100, ligne[19].toInt()));
        //result.add([(ligne[4] - firtTimeStamp) ~/ 100, ligne[19].toInt()]);
      }
    }
    return result;
  }*/
}
