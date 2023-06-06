
import 'package:eraqi_project_graduation/models/patient_info.dart';
import 'package:eraqi_project_graduation/views/size_config.dart';
import 'package:eraqi_project_graduation/views/theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class PatientHistoryView extends StatefulWidget {
  const PatientHistoryView({super.key, required this.uid});
  final String uid;

  @override
  State<PatientHistoryView> createState() => _PatientHistoryViewState();
}

class _PatientHistoryViewState extends State<PatientHistoryView> {
  bool isLoading=false;
  String name = '';
  String id = '';
  String address = '';
  String gender = '';
  String phoneNumber = '';
  String type = '';
  String docEmail= '';
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
    setState(() {
  isLoading=true;
});
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
      setState(() {
  isLoading=false;
});
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
        
        backgroundColor: bgClr,
        appBar: AppBar(
          backgroundColor: prmClr,
          title: Text(isLoading?
             '' : '$name\'s History',
            style: headingStyle,
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(15),
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
                                  Text(
                                    'Medical Visit',
                                    style: titleStyle,
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
