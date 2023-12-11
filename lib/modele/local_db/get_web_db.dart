import 'package:smartfit_app_mobile/modele/local_db/db_impl.dart';
import 'package:smartfit_app_mobile/modele/local_db/db_dummy.dart';

DbImpl getDbImpl() {
  DbImpl db = DbDummy();
  return db;
}
