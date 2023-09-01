import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_database_getx/views/home/home_screen.dart';
import 'data/database_helper.dart';
import 'utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = DB();
  await db.initialiseDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Student Db',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: ScreenHome(),
    );
  }
}
