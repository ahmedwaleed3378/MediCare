import 'package:flutter/material.dart';

import '../screens/doc_screens/doc_profile_screen.dart';
import '../screens/doc_screens/find_patient_screen.dart';
import '../theme.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key, required this.routes, required this.icons,
  });
  final Map<String,dynamic> routes;
  final List<IconData>icons;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
         Container(
          margin: const EdgeInsets.all(15),
           child: Text(
              'MediCare',
              style: headingStyle.copyWith(color: darkGreyClr),
              textAlign: TextAlign.center,
            ),
         ),
           const Divider(),
        Expanded(
          child: ListView.builder(
            itemCount: routes.length, padding: const EdgeInsets.all(18),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
              leading:  Icon(icons[index]),
              title: Text(
                routes.keys.toList()[index],
                style: subtitleStyle,
              ),
                    tileColor: bgClr,
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => routes.values.toList()[index],
                    ));
              },
            );
            },
          ),
        ),
      ],)



     //  ListView(
      //   padding: const EdgeInsets.all(18),
      //   children: [
      //     Text(
      //       'MediCare',
      //       style: headingStyle.copyWith(color: darkGreyClr),
      //       textAlign: TextAlign.center,
      //     ),
      //     const Divider(),
      //     ListTile(
      //       leading: const Icon(Icons.find_in_page),
      //       title: Text(
      //         'Find Patient',
      //         style: subtitleStyle,
      //       ),
      //       tileColor: tile,
      //       onTap: () {
      //         Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => FindPatientScreen(),
      //             ));
      //       },
      //     ),
      //     ListTile(
      //       leading: const Icon(Icons.person),
      //       title: Text(
      //         'Profile',
      //         style: subtitleStyle,
      //       ),
      //       tileColor: bgClr,
      //       onTap: () {
      //         Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => const DocProfileScreen(),
      //             ));
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}
