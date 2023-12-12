import 'package:smartfit_app_mobile/modele/local_db/db_impl.dart';
import 'package:smartfit_app_mobile/modele/local_db/objectbox.dart';

DbImpl getDbImpl() {
  DbImpl db = ObjectBox();
  return db;
}
