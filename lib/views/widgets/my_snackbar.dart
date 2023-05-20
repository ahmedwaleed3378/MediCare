import 'package:eraqi_project_graduation/views/theme.dart';
import 'package:flutter/material.dart';






myShowSnackBar(BuildContext context, String title,{bool isRed=false}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 10,
    padding: const EdgeInsets.all(10),
    backgroundColor:isRed? Colors.red :  prmClr,
    duration: const Duration(seconds: 3),
      content: Text(title,style:const  TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)));
}
