import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int id = 0;
  String username;
  String email;
  String token;

  User(this.id, this.username, this.email, this.token);
}

@Entity()
class Activity {
  int id;
  @Index()
  String uuid;
  String filename;
  String category;
  DateTime date;

  Activity(this.id, this.uuid, this.filename, this.category, this.date);
}
