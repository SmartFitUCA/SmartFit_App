import 'dart:convert';
import 'dart:io';

import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/modele/activity.dart';
import 'package:smartfit_app_mobile/modele/activity_info/activity_info.dart';
import 'package:smartfit_app_mobile/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:smartfit_app_mobile/modele/local_db/model.dart' as db;
import 'package:smartfit_app_mobile/modele/local_db/db_impl.dart';

class ObjectBox implements DbImpl {
  late final Store store;
  late final Box userBox;
  late final Box activityBox;
  late final Box configBox;
  late final Directory applicationDocumentDir;

  ObjectBox._create(this.store);

  ObjectBox();

  @override
  Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "database"));
    return ObjectBox._create(store);
  }

  @override
  Future<void> init() async {
    applicationDocumentDir = await getApplicationDocumentsDirectory();
    userBox = store.box<db.User>();
    activityBox = store.box<db.Activity>();
    configBox = store.box<db.Config>();
  }

  // ===== USER =====
  @override
  bool hasUser() {
    return !userBox.isEmpty();
  }

  @override
  User getUser() {
    db.User userRes = userBox.get(1);

    return User.create(userRes.username, userRes.email, userRes.token);
  }

  @override
  void setUserMail(String email) {
    db.User user = userBox.get(1);
    user.email = email;
    userBox.put(user);
  }

  @override
  void setUserName(String username) {
    db.User user = userBox.get(1);
    user.username = username;
    userBox.put(user);
  }

  @override
  void setUserToken(String token) {
    db.User user = userBox.get(1);
    user.token = token;
    userBox.put(user);
  }

  @override
  void deleteUser() {
    userBox.removeAll();
  }

  @override
  void addUser(String username, String email, String token) {
    userBox.put(db.User(0, username, email, token));
  }

  // ===== Activity =====
  @override
  void addActivity(String uuid, String filename, String category, String info) {
    db.Activity act =
        db.Activity(0, uuid, filename, category, jsonEncode(info));

    try {
      activityBox.put(act);
    } on ObjectBoxException {
      print("Activity already exists");
    } catch (e) {
      print("Unknown exception");
    }
  }

  // TODO: try catch
  @override
  void removeActivity(String uuid) {
    final Query query = activityBox.query(Activity_.uuid.equals(uuid)).build();
    final db.Activity act = query.findFirst();

    activityBox.remove(act.id);
  }

  @override
  String getActivityFilenameByUuid(String uuid) {
    final Query query = activityBox.query(Activity_.uuid.equals(uuid)).build();
    final db.Activity act = query.findFirst();

    return act.filename;
  }

  @override
  void removeAllActivities() {
    activityBox.removeAll();
  }

  // ===== FIT Files =====
  @override
  List<ActivityOfUser> getAllActivities() {
    List<dynamic> activityDBList = activityBox.getAll();
    List<ActivityOfUser> userActivityList = List.empty(growable: true);

    for (db.Activity act in activityDBList) {
      ActivityInfo actInfo = ActivityInfo.fromJson(jsonDecode(act.info));
      userActivityList
          .add(ActivityOfUser(actInfo, act.category, act.uuid, act.filename));
    }

    return userActivityList;
  }

  // ===== Config =====
  @override
  void initConfig() {
    db.Config config = db.Config(0, true);
    configBox.put(config);
  }

  @override
  void setSaveLocally(bool saveLocally) {
    db.Config config = configBox.get(1);
    config.saveLocally = saveLocally;
    configBox.put(config);
    stdout.write("(Config) setSaveLocally: $saveLocally\n");
  }

  @override
  bool getSaveLocally() {
    db.Config config = configBox.get(1);
    stdout.write("(Config) getSaveLocally: ${config.saveLocally}\n");
    return config.saveLocally;
  }
}
