import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraqi_project_graduation/views/screens/doc_screens/qr_check_screen.dart';
import 'package:eraqi_project_graduation/views/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';
import '../../theme.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key, required this.uid, required this.nationalId});
  final String uid;
  final String nationalId;
  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  String name = '';
  String nationalId = '';
  String gender = '';
  String birthDate = '';
  String address = '';
  String phoneNum = '';
  String email = '';
  bool isLoading = false;
  getdata() async {
    await FirebaseFirestore.instance
        .collection('Patients')
        .doc(widget.uid)
        .get()
        .then((DocumentSnapshot doc) {
      name = doc['fullname'];
      nationalId = doc['Id'];
      address = doc['address'];
      birthDate = doc['birthDate'];
      gender = doc['gender'];
      phoneNum = doc['phoneNumber'];
      email = doc['email'];
      setState(() {
        isLoading = true;
      });
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MyScaffold(
      title: 'Profile',
      body: isLoading
          ? Container(
              margin: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/Person.png'),
                      Text(
                        name,
                        style: titleStyle,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(SizeConfig.screenHeight * 0.01),
                        height: SizeConfig.screenHeight * 0.07,
                        width: SizeConfig.screenWidth * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: prmClr,
                        ),
                        child: InkWell(
                          child: Image.asset('assets/Qr.png'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      QrCheckScreen(id: nationalId),
                                ));
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultTextStyle(
                    
                    style: subtitleStyle,
                    overflow: TextOverflow.fade,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Gender:   ${gender}'),
                        SizedBox(height: SizeConfig.screenHeight*0.07,),
                        //      Text('Age: ${}'),
                        Text('Birth Date:   ${birthDate}'),  SizedBox(height: SizeConfig.screenHeight*0.07,),
                        Text('National ID:   ${nationalId}'),  SizedBox(height: SizeConfig.screenHeight*0.07,),
                        Text('Email:   ${email}'),  SizedBox(height: SizeConfig.screenHeight*0.07,),
                        Text('Address:   ${address}'),  SizedBox(height: SizeConfig.screenHeight*0.07,),
                        Text('Phone Number:   ${phoneNum}'),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                color: prmClr,
              ),
            ),
    );
  }
}
