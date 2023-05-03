import 'package:eraqi_project_graduation/views/screens/doc_screens/doc_profile_screen.dart';
import 'package:eraqi_project_graduation/views/screens/doc_screens/patient_list_screen.dart';
import 'package:eraqi_project_graduation/views/size_config.dart';
import 'package:eraqi_project_graduation/views/theme.dart';
import 'package:eraqi_project_graduation/views/widgets/button_shape.dart';
import 'package:eraqi_project_graduation/views/widgets/search_field.dart';
import 'package:flutter/material.dart';

import '../../widgets/my_drawer.dart';

class FindPatientScreen extends StatelessWidget {
  const FindPatientScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      drawer:const MyDrawer(routes: {'Find Patient':FindPatientScreen(),'Profile': DocProfileScreen()},  icons: [Icons.find_in_page,
           Icons.person],),
      backgroundColor: bgClr,
      appBar: AppBar(
      backgroundColor: prmClr,
        title: Text(
          'Find Patient',
          style: headingStyle,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: SearchField(
                  height: SizeConfig.screenHeight * 0.08,
                  width: SizeConfig.screenWidth * 0.4,
                )),
                InkWell(
                  onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const PatientListScreen(),)),
                  child: ButtonShape(
                    buttonText: 'Find',
                    height: SizeConfig.screenHeight * 0.07,
                    width: SizeConfig.screenWidth * 0.1,
                  ),
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
                  child: Image.asset('assets/Qr.png'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
