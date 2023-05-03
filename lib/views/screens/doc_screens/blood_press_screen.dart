import 'package:eraqi_project_graduation/views/theme.dart';
import 'package:eraqi_project_graduation/views/widgets/data_shaowinf_widget.dart';
import 'package:flutter/material.dart';

class BloodPressScreen extends StatelessWidget {
  const BloodPressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgClr,
      appBar: AppBar(
        title: Text(
          'Blood Press.',
          style: headingStyle,
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: const [
          DataShowing(
            title: 'Blood Pressure',
            info: ['10', '20', '30'],
          ),
          DataShowing(
            title: 'Blood Pressure',
            info: ['10', '20', '30'],
          ),
          DataShowing(
            title: 'Blood Pressure',
            info: ['10', '20', '30'],
          ),
          DataShowing(
            title: 'Blood Pressure',
            info: ['10', '20', '30'],
          ),
        ],
      ),
    );
  }
}
