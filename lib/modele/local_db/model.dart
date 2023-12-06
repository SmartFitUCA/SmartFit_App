import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id()
  int id = 0;
  String username;
  String email;
  String token;

  User(this.id, this.username, this.email, this.token);
}

@Entity()
class Activity {
  int id;

  @Unique()
  String uuid;
  String filename;
  String category;
  String info;

  Activity(this.id, this.uuid, this.filename, this.category, this.info);
}
