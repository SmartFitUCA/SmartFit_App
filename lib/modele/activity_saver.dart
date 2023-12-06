import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'package:smartfit_app_mobile/modele/helper.dart';

class ActivitySaver {
  String saveDirectory = "activities";
  late final Directory applicationDocumentsDir;

  ActivitySaver._create(this.applicationDocumentsDir);

  static Future<ActivitySaver> create() async {
    final appDir = await getApplicationDocumentsDirectory();
    return ActivitySaver._create(appDir);
  }

  Future<void> saveActivity(Uint8List activityFile, String filename) async {
    final file = await File(
            p.join(applicationDocumentsDir.path, saveDirectory, filename))
        .create(recursive: true); // To create dir if not exists
    file.writeAsBytesSync(activityFile);
  }

  File getActivity(String filename) {
    final file =
        File(p.join(applicationDocumentsDir.path, saveDirectory, filename));
    return file;
  }
}
