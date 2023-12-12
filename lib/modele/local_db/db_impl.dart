import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/modele/activity.dart';

abstract class DbImpl {
  DbImpl._create();

  Future<DbImpl> create();

  Future<void> init();

  // ==== USER ====
  void addUser(String username, String email, String token);
  User getUser();
  bool hasUser();
  void deleteUser();
  void setUserMail(String email);
  void setUserName(String username);
  void setUserToken(String token);

  // ==== ACTIVITY ====
  void addActivity(String uuid, String filename, String category, String info);
  void removeActivity(String uuid);
  void removeAllActivities();
  String getActivityFilenameByUuid(String uuid);
  List<ActivityOfUser> getAllActivities();

  // ==== CONFIG ====
  void initConfig();
  void setSaveLocally(bool saveLocally);
  bool getSaveLocally();
}
