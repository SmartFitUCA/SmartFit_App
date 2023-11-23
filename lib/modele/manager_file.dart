import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:fit_tool/fit_tool.dart';
import 'package:path_provider/path_provider.dart';

class ManagerFile {
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
  }

  // ------------- Get The path of application --- //
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

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
  }

  // --- Ligne utile --- //
  //final csv = const ListToCsvConverter().convert(fitFile.toRows());
  //await outFile.writeAsString(csv);*/
}
