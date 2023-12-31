import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/modele/local_db/db_impl.dart';
import 'package:smartfit_app_mobile/modele/local_db/get_web_db.dart'
    if (dart.library.io) 'package:smartfit_app_mobile/modele/local_db/get_native_db.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/view/login/signup_view.dart';
import 'package:smartfit_app_mobile/view/main_tab/main_tab_view.dart';

late DbImpl localDB;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    DbImpl tmp = getDbImpl();
    localDB = await tmp.create();
    await localDB.init();
    localDB.initConfig();
  }

  runApp(ChangeNotifierProvider(
      create: (context) => User(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget viewToDisplay = const SignUpView();

    // Skip sign-up + fill provider if user already connected
    if (!kIsWeb && localDB.hasUser()) {
      final User user = localDB.getUser();
      final userActivities = localDB.getAllActivities();

      context.watch<User>().username = user.username;
      context.watch<User>().email = user.email;
      context.watch<User>().token = user.token;
      context.watch<User>().listActivity = userActivities;

      stdout.write("===== USER =====\n");
      stdout.write("Username: ${user.username}\n");
      stdout.write("Email: ${user.email}\n");
      stdout.write("Token: ${user.token}\n");

      viewToDisplay = const MainTabView();
    }

    return MaterialApp(
      title: 'SmartFit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          primaryColor: TColor.primaryColor1,
          fontFamily: "Poppins"),
      home: viewToDisplay,
    );
  }
}
