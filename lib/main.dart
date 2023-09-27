import "package:flutter/material.dart";
import "package:get/get_navigation/src/root/get_material_app.dart";
import "package:get/get_navigation/src/routes/get_route.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:newstudentapp/controller/student_controller.dart";
import 'package:newstudentapp/database/studentmodel.dart';
import "package:newstudentapp/home.dart";

String hiveboxname = "allstudentsdetails";
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentAdapter().typeId)) {
    Hive.registerAdapter(StudentAdapter());
  }
  await Hive.openBox<Student>(hiveboxname);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(  //navigation library for flutter
      debugShowCheckedModeBanner: false,
      getPages: [  // list of route definitions for the app
        GetPage(name: "/home", page: () => Home(), binding: StudentBinding())
      ],
      initialRoute: "/home",  //initial route of the app
    );
  }
}
