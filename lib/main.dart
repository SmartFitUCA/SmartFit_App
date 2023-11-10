import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/Modele/user.dart';
import 'package:smartfit_app_mobile/View/login/login_view.dart';
import 'package:smartfit_app_mobile/View/on_boarding/started_view.dart';
import 'package:smartfit_app_mobile/View/page_test.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => User(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartFit 3 in 1',
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
      //home: const StartedView(),
      home: const TestPage(),
    );
  }
}
