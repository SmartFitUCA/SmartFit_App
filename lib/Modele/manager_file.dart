import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:fit_tool/fit_tool.dart';
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

  List<List<int>> getHeartRateWithTime(ActivityOfUser activity) {
    List<List<int>> result = List.empty(growable: true);
    int firtTimeStamp = 0;

    for (List<dynamic> ligne in activity.contentActivity) {
      if (ligne.length >= 10 &&
          ligne[0] == "Data" &&
          ligne[9] == "heart_rate") {
        if (firtTimeStamp == 0) {
          firtTimeStamp = ligne[4];
        }
        result.add([(ligne[4] - firtTimeStamp) ~/ 100, ligne[10]]);
      }
    }
    return result;
  }
}
