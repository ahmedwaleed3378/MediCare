import 'package:eraqi_project_graduation/views/theme.dart';
import 'package:flutter/material.dart';








class MessageLine extends StatelessWidget {
  const MessageLine(
      {Key? key,
      required this.sender,
      required this.text,
      required this.isCurrent})
      : super(key: key);
  final String? sender;
  final String? text;
  final bool isCurrent;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isCurrent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: const TextStyle(fontSize: 12, color: prmClr),
          ),
          Material(
            elevation: 5,
            borderRadius: isCurrent
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            color: isCurrent ? Colors.blue[800] : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '$text',
                style: TextStyle(
                    fontSize: 15,
                    color: isCurrent ? Colors.white : Colors.blue[800]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}










// class MessageWidget extends StatelessWidget {
//   MessageWidget(
//       {super.key,
//       required this.messageContent,
//       required this.sendedByPatient,
//       required this.sizeConfig});
//   final String messageContent;
//   final bool sendedByPatient;
//   final double sizeConfig;
//   TimeOfDay messageDate = TimeOfDay.now();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//        alignment: sendedByPatient ? Alignment.centerLeft : Alignment.centerRight,
//       width: SizeConfig.screenWidth * 0.5,
//       padding: const EdgeInsets.all(7),
//       decoration: BoxDecoration(
//         color: sendedByPatient ? Styles.themeColor : darkHeaderClr,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Card(
        
//         margin: sendedByPatient
//             ? EdgeInsets.only(right: sizeConfig * 0.4, left: sizeConfig * 0.1)
//             : EdgeInsets.only(left: sizeConfig * 0.4, right: sizeConfig * 0.1),
//         elevation: 10,
//         color: sendedByPatient ? Styles.themeColor : darkHeaderClr,
//         shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: Text(
//           messageContent,
//           overflow: TextOverflow.clip,
//           style: subtitleStyle.copyWith(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
