import 'package:smartfit_app_mobile/modele/activity_info/activity_info.dart';

class ActivityOfUser {
  final ActivityInfo _activityInfo;
  // A afficher
  final String _category;
  final String _fileUuid;
  final String _nameFile;
  // ------------ //
  late String _imageName;

  List<List<dynamic>> _contentActivity = List.empty(growable: true);
  Map<String, int> _enteteCSV = {};

  String get fileUuid => _fileUuid;
  String get nameFile => _nameFile;
  String get category => _category;
  ActivityInfo get activityInfo => _activityInfo;
  Map<String, int> get enteteCSV => _enteteCSV;

  // -- Getter/Setter -- //
  List<List<dynamic>> get contentActivity => _contentActivity;
  set contentActivity(List<List<dynamic>> content) {
    _contentActivity = content;
    for (int i = 0; i < content.first.length; i++) {
      _enteteCSV.addAll({content.first[i]: i});
    }
    _contentActivity.removeAt(0);
  }

  ActivityOfUser(
      this._activityInfo, this._category, this._fileUuid, this._nameFile) {
    // Mettre dans une fonction appart
    if (_category == "Walking") {
      _imageName = "assets/img/workout1.svg";
    } else {
      // Mettre des conditions pour d'autre type d'activité
      _imageName = "assets/img/workout1.svg";
    }
  }

  // -------------------------- ToMap  ---------------------- //

  Map<String, dynamic> toMapGeneric() {
    Map<String, dynamic> map = {
      'categorie': _category,
      'image': _imageName,
      'date': _activityInfo.startTime,
      'time': _activityInfo.timeOfActivity,
    };
    return map;
  }

  Map<String, dynamic> toMapWalking() {
    Map<String, dynamic> map = toMapGeneric();
    map.addAll(activityInfo.toMapWalking());
    return map;
  }
}
