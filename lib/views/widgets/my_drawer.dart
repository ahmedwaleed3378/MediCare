import 'package:eraqi_project_graduation/models/firebase_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../theme.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
    required this.routes,
    required this.icons,
  });
  final Map<String, dynamic> routes;
  final List<IconData> icons;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
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
            itemCount: routes.length,
            padding: const EdgeInsets.all(18),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(icons[index]),
                title: Text(
                  routes.keys.toList()[index],
                  style: subtitleStyle,
                ),
                tileColor: bgClr,
                onTap: () {
                  if (index == routes.length - 1) {
                    try {
                      AuthController().signOut();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => routes.values.toList()[index],
                          ));
                    } on FirebaseAuthException catch (e) {
                      Fluttertoast.showToast(
                          msg: e.message.toString(),
                          backgroundColor: Colors.black,
                          toastLength: Toast.LENGTH_LONG);
                    }
                  } else if (index == 0) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => routes.values.toList()[index],
                        ));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => routes.values.toList()[index],
                        ));
                  }
                },
              );
            },
          ),
        ),
      ],
    )

        
        );
  }
}
