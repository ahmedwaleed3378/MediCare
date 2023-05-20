import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraqi_project_graduation/models/patient_info.dart';
import 'package:eraqi_project_graduation/views/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../size_config.dart';
import '../../theme.dart';
import '../../widgets/input_field.dart';

class AddBloodGlu extends StatefulWidget {
  const AddBloodGlu({
    super.key,
    required this.uid,
  });
  final String uid;
  @override
  State<AddBloodGlu> createState() => _AddBloodGluState();
}

class _AddBloodGluState extends State<AddBloodGlu> {
  Future<void> uploadAllergy(Glucose glu) async {
    await FirebaseFirestore.instance
        .collection('Patients/${widget.uid}/glucose')
        .doc()
        .set(glu.toJson());
  }

  DateTime _selectedDate = DateTime.now();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MyScaffold(
      title: 'Blood Glucose',
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                InputField(
                  title: 'Blood Glucose',
                  controller: textEditingController,
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
                        const SizedBox(
                          width: 25,
                        ),
                        Text(
                          ' ${DateFormat.yMd().format(_selectedDate)}',
                          style: subtitleStyle,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.4,
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
                  onTap: () {
                    //
                    if (_formkey.currentState!.validate()) {
                      try {
                        uploadAllergy(Glucose(
                            glucoseRatio: textEditingController.text,
                            date: '${DateFormat.yMd().format(_selectedDate)}'));
                        Fluttertoast.showToast(
                            msg: 'Blood Glucose added successfully',
                            backgroundColor: prmClr,
                            toastLength: Toast.LENGTH_LONG);
                        _formkey.currentState!.reset();
                      } catch (e) {
                        print(e.toString());
                        Fluttertoast.showToast(
                            msg: 'Failed to save Blood Glucose ratio',
                            backgroundColor: prmClr,
                            toastLength: Toast.LENGTH_LONG);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Please fill the data correctlly',
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
        firstDate: DateTime(2015),
        lastDate: DateTime(2030));
    pickeddate != null
        ? setState(() {
            _selectedDate = pickeddate;
          })
        : print('It\'s Null');
  }
}
