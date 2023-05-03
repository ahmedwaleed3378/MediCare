import 'package:flutter/material.dart';

import '../theme.dart';

class ButtonShape extends StatelessWidget {
  const ButtonShape(
      {super.key,
      required this.buttonText,
      required this.width,
      required this.height});
  final String buttonText;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
     // padding: const EdgeInsets.only(top:7),
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: prmClr,
          
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(18)),
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: const TextStyle(color:white,fontWeight: FontWeight.bold,fontSize: 15),
      ),
    );
  }
}
