import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraqi_project_graduation/models/patient_info.dart';
import 'package:eraqi_project_graduation/views/size_config.dart';
import 'package:eraqi_project_graduation/views/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../widgets/input_field.dart';

class AddPrescriptionScreen extends StatefulWidget {
  const AddPrescriptionScreen(
      {super.key,
      required this.uid,
      required this.place,
      required this.docName, required this.docEmail});
  final String uid;
  final String place;
  final String docName;
  final String docEmail;
  @override
  State<AddPrescriptionScreen> createState() => _AddPrescriptionScreenState();
}

class _AddPrescriptionScreenState extends State<AddPrescriptionScreen> {
  DateTime _selectedDate = DateTime.now();
  TextEditingController diagnosis = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController drug = TextEditingController();
     String date='';
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Future<void> _uploadMedicalVisitToFirebase(MedicalVisit visit) async {
    await FirebaseFirestore.instance
        .collection('Patients/${widget.uid}/medicalvisits')
        .doc()
        .set(visit.toJson());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: prmClr,
        title: Text(
          ' Prescription',
          style: headingStyle,
        ),
      ),
      backgroundColor: bgClr,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                InputField(
                  title: 'Diagnosis',
                  hint: '',
                  controller: diagnosis,
                ),
                InputField(
                  title: 'Drug',
                  hint: '',
                  controller: drug,
                ),
                InputField(
                  title: 'Notes',
                  controller: notes,
                  hint: '',
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date',
                      style: titleStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      
                        Text(
                          ' ${DateFormat.yMd().format(_selectedDate)}',
                          style: subtitleStyle,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.5,
                        ),
                        IconButton(
                          onPressed: () => getDateFromUser(),
                          icon: const Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: prmClr),
                    child: const Center(
                        child: Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                          fontSize: 22),
                    )),
                  ),
                  onTap: ()  {
                    if (_formkey.currentState!.validate()) {
                        _uploadMedicalVisitToFirebase(MedicalVisit(
                            drugs: drug.text,
                            docname: widget.docName,
                            place: widget.place,
                            diagnosis: diagnosis.text,
                            date: date,
                            docEmail: widget.docEmail,
                            note: notes.text));
                        Fluttertoast.showToast(
                            msg: 'Prescription added successfully',
                            backgroundColor: prmClr,
                            toastLength: Toast.LENGTH_LONG);
                        _formkey.currentState!.reset();
                   
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getDateFromUser() async {
    DateTime? pickeddate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2024));
    pickeddate != null
        ? setState(() {
            _selectedDate = pickeddate;
          })
        : print('It\'s Null');
       date='${DateFormat.yMd(_selectedDate)}';
  }
}
