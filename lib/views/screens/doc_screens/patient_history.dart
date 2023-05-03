import 'package:eraqi_project_graduation/views/size_config.dart';
import 'package:eraqi_project_graduation/views/theme.dart';
import 'package:eraqi_project_graduation/views/widgets/history_item.dart';
import 'package:flutter/material.dart';

class PatientHistoryView extends StatelessWidget {
  const PatientHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: bgClr,
      appBar: AppBar(
        title: Text(
          ' Patient\' History',
          style: headingStyle,
        ),
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 15),
              child:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(),
                    color: white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Medical Visit',
                      style: titleStyle,
                    ),
                    Text(
                      'Doctor Name: Ahmed',
                      style: subtitleStyle,
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      'Place: Minya',
                      style: subtitleStyle,
                    ),
                    Text(
                      'Diagnosis: Flu',
                      style: subtitleStyle,
                    ),
                    Text(
                      'Date & Time: 27/4/2022, 1:43 PM',
                      style: subtitleStyle,
                    ),
                    Text(
                      'Notes: optimal case',
                      style: subtitleStyle,
                    ),
                    // Row(
                    //   children: [
                    //     ButtonShape(
                    //         buttonText: 'Send',
                    //         width: SizeConfig.screenWidth * 0.1,
                    //         height: 15)
                    //   ],
                    // )
                  ],
                ),
              ),
              const HistoryItem(
                  title: 'Radiology',
                  lapName: 'EL Borg',
                  testName: 'CPC',
                  dateTime: '27/4/2022, 1:43 PM',
                  notes: 'Optimal case',
                  img: 'assets/analysis.png'),
              const HistoryItem(
                  title: 'Lap Test',
                  lapName: 'EL Borg',
                  testName: 'CPC',
                  dateTime: '27/4/2022, 1:43 PM',
                  notes: 'Optimal case',
                  img: 'assets/analysis.png'),
            ],
          ),
        ),
      ),
    );
  }
}
