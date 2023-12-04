class ActivityOfUser {
  // A afficher
  final String _categorie;
  final String _date;
  final String _fileUuid;
  final String _nameFile;
  final double _timeActivity;
  final double _denivelePositif;
  final double _deniveleNegatif;
  // ------------ //
  late String _imageName;

  List<List<dynamic>> _contentActivity = List.empty(growable: true);
  Map<String, int> _enteteCSV = {};

  String get fileUuid => _fileUuid;
  String get nameFile => _nameFile;
  String get category => _categorie;
  Map<String, int> get enteteCSV => _enteteCSV;

  // -- Getter/Setter -- Ancien //
  List<List<dynamic>> get contentActivity => _contentActivity;
  set contentActivity(List<List<dynamic>> content) {
    _contentActivity = content;
    for (int i = 0; i < content.first.length; i++) {
      _enteteCSV.addAll({content.first[i]: i});
    }
    _contentActivity.removeAt(0);
  }

  ActivityOfUser(this._categorie, this._date, this._fileUuid, this._nameFile,
      this._timeActivity, this._denivelePositif, this._deniveleNegatif) {
    // Mettre dans une fonction appart
    if (_categorie == "Walking") {
      _imageName = "assets/img/workout1.svg";
    } else {
      // Mettre des conditions pour d'autre type d'activité
      _imageName = "assets/img/workout1.svg";
    }
  }

  // -------------------------- FIN Localisation  ---------------------- //

  Map<String, dynamic> toMap() {
    return {
      'categorie': _categorie,
      'image': _imageName,
      'date': _date,
      'time': _timeActivity,
      "denivelePositif": _denivelePositif,
      "deniveleNegatif": _deniveleNegatif,
    };
  }
}
