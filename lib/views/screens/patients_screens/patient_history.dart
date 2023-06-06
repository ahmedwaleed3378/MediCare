import 'package:eraqi_project_graduation/models/patient_info.dart';
import 'package:eraqi_project_graduation/views/screens/chat_screen.dart';
import 'package:eraqi_project_graduation/views/screens/patients_screens/allergies_scree.dart';
import 'package:eraqi_project_graduation/views/screens/patients_screens/blood_glu_screen.dart';
import 'package:eraqi_project_graduation/views/screens/patients_screens/blood_press_screen.dart';
import 'package:eraqi_project_graduation/views/screens/patients_screens/patient_profile.dart';
import 'package:eraqi_project_graduation/views/screens/patients_screens/vaccines_screens.dart';
import 'package:eraqi_project_graduation/views/size_config.dart';
import 'package:eraqi_project_graduation/views/theme.dart';
import 'package:eraqi_project_graduation/views/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_jap_icons/medical_icons_icons.dart';

import '../login.dart';

class PatientHistory extends StatefulWidget {
  const PatientHistory({super.key, required this.uid});
  final String uid;

  @override
  State<PatientHistory> createState() => _PatientHistoryState();
}

class _PatientHistoryState extends State<PatientHistory> {
  String name = '';
  String id = '';
  String address = '';
  String gender = '';
  String phoneNumber = '';
  String type = '';
  String docEmail = '';
  String imageURL = '';
  List<MedicalVisit> medicalHistory = [];
  Map<String, String> glocuse = {};
  Map<String, String> press = {};
  Map<String, String> vaccines = {};
  List<Allergies> allergy = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<MedicalVisit>> getMedicalVisits() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Patients/${widget.uid}/medicalvisits')
        .get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    final cartList = docs
        .map((QueryDocumentSnapshot<Object?> doc) =>
            MedicalVisit.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    return cartList;
  }

  Future<List<Allergies>> getAllergies() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Patients/${widget.uid}/allergy')
        .get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    final allers = docs
        .map((QueryDocumentSnapshot<Object?> doc) =>
            Allergies.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    return allers;
  }

  void getVaccines() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Patients/${widget.uid}/vaccine')
        .get();
    querySnapshot.docs.map((doc) {
      vaccines = doc.data() as Map<String, String>;
    });
  }

  void getGlu() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Patients/${widget.uid}/glucose')
        .get();
    querySnapshot.docs.map((doc) {
      glocuse = doc.data() as Map<String, String>;
    });
  }

  void getPress() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Patients/${widget.uid}/press')
        .get();
    querySnapshot.docs.map((doc) {
      press = doc.data() as Map<String, String>;
    });
  }

  // List<QueryDocumentSnapshot> docs = querySnapshot.docs;
  // final cartList = docs
  //     .map((QueryDocumentSnapshot<Object?> doc) =>
  //         MedicalVisit.fromJson(doc.data() as Map<String, dynamic>))
  //     .toList();

  void getPatientData() async {
    await firestore
        .collection('Patients')
        .doc(widget.uid)
        .get()
        .then((DocumentSnapshot q) {
      name = q['fullname'];
      id = q['Id'];
      address = q['address'];
      gender = q['gender'];
      phoneNumber = q['phoneNumber'];
      type = q['type'];
      // docEmail = q['docEmail'];
    });

    // medicalHistory = await getMedicalVisits();
  }

  @override
  void initState() {
    super.initState();

    getPatientData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(
          routes: {
            'Medical History': PatientHistory(uid: widget.uid),
            'Allergy': PatientAllergy(
              uid: widget.uid,
            ),
            'Blood Pressure': PatientBloodPress(uid: widget.uid),
            'Blood Glucose': PatientBloodGlu(uid: widget.uid),
            'Vaccines': PatientVaccine(
              uid: widget.uid,
            ),
            'Profile': PatientProfileScreen(uid: widget.uid, nationalId: id),
            'Log Out': LoginScreen()
          },
          icons: const [
            Icons.history,
            MedicalIcons.infectious_diseases,
            MedicalIcons.cardiology,
            MedicalIcons.diabetes_education,
            MedicalIcons.administration,
            Icons.person,
            Icons.logout
            //  MedicalIcons.genetics,
          ],
        ),
        backgroundColor: bgClr,
        appBar: AppBar(
          backgroundColor: prmClr,
          title: Text(
            name.isEmpty ? 'Patient\'s History' : '$name\'s History',
            style: headingStyle,
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(15),
          child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection(
                      'Patients/${widget.uid}/medicalvisits') // 👈 Your collection name here
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView(
                        children: snapshot.data!.docs.map(
                          (DocumentSnapshot doc) {
                            Map<String, dynamic> data =
                                doc.data() as Map<String, dynamic>;
                            return Container(
                              width: double.infinity,
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(),
                                  color: white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Medical Visit',
                                        style: titleStyle,
                                      ),
                                      TextButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    prmClr)),
                                        onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChatScreen(
                                                  patientUid: widget.uid,
                                                  docUid: data['docEmail']
                                                      as String,
                                                  isPatient: true),
                                            )),
                                        child: Text(
                                          'Chat',
                                          style:
                                              bodyStyle.copyWith(color: white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Doctor Name: ${data['docname']}',
                                    style: subtitleStyle,
                                    overflow: TextOverflow.clip,
                                  ),
                                  Text(
                                    'Place: ${data['place']}',
                                    style: subtitleStyle,
                                  ),
                                  Text(
                                    'Diagnosis: ${data['diagnosis']}',
                                    style: subtitleStyle,
                                  ),
                                  Text(
                                    'Drug: ${data['drugs']}',
                                    style: subtitleStyle,
                                  ),
                                  Text(
                                    'Date : ${data['date']}',
                                    style: subtitleStyle,
                                  ),
                                  Text(
                                    'Notes: ${data['note']}',
                                    style: subtitleStyle,
                                  ),
                                  Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: Image.network(
                                        '${data['imgUrl']}',
                                        height: SizeConfig.screenHeight * 0.3,
                                        fit: BoxFit.fitHeight,
                                      ))
                                  // Row(
                                  //   children: [
                                  //     ButtonShape(
                                  //         buttonText: 'Send',
                                  //         width: SizeConfig.screenWidth * 0.1,
                                  //         height: 15)
                                  //   ],
                                  // )
                                ],
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    )
                  ],
                );
              }

              // const HistoryItem(
              //     title: 'Radiology',
              //     lapName: 'EL Borg',
              //     testName: 'CPC',
              //     dateTime: '27/4/2022, 1:43 PM',
              //     notes: 'Optimal case',
              //     img: 'assets/analysis.png'),
              // const HistoryItem(
              //     title: 'Lap Test',
              //     lapName: 'EL Borg',
              //     testName: 'CPC',
              //     dateTime: '27/4/2022, 1:43 PM',
              //     notes: 'Optimal case',
              //     img: 'assets/analysis.png'),
              ),
        ),
      ),
    );
  }
}
