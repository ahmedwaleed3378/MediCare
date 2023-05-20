import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraqi_project_graduation/views/screens/doc_screens/find_patient_screen.dart';
import 'package:eraqi_project_graduation/views/screens/patients_screens/patient_history.dart';
import 'package:eraqi_project_graduation/views/screens/registeration.dart';
import 'package:eraqi_project_graduation/views/size_config.dart';
import 'package:eraqi_project_graduation/views/widgets/button_shape.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';

  String password = '';

  bool isLoading = false;

  bool confirm = false;
  bool signed=false;
  bool? _isPatient;
  Color typeBorder = bgClr;
  UserCredential? _userCredential;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<bool> confirmationLogin() async {
    setState(() {
      isLoading = true;
    });
   try {
 _userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  confirm =true;
  return true;
} on FirebaseAuthException catch (e) {
   Fluttertoast.showToast(
                                msg: e.message.toString(),
                                backgroundColor: Colors.black,
                                toastLength: Toast.LENGTH_LONG); return false;
}
    // _userCredential = await AuthController()
    //     .loginUsers(email, password)
    //     .whenComplete(() => _formkey.currentState!.reset());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'LogIn',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter your phone number';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    email = value;
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
              Padding(
                padding: const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter your phone number';
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
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
                          width: 18,
                          height: 18,
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
                          width: 18,
                          height: 18,
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
                  onTap: ()  async{
                    if (_formkey.currentState!.validate() &&
                        _isPatient != null &&
                        password.length >= 6) {
                  try {
                       signed=await confirmationLogin();
               if (signed&&_userCredential!=null) {
                 Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return _isPatient!
                                ? PatientHistory(uid: _userCredential!.user!.uid,)
                                :  FindPatientScreen(uid:_userCredential!.user!.uid ,);
                          },
                        ));
               }      
               else{
                 Fluttertoast.showToast(
                            msg: 'Username or password is wrong',
                            backgroundColor: Colors.black,
                            toastLength: Toast.LENGTH_LONG);
               }
                    } on FirebaseAuthException catch (e) {
                        print(e.toString());
                        Fluttertoast.showToast(
                            msg: 'Username or password is wrong',
                            backgroundColor: Colors.black,
                            toastLength: Toast.LENGTH_LONG);
                      }
                  //  Fluttertoast.showToast(
                  //           msg: 'Username or password is wrong',
                  //           backgroundColor: Colors.black,
                  //           toastLength: Toast.LENGTH_LONG);
                      
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Please fill the data correctly',
                          backgroundColor: Colors.black,
                          toastLength: Toast.LENGTH_LONG);
                    }
                  },
                  child: ButtonShape(
                    buttonText: 'Login',
                    height: SizeConfig.screenHeight * 0.07,
                    width: SizeConfig.screenWidth * 0.7,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Need A new account?'),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ));
                      },
                      child: const Text('Register'))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
               
                  TextButton(
                      onPressed: () {
                    
                      },
                      child: const Text('Forgot your Password?'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// void ahmed(){    if (_formkey.currentState!.validate()) {
//   try {
//     FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
//     Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => const MainScreen(),
//       }
//   } catch (e) {
    
//   }
//    else {
//         log('failed to log in, login screen');
//         setState(() {
//           isLoading = false;
//         });
//         return myShowSnackBar(context, 'Failed to log in, try again');
//       }
//     }
//   }}



