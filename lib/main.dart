import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_sqflite_todo/page/userCommentsPage.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Notes SQLite';

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primaryColor: Colors.orange,
          // scaffoldBackgroundColor: Colors.blueGrey.shade900,
        ),
        home: UserCommentsPage(),
      );
}
