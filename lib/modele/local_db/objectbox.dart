import 'package:smartfit_app_mobile/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:smartfit_app_mobile/modele/local_db/model.dart';

class ObjectBox {
  late final Store store;
  late final Box userBox;
  late final Box activityBox;

  ObjectBox._create(this.store);

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store =
        await openStore(directory: p.join(docsDir.path, "obx-example"));
    return ObjectBox._create(store);
  }

  init() {
    userBox = store.box<User>();
    activityBox = store.box<Activity>();
  }

  bool hasUser() {
    return !userBox.isEmpty();
  }
}
