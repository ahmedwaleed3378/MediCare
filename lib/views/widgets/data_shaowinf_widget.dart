import 'package:eraqi_project_graduation/views/theme.dart';
import 'package:flutter/material.dart';
class DataShowing extends StatelessWidget {
  const DataShowing({super.key, required this.title, required this.info});
  final List<String> info;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
      //  padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: titleStyle,
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
            //    scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, index) => Text(
                  info[index],
                  textAlign: TextAlign.start,
                  style: subtitleStyle,
                ),
                itemCount: info.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
