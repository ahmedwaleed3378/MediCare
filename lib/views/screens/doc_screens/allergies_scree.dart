import 'package:eraqi_project_graduation/views/theme.dart';
import 'package:eraqi_project_graduation/views/widgets/data_shaowinf_widget.dart';
import 'package:flutter/material.dart';


class PatientAllergy extends StatelessWidget {
  const PatientAllergy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Allergy',
          style: headingStyle,
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:const [
          DataShowing(title: 'Allergy', info: ['10','20','30'],),
          DataShowing(title: 'Allergy', info: ['10','20','30'],),
        ],
      ),
    );
  }
}
