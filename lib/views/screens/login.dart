import 'package:eraqi_project_graduation/views/screens/patients_screens/patient_history.dart';
import 'package:eraqi_project_graduation/views/screens/registeration.dart';
import 'package:eraqi_project_graduation/views/size_config.dart';
import 'package:eraqi_project_graduation/views/widgets/button_shape.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';

  String password = '';

  bool isLoading = false;

  String confirm = '';

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // confirmationLogin() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   if (_formkey.currentState!.validate()) {
  //     confirm = await AuthController()
  //         .loginUsers(email, password)
  //         .whenComplete(() => _formkey.currentState!.reset());
  //     if (confirm == 'success') {
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(
  //         builder: (context) => const MainScreen(),
  //       ));
  //       return myShowSnackBar(context, 'Logged in successfully');
  //     } else {
  //       log('failed to log in, login screen');
  //       setState(() {
  //         isLoading = false;
  //       });
  //       return myShowSnackBar(context, 'Failed to log in, try again');
  //     }
  //   }
  // }

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
              InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PatientHistory(),
                        ));
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
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ));
                      },
                      child: const Text('Register'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
