import 'package:eraqi_project_graduation/views/theme.dart';

import 'package:flutter/material.dart';


class MyScaffold extends StatelessWidget {
  const MyScaffold(
      {super.key, required this.title, required this.body, this.actoins});
  final String title;
  final Widget body;
  final List<Widget>? actoins ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgClr,
      appBar: AppBar(
        actions:actoins ?? [],
        backgroundColor: prmClr,
        title: Text(
          title,
          style: headingStyle,
        ),
      ),
      body: body,
    );
  }
}
