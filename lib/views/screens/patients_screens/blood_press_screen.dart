import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraqi_project_graduation/views/screens/patients_screens/add_blood_prss_screen.dart';
import 'package:eraqi_project_graduation/views/theme.dart';
import 'package:eraqi_project_graduation/views/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';
class PatientBloodPress extends StatelessWidget {
  const PatientBloodPress({super.key, required this.uid});
   final String uid;
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Blood Press.',
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection(
                'Patients/${uid}/pressure') // 👈 Your collection name here
            .get(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '   Sys',
                      style: titleStyle,
                    ),
                    Text(
                      '   Dia',
                      style: titleStyle,
                    ),
                    Text(
                      '   Pu\\min',
                      style: titleStyle,
                    ),
                    Text(
                      '   Date',
                      style: titleStyle,
                    ),
                    const SizedBox(width: 8)
                  ],
                ),
                Expanded(
                  child: ListView(
                      padding: const EdgeInsets.all(10),
                      children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                        Map<String, dynamic> data =
                            doc.data() as Map<String, dynamic>;
                        return Container(margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${data['sys']}',
                                style: subtitleStyle,
                              ),
                              Text(
                                '${data['dia']}',
                                style: subtitleStyle,
                              ),
                              Text(
                                '${data['pulMin']}',
                                style: subtitleStyle,
                              ),
                          
                              Text(
                                '${data['date']}',
                                style: subtitleStyle,
                              )
                            ],
                          ),
                        );
                      }).toList()),
                ),
              ],
            ),
          );
        },
      ),
      
      
      
       actoins: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddBloodPress(
                     uid:uid),
                  ));
            },
            icon: const Icon(Icons.add))
      ],
    );
  }
}
