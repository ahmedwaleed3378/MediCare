// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:eraqi_project_graduation/views/theme.dart';
import 'package:flutter/material.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem(
      {super.key,
      required this.title,
      required this.lapName,
      required this.testName,
      required this.dateTime,
      required this.notes,
      required this.img});
  final String title;
  final String lapName;
  final String testName;
  final String dateTime;
  final String notes;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(),
          color: white),
      child: Row(
        children: [
          Image.asset(img,),
       const   SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: titleStyle,
              ),
              Text(
                'Lap Name: ${lapName}',
                style: subtitleStyle,
                overflow: TextOverflow.clip,
              ),
              Text(
                'Test Name: ${testName}',
                style: subtitleStyle,overflow: TextOverflow.clip,
              ),
              Text(
                'Date & Time: ${dateTime}',
                style: subtitleStyle,overflow: TextOverflow.clip,
              ),
              Text(
                'Notes: ${notes}',
                style: subtitleStyle,overflow: TextOverflow.clip,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
