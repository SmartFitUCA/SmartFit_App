import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import "package:path_provider/path_provider.dart";
import 'package:smartfit_app_mobile/main.dart';

class ActivitySaver {
  String saveDirectory = "activities";
  late final Directory applicationDocumentsDir;

  ActivitySaver._create(this.applicationDocumentsDir);

  Uint8List getActivity(String uuid) {
    String filename = localDB.getActivityFilenameByUuid(uuid);

    final file =
        File(p.join(applicationDocumentsDir.path, saveDirectory, filename));
    return file.readAsBytesSync();
  }

  Future<void> saveActivity(Uint8List activityFile, String filename) async {
    stdout.write("Creating activity file...\n");
    final file = await File(
            p.join(applicationDocumentsDir.path, saveDirectory, filename))
        .create(recursive: true); // To create dir if not exists
    file.writeAsBytesSync(activityFile);
    stdout.write("Activity file created\n");
  }

  void deleteActivity(String uuid) {
    String filename = localDB.getActivityFilenameByUuid(uuid);
    final file =
        File(p.join(applicationDocumentsDir.path, saveDirectory, filename));
    file.deleteSync();
  }

  static Future<ActivitySaver> create() async {
    stdout.write("Activity Saver: Created\n");
    final appDir = await getApplicationDocumentsDirectory();
    return ActivitySaver._create(appDir);
  }
}
