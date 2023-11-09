class ActivityOfUser {
  final String _type = "Default";

  late List<dynamic> _contentActivity;

  List<dynamic> get contentActivity => _contentActivity;

  ActivityOfUser(List<dynamic> listeDynamic) {
    _contentActivity = listeDynamic;
  }
}
