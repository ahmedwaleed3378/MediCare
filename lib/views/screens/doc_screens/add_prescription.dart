import 'package:eraqi_project_graduation/views/size_config.dart';
import 'package:eraqi_project_graduation/views/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../widgets/input_field.dart';

class AddPrescriptionScreen extends StatefulWidget {
  AddPrescriptionScreen({super.key});

  @override
  State<AddPrescriptionScreen> createState() => _AddPrescriptionScreenState();
}

class _AddPrescriptionScreenState extends State<AddPrescriptionScreen> {
  DateTime _selectedDate = DateTime.now();
  String _stratTime = DateFormat('hh:mm:a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm:a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              const InputField(
                title: 'Drug',
                hint: '',
              ),
              const InputField(
                title: 'Dose',
                hint: '',
              ),
              const InputField(
                title: 'Notes',
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
                      const SizedBox(width: 25,),
                      Text(
                        ' ${DateFormat.yMd().format(_selectedDate)}',
                        style: subtitleStyle,
                      ),
                       SizedBox(
                        width: SizeConfig.screenWidth*0.7,
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
                      borderRadius: BorderRadius.circular(10),
                      color: prmClr),
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
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.reset();
                    Fluttertoast.showToast(
                        msg: 'Prescription added successfully',
                        backgroundColor: prmClr,
                        toastLength: Toast.LENGTH_LONG
                        );
                  }
                },
              )
            ],
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

  getTimeFromUser(bool isStartTime) async {
    TimeOfDay? pickedtime = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15))),
    );
    String _formated = pickedtime!.format(context);
    if (isStartTime) {
      setState(() {
        _stratTime = _formated;
      });
    } else if (!isStartTime) {
      setState(() {
        _endTime = _formated;
      });
    } else {
      print('time canceled');
    }
  }
}
