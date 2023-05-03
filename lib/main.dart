import 'package:eraqi_project_graduation/views/screens/doc_screens/add_prescription.dart';
import 'package:eraqi_project_graduation/views/screens/doc_screens/doc_profile_screen.dart';
import 'package:eraqi_project_graduation/views/screens/doc_screens/find_patient_screen.dart';
import 'package:eraqi_project_graduation/views/screens/registeration.dart';
import 'package:eraqi_project_graduation/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
