import 'package:eraqi_project_graduation/views/size_config.dart';
import 'package:eraqi_project_graduation/views/theme.dart';
import 'package:eraqi_project_graduation/views/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

import 'doc_profile_screen.dart';
import 'find_patient_screen.dart';

class PatientListScreen extends StatelessWidget {
  const PatientListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      drawer: const MyDrawer(
        routes: {
          'Find Patient': FindPatientScreen(),
          'Profile': DocProfileScreen()
        },
        icons: [Icons.find_in_page, Icons.person],
      ),
      backgroundColor: bgClr,
      appBar: AppBar(
        backgroundColor: prmClr,
        title: Text(
          ' Patient',
          style: headingStyle,
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              patientListButton('History'),
              patientListButton('Blodd Pressure'),
              patientListButton('Blodd Glucose'),
              patientListButton('Vaccines'),
              patientListButton('Add Prescription'),
              patientListButton('Chat'),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton patientListButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        minimumSize: MaterialStateProperty.all(Size(
            SizeConfig.screenWidth * 0.65, SizeConfig.screenHeight * 0.085)),
        backgroundColor:
            MaterialStateProperty.all(darkHeaderClr.withOpacity(0.6)),
      ),
      child: Text(
        text,
        style: headingStyle,
      ),
    );
  }
}
