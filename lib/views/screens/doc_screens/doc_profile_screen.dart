import 'package:eraqi_project_graduation/views/screens/doc_screens/qr_check_screen.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';
import '../../theme.dart';


class DocProfileScreen extends StatelessWidget {
  const DocProfileScreen({super.key, required this.name, required this.email, required this.nationalId, required this.address, required this.birthDate, required this.gender, required this.phoneNumber,});
  final String name;
  final String email;
  final String nationalId;
  final String address;
  final String birthDate;
  final String gender;
  final String phoneNumber;


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
       
        appBar: AppBar(
          backgroundColor: prmClr,
          title: Text(
            ' Profile',
            style: headingStyle,
          ),
        ),
        backgroundColor: bgClr,
        body: Container(
            margin: const EdgeInsets.all(25),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/Person.png',width: 50,height: 50,),
                  Text(
                    'Doctor\n${name}',
                    style: titleStyle.copyWith(letterSpacing: 4),
                    textAlign: TextAlign.center,
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
                              builder: (context) => QrCheckScreen(
                                id: '${email}',
                              ),
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
                    children:  [SizedBox(height: SizeConfig.screenHeight*0.07,),
                      Text('Gender: ${gender}'),SizedBox(height: SizeConfig.screenHeight*0.07,),
                      Text('Birth Date: ${birthDate}'),SizedBox(height: SizeConfig.screenHeight*0.07,),
                      Text('National ID: ${nationalId}'),SizedBox(height: SizeConfig.screenHeight*0.07,),
                      Text('Email: ${email}'),SizedBox(height: SizeConfig.screenHeight*0.07,),
                      Text('Address: ${address}'),SizedBox(height: SizeConfig.screenHeight*0.07,),
                      Text('Phone Number: ${phoneNumber}'),
                    ],
                  )),
            ])));
  }
}
