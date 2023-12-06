import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:smartfit_app_mobile/modele/activity.dart';
import 'package:smartfit_app_mobile/modele/activity_info/activity_info.dart';
import 'package:smartfit_app_mobile/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:smartfit_app_mobile/modele/local_db/model.dart';

class ObjectBox {
  late final Store store;
  late final Box userBox;
  late final Box activityBox;
  late final String activitiesSavePath = "activities";
  late final Directory applicationDocumentDir;

  ObjectBox._create(this.store);

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "database"));
    return ObjectBox._create(store);
  }

  init() async {
    applicationDocumentDir = await getApplicationDocumentsDirectory();
    userBox = store.box<User>();
    activityBox = store.box<Activity>();
  }

  // ===== USER =====
  bool hasUser() {
    return !userBox.isEmpty();
  }

  void setUserMail(String email) {
    User user = userBox.get(1);
    user.email = email;
    userBox.put(user);
  }

  void setUserName(String username) {
    User user = userBox.get(1);
    user.username = username;
    userBox.put(user);
  }

  void setUserToken(String token) {
    User user = userBox.get(1);
    user.token = token;
    userBox.put(user);
  }

  void deleteUser() {
    userBox.removeAll();
  }

  void addUser(String username, String email, String token) {
    userBox.put(User(1, username, email, token));
  }

  // ===== Activity =====
  void addActivity(Activity newActivity) {
    try {
      activityBox.put(newActivity);
    } on ObjectBoxException {
      print("Activity already exists");
    } catch (e) {
      print("Unknown exception");
    }
  }

  void removeActivity(int uuid) {
    activityBox.remove(uuid);
  }

  List<Activity> getAllActivities() {
    // TODO: Transform db.Activity to ActivityOfUser
    throw Exception("Not implemented yet");
  }

  void removeAllActivities() {
    activityBox.removeAll();
  }

  // ===== FIT Files =====
  Future<void> saveActivityFile(List<List<dynamic>> activityFile) async {
    String csv = const ListToCsvConverter().convert(activityFile);
    Uint8List csvAsBytes = Uint8List.fromList(utf8.encode(csv));
    final file =
        await File(p.join(applicationDocumentDir.path, activitiesSavePath))
            .create();
    file.writeAsBytesSync(csvAsBytes);
  }

  File getActivityFile(String filename) {
    final file =
        File(p.join(applicationDocumentDir.path, activitiesSavePath, filename));
    return file;
  }

  List<ActivityOfUser> loadActivities() {
    List<dynamic> activityDBList = activityBox.getAll();
    List<ActivityOfUser> userActivityList = List.empty(growable: true);

    for (Activity act in activityDBList) {
      ActivityInfo actInfo = ActivityInfo.fromJson(jsonDecode(act.info));
      userActivityList
          .add(ActivityOfUser(actInfo, act.category, act.uuid, act.filename));
    }

    return userActivityList;
  }
}
