import 'package:smartfit_app_mobile/modele/activity.dart';
import 'package:smartfit_app_mobile/modele/local_db/db_impl.dart';
import 'package:smartfit_app_mobile/modele/user.dart';

class DbDummy implements DbImpl {
  DbDummy._create();
  DbDummy();
  @override
  Future<DbDummy> create() async {
    return DbDummy._create();
  }

  @override
  Future<void> init() {
    throw Exception();
  }

  // ==== USER ====
  @override
  void addUser(String username, String email, String token) {
    throw Exception();
  }

  @override
  User getUser() {
    throw Exception();
  }

  @override
  bool hasUser() {
    throw Exception();
  }

  @override
  void deleteUser() {
    throw Exception();
  }

  @override
  void setUserMail(String email) {
    throw Exception();
  }

  @override
  void setUserName(String username) {
    throw Exception();
  }

  @override
  void setUserToken(String token) {
    throw Exception();
  }

  // ==== ACTIVITY ====
  @override
  void addActivity(String uuid, String filename, String category, String info) {
    throw Exception();
  }

  @override
  void removeActivity(String uuid) {
    throw Exception();
  }

  @override
  void removeAllActivities() {
    throw Exception();
  }

  @override
  String getActivityFilenameByUuid(String uuid) {
    throw Exception();
  }

  @override
  List<ActivityOfUser> getAllActivities() {
    throw Exception();
  }

  // ==== CONFIG ====
  @override
  void initConfig() {
    throw Exception();
  }

  @override
  void setSaveLocally(bool saveLocally) {
    throw Exception();
  }

  @override
  bool getSaveLocally() {
    throw Exception();
  }
}
