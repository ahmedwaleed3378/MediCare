import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraqi_project_graduation/views/size_config.dart';
import 'package:eraqi_project_graduation/views/theme.dart';
import 'package:eraqi_project_graduation/views/widgets/button_shape.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../widgets/my_snackbar.dart';
import 'doc_screens/find_patient_screen.dart';
import 'login.dart';
import 'patients_screens/patient_history.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _email = '';

  String _password = '';
  bool? _isPatient;
  String _phoneNumber = '';
  String _gender = '';
  String _nationalID = '';
  String _address = '';
  Color typeBorder = bgClr;
  bool isLoading = false;
  String _fullName = '';
  String? uid;
  bool? _type;
  DateTime? _selectedDate;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  signUpToFirebase() async {
    setState(() {
      isLoading = true;
    });



  try {
  UserCredential _firebaseAuth=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
  FirebaseFirestore.instance
          .collection(_isPatient!?'Patients':'Doctors')
          .doc(_firebaseAuth.user!.uid)
          .set({
        'email': _email,
        'fullname': _fullName,
        'Id': _nationalID,
        'address': _address,
        'birthDate':DateFormat.yMd().format(_selectedDate!),
        'gender': _type!? 'male':'female' ,
        'type': _type,
        'phoneNumber': _phoneNumber,
        'uid':_firebaseAuth.user!.uid
      });
  Navigator.pushReplacement(context, MaterialPageRoute(builder:((context) => _isPatient!? PatientHistory(uid:_firebaseAuth.user!.uid):FindPatientScreen(uid:_firebaseAuth.user!.uid,))));
  setState(() {
        isLoading = false;
      }); myShowSnackBar(
          context, 'Your Accont has been created successfully');

} on FirebaseAuthException catch (e) {

        myShowSnackBar(context, 'Failed to create an account',isRed: true);
 setState(() {
        isLoading = false;
      });
}
    // if (_formkey.currentState!.validate()) {
    // uid=  await AuthController()
    //       .signUpUsers(
    //           _fullName,
    //           _email,
    //           _password,
    //           _phoneNumber,
    //           _nationalID,
    //           _address,
    //           _type! ? 'male' :'female' ,
    //           '${DateFormat.yMd().format(_selectedDate!)}',
    //           (_isPatient!) ? '1' : '0')
    //       .whenComplete(() {
    //      if (uid!='false') {
    //         _formkey.currentState!.reset();
    //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => _isPatient! ?PatientHistory(uid:uid!) : FindPatientScreen(uid:uid!,)));
    //   myShowSnackBar(
    //       context, 'Your Accont has been created successfully');
    //      }
    //       });
    //   setState(() {
    //     isLoading = false;
    //   });
         
    // } else {
    //   setState(() {
    //     isLoading = false;
    //   });
    //   return myShowSnackBar(context, 'Please check your internet connection');
    // }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgClr,
        appBar: AppBar(
            backgroundColor: bgClr,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Medicare',
              style: headingStyle.copyWith(color: prmClr),
            )),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(
                top: 17,
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Registeration',
                        style: headingStyle.copyWith(color: darkGreyClr)),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your name';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          _fullName = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'your full name',
                            hintStyle: const TextStyle(color: Colors.black54),
                            labelText: 'Name',
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your email address';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          _email = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'example@email.com',
                            hintStyle: const TextStyle(color: Colors.black54),
                            labelText: 'Email Address',
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),
                    
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: typeBorder)),
                        margin: const EdgeInsets.all(15),
                        padding: const EdgeInsets.all(7),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.2,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _type = true;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 15),
                                width: 13,
                                height: 13,
                                decoration: BoxDecoration(
                                    color: _type != null
                                        ? ((_type!) ? prmClr : bgClr)
                                        : bgClr,
                                    shape: BoxShape.circle,
                                    border: Border.all()),
                              ),
                            ),
                            const Text('Male'),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _type = false;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 15),
                                width: 13,
                                height: 13,
                                decoration: BoxDecoration(
                                    color: _type != null
                                        ? (!(_type!) ? prmClr : bgClr)
                                        : bgClr,
                                    shape: BoxShape.circle,
                                    border: Border.all()),
                              ),
                            ),
                            const Text('Female'),
                            const Spacer(),
                          ],
                        )),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                    //   child: TextFormField(
                    //     validator: (value) {
                    //       if (value!.isEmpty &&
                    //           (value.toLowerCase() != 'male' ||
                    //               value.toLowerCase() != 'female')) {
                    //         return 'Male or Female?';
                    //       } else {
                    //         return null;
                    //       }
                    //     },
                    //     onChanged: (value) {
                    //       _gender = value;
                    //     },
                    //     decoration: InputDecoration(
                    //         border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(10),
                    //             borderSide: BorderSide.none),
                    //         hintText: 'Male or Female',
                    //         hintStyle: const TextStyle(color: Colors.black54),
                    //         labelText: 'Gender',
                    //         fillColor: Colors.white,
                    //         filled: true),
                    //   ),
                    // ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length != 14) {
                            return 'Please Enter your National ID Correctly';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          _nationalID = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: '14-number length',
                            hintStyle: const TextStyle(color: Colors.black54),
                            labelText: 'National ID',
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your address';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          _address = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: '14- Ramsis St- Minya ',
                            hintStyle: const TextStyle(color: Colors.black54),
                            labelText: 'Address',
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length != 11) {
                            return 'Please Enter your phone number Correctly';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          _phoneNumber = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: '+2010 9492 9414',
                            hintStyle: const TextStyle(color: Colors.black54),
                            labelText: 'Phone Number',
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your password';
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                        onChanged: (value) {
                          _password = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: '******',
                            hintStyle: const TextStyle(color: Colors.black54),
                            labelText: 'Password',
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 25,
                          ),
                          Text(
                            _selectedDate == null
                                ? 'Enter Your Birth Date'
                                : ' ${DateFormat.yMd().format(_selectedDate!)}',
                            style: subtitleStyle.copyWith(
                                color: darkHeaderClr.withOpacity(0.8)),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => getDateFromUser(),
                            icon: const Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: typeBorder)),
                        margin: const EdgeInsets.all(15),
                        padding: const EdgeInsets.all(7),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.2,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _isPatient = true;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 15),
                                width: 13,
                                height: 13,
                                decoration: BoxDecoration(
                                    color: _isPatient != null
                                        ? ((_isPatient!) ? prmClr : bgClr)
                                        : bgClr,
                                    shape: BoxShape.circle,
                                    border: Border.all()),
                              ),
                            ),
                            const Text('Patient'),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _isPatient = false;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 15),
                                width: 13,
                                height: 13,
                                decoration: BoxDecoration(
                                    color: _isPatient != null
                                        ? (!(_isPatient!) ? prmClr : bgClr)
                                        : bgClr,
                                    shape: BoxShape.circle,
                                    border: Border.all()),
                              ),
                            ),
                            const Text('Doctor'),
                            const Spacer(),
                          ],
                        )),
                    InkWell(
                      child: isLoading
                          ? Container(
                              margin: const EdgeInsets.all(15),
                              alignment: Alignment.center,
                              color: prmClr,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : ButtonShape(
                              buttonText: 'Sign Up',
                              height: SizeConfig.screenHeight * 0.07,
                              width: SizeConfig.screenWidth * 0.7,
                            ),
                      onTap: () {
                        if (_formkey.currentState!.validate() &&
                            _selectedDate != null &&
                            (_isPatient) != null
                             &&
                            (_type) != null
                            ) {
                          // Person(
                          //     _fullName,
                          //     _gender,
                          //     DateFormat.yMd()
                          //         .format(_selectedDate!)
                          //         .toString(),
                          //     _nationalID,
                          //     _email,
                          //     _address,
                          //     _phoneNumber,
                          //     _isPatient!);

                          try {
                            signUpToFirebase();
                          } on Exception catch (e) {
                            print('\n--------------${e.toString()}');
                          }

                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => const PatientListScreen(),
                          //     ));
                        } else {
                          if (_selectedDate == null) {
                            Fluttertoast.showToast(
                                msg: 'Please fill the data correctly',
                                backgroundColor: Colors.black,
                                toastLength: Toast.LENGTH_LONG);
                          }
                          if (_isPatient == null) {
                            setState(() {
                              typeBorder = Colors.red;
                            });
                          } else {
                            setState(() {
                              typeBorder = bgClr;
                            });
                          }
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already Have An Account?'),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                            },
                            child: const Text('Login')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getDateFromUser() async {
    DateTime? pickeddate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1930),
        lastDate: DateTime(2024));
    pickeddate != null
        ? setState(() {
            _selectedDate = pickeddate;
          })
        : print('It\'s Null');
  }
}
