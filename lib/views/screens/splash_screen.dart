import 'dart:async';

import 'package:eraqi_project_graduation/views/screens/login.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  void _startDelay() {
    _timer = Timer(const Duration(seconds: 2), goNext);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgClr,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo.png',
            fit: BoxFit.fitHeight,
          ),
          const SizedBox(height: 25,),
          Text(
            'MediCare',
            style: headingStyle.copyWith(color: darkGreyClr),
          )
        ],
      )),
    );
  }

  void goNext() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}


