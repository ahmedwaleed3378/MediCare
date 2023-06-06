import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraqi_project_graduation/models/patient_info.dart';
import 'package:eraqi_project_graduation/views/size_config.dart';
import 'package:eraqi_project_graduation/views/theme.dart';
import 'package:file_picker/file_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../widgets/input_field.dart';

class AddPrescriptionScreen extends StatefulWidget {
  const AddPrescriptionScreen(
      {super.key,
      required this.uid,
      required this.place,
      required this.docName,
      required this.docEmail});
  final String uid;
  final String place;
  final String docName;
  final String docEmail;
  @override
  State<AddPrescriptionScreen> createState() => _AddPrescriptionScreenState();
}

class _AddPrescriptionScreenState extends State<AddPrescriptionScreen> {
  dynamic _imageSelected;
  String? _fileName;
  Uint8List?  fileU;
  String? imageURL;

  pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false,type: FileType.image,withData: true);

    if (result != null) {
      setState(() {
        _fileName = result.files.first.path.toString();

        _imageSelected = FileImage(File(_fileName!));
      });
        fileU = result.files.first.bytes;
    }
  }

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  uploadBannersToStorage(dynamic image) async {
 
    setState(() {
  upload=true;
});
    Reference ref =
        _firebaseStorage.ref().child('medicalvisits').child(_fileName!);

    UploadTask uploadTask = ref.putData(fileU!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    imageURL = downloadURL;
  
    setState(() {
      _imageSelected = null;
      upload=false;
    });
  }

  // retriveCheck() async {
  // uploadToFireStore() async {
  //   if (_imageSelected != null) {
  //     await uploadBannersToStorage(_imageSelected) as String;
  //   }
  // }
bool upload=false;
  DateTime _selectedDate = DateTime.now();
  TextEditingController diagnosis = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController drug = TextEditingController();
  String date = '';
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Future<void> _uploadMedicalVisitToFirebase(MedicalVisit visit) async {
    uploadBannersToStorage(_imageSelected);
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
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade800),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade500),
                    child: Center(
                        child: _imageSelected == null
                            ? const Text('Analysis')
                            :Image(image:_imageSelected)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(prmClr)),
                      onPressed: () async {
                        await pickImage();
                      },
                      child: const Text('Upload Image')),
                ]),
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: prmClr),
                    child:  Center(
                        child:
                        upload?const CircularProgressIndicator():
                       const  Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                          fontSize: 22),
                    )),
                  ),
                  onTap: ()async {
                    await uploadBannersToStorage(_imageSelected);
                    if (_formkey.currentState!.validate() && imageURL != null) {
                      _uploadMedicalVisitToFirebase(MedicalVisit(
                          drugs: drug.text,
                          docname: widget.docName,
                          place: widget.place,
                          diagnosis: diagnosis.text,
                          date: date,
                          docEmail: widget.docEmail,
                          note: notes.text,
                          imageURL: imageURL!));
                      drug.clear();
                      notes.clear();
                      diagnosis.clear();
                      Fluttertoast.showToast(
                          msg: 'Prescription added successfully',
                          backgroundColor: prmClr,
                          toastLength: Toast.LENGTH_LONG);
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
    date = '${DateFormat.yMd().format(_selectedDate)}';
  }
}
