import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraqi_project_graduation/views/screens/doc_screens/check_qr.screen.dart';
import 'package:eraqi_project_graduation/views/screens/doc_screens/doc_profile_screen.dart';
import 'package:eraqi_project_graduation/views/screens/doc_screens/patient_list_screen.dart';
import 'package:eraqi_project_graduation/views/screens/login.dart';
import 'package:eraqi_project_graduation/views/size_config.dart';
import 'package:eraqi_project_graduation/views/theme.dart';
import 'package:eraqi_project_graduation/views/widgets/button_shape.dart';
import 'package:eraqi_project_graduation/views/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../widgets/my_drawer.dart';

class FindPatientScreen extends StatefulWidget {
  const FindPatientScreen({super.key, required this.uid});
  final String uid;
  @override
  State<FindPatientScreen> createState() => _FindPatientScreenState();
}

class _FindPatientScreenState extends State<FindPatientScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String name = '';
  String id = '';
  String address = '';
  String gender = '';
  String birthDate = '';
  String email = '';
  String phoneNumber = '';
  String type = '';
  Map<String, String> patient = {};
  bool isLoading = false;
  bool isLoading2 = false;
  String serachedPatient = '';
  void getDocData() async {
    setState(() {
  isLoading2=true;
});
    await firestore
        .collection('Doctors')
        .doc(widget.uid)
        .get()
        .then((DocumentSnapshot q) {
      name = q['fullname'];
      id = q['Id'];
      address = q['address'];
      gender = q['gender'];
      email = q['email'];
      birthDate = q['birthDate'];
      phoneNumber = q['phoneNumber'];
      type = q['type'];
    });
        setState(() {
  isLoading2=false;
});
  }

  getPatientData() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('Patients')
        .where('Id', isEqualTo: patientId.text)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        patient[element['Id']] = element['uid'];
        serachedPatient = element['uid'];
      });
    });

    setState(() {
      isLoading = false;
    });
  }

  findPatient() async {
    await getPatientData();
    if (patient.containsKey(patientId.text)) {
      //   serachedPatient = patient[id]!;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PatientListScreen(
              uid: patient[patientId.text]!,
              name: name,
              docEmail: widget.uid,
              place: address,
            ),
          ));
    } else {
      Fluttertoast.showToast(
          msg: 'Patint not found',
          backgroundColor: Colors.black,
          toastLength: Toast.LENGTH_LONG);
    }
  }

  @override
  void initState() {
    super.initState();
    getDocData();
  }

  TextEditingController patientId = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return 
    isLoading2?const Center(child: CircularProgressIndicator(color: prmClr,)):
    Scaffold(
      drawer: MyDrawer(
        routes: {
          'Find Patient': FindPatientScreen(uid: widget.uid),
          'Profile': DocProfileScreen(
              name: name,
              email: email,
              phoneNumber: phoneNumber,
              nationalId: id,
              address: address,
              birthDate: birthDate,
              gender: gender),
          'Log Out': LoginScreen()
        },
        icons: const [Icons.find_in_page, Icons.person, Icons.logout],
      ),
      backgroundColor: bgClr,
      appBar: AppBar(
        backgroundColor: prmClr,
        title: Text(
          'Find Patient',
          style: headingStyle,
        ),
      ),
      body: !isLoading
          ? Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: InputField(
                              title: 'Find Patient',
                              hint: '',
                              controller: patientId)),
                      InkWell(
                        onTap: () {
                          if (patientId.text.length != 14) {
                            Fluttertoast.showToast(
                                msg: 'Id length should be 14',
                                backgroundColor: Colors.black,
                                toastLength: Toast.LENGTH_LONG);
                          } else {
                            findPatient();
                          }

                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => PatientListScreen(
                          //         uid: serachedPatient,
                          //         name: name,
                          //         docEmail: widget.uid,
                          //         place: address,
                          //       ),
                          //     ));
                        },
                        child: ButtonShape(
                          buttonText: 'Find',
                          height: SizeConfig.screenHeight * 0.07,
                          width: SizeConfig.screenWidth * 0.1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CHeckQrScreen(
                                  name: name,
                                  docEmail: widget.uid,
                                  place: address,
                                ),
                              ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding:
                              EdgeInsets.all(SizeConfig.screenHeight * 0.01),
                          height: SizeConfig.screenHeight * 0.07,
                          width: SizeConfig.screenWidth * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: prmClr,
                          ),
                          child: Image.asset('assets/Qr.png'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
