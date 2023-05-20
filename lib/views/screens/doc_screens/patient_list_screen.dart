import 'package:eraqi_project_graduation/views/screens/chat_screen.dart';
import 'package:eraqi_project_graduation/views/screens/doc_screens/add_prescription.dart';
import 'package:eraqi_project_graduation/views/screens/doc_screens/blood_glu_screen.dart';
import 'package:eraqi_project_graduation/views/screens/doc_screens/blood_press_screen.dart';
import 'package:eraqi_project_graduation/views/screens/doc_screens/find_patient_screen.dart';
import 'package:eraqi_project_graduation/views/screens/doc_screens/patinet_history_view.dart';
import 'package:eraqi_project_graduation/views/screens/doc_screens/vaccines_screens.dart';
import 'package:eraqi_project_graduation/views/screens/login.dart';
import 'package:eraqi_project_graduation/views/size_config.dart';
import 'package:eraqi_project_graduation/views/theme.dart';
import 'package:eraqi_project_graduation/views/widgets/my_drawer.dart';
import 'package:flutter/material.dart';


class PatientListScreen extends StatelessWidget {
  const PatientListScreen(
      {super.key,
      required this.uid,
      required this.place,
      required this.name,
      required this.docEmail});
  final String uid;
  final String place;
  final String name;
  final String docEmail;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      drawer:  MyDrawer(
        routes: {
          'Find Patient': //todo
              FindPatientScreen(uid: docEmail,),
         'Log Out':LoginScreen()
        },
        icons: const [Icons.find_in_page,Icons.logout],
      ),
      backgroundColor: bgClr,
      appBar: AppBar(
        backgroundColor: prmClr,
        title: Text(
          ' Patient',
          style: headingStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //    ElevatedButton(
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => AddPrescriptionScreen(
                //                   uid: uid,
                //                   place: place,
                //                   docName: name,
                //                   docEmail: docEmail,
                //                 )));
                //   },
                //   child: Text('data'),
                //   style: ButtonStyle(
                //       backgroundColor: MaterialStateProperty.all(Colors.red)),
                // ),
                patientListButton('History', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientHistoryView(uid: uid),
                      ));
                }),
                patientListButton('Blodd Pressure', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientBloodPressView(uid: uid),
                    ),
                  );
                }),
                patientListButton('Blodd Glucose', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientBloodGluView(uid: uid),
                    ),
                  );
                }),
                patientListButton('Vaccines', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientVaccineView(uid: uid),
                    ),
                  );
                }),
                patientListButton('Chat', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        patientUid: uid,
                        docUid: docEmail,
                        isPatient: false,
                      ),
                    ),
                  );
                }),
                patientListButton('Add Prescription', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPrescriptionScreen(
                        uid: uid,
                        place: place,
                        docName: name,
                        docEmail: docEmail,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container patientListButton(String text, Function() onTap) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onTap,
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
      ),
    );
  }
}
