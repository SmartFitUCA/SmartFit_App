class Activity {
  final String _type = "Default";

  late List<dynamic> _contentActivity;

  List<dynamic> get contentActivity => _contentActivity;

  Activity(List<Activity> contentActivity) {
    _contentActivity = contentActivity;
  }
}
