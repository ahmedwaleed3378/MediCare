import 'package:eraqi_project_graduation/views/screens/doc_screens/qr_check_screen.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';
import '../../theme.dart';
import '../../widgets/my_drawer.dart';
import 'find_patient_screen.dart';

class DocProfileScreen extends StatelessWidget {
  const DocProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        drawer: const MyDrawer(
          routes: {
            'Find Patient': FindPatientScreen(),
            'Profile': DocProfileScreen()
          },
          icons: [Icons.find_in_page,
           Icons.person],
        ),
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
                  Image.asset('assets/Person.png'),
                  Text(
                    'Doctor: Eraqi',
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
                              builder: (context) => const QrCheckScreen(),
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
                  style: body2Style,
                  overflow: TextOverflow.fade,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text('Gender: Male'),
                      Text('Age: 21'),
                      Text('Birth Date: 13-10-2000'),
                      Text('National ID: 215648941871215'),
                      Text('Email: example@gmail.com'),
                      Text('Address: Samalut'),
                      Text('Phone Number: 01094929414'),
                    ],
                  )),
            ])));
  }
}
