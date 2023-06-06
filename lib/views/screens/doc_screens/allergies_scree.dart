import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraqi_project_graduation/models/patient_info.dart';
import 'package:eraqi_project_graduation/views/screens/patients_screens/add_allery.dart';
import 'package:eraqi_project_graduation/views/theme.dart';
import 'package:eraqi_project_graduation/views/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';

class PatientAllergyView extends StatefulWidget {
  const PatientAllergyView({
    super.key,
    required this.uid,
  });
  final String uid;

  @override
  State<PatientAllergyView> createState() => _PatientAllergyViewState();
}

class _PatientAllergyViewState extends State<PatientAllergyView> {
  List<Allergies> allergies = [];
  @override
  Widget build(BuildContext context) {

    return MyScaffold(
      title: 'Allergy',
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection(
                'Patients/${widget.uid}/allergy') // 👈 Your collection name here
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Allergy',
                      style: titleStyle,
                    ),
                    const Spacer(),
                    Text(
                      'Date',
                      style: titleStyle,
                    ),
                    const SizedBox(width: 15)
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${data['name']}',
                                style: subtitleStyle,
                              ),
                              const Spacer(),
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
                    builder: (context) => AddAlerrgy(
                      uid: widget.uid,
                    ),
                  ));
            },
            icon: const Icon(Icons.add))
      ],
    );
  }
}
