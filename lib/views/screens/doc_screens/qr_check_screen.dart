import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../theme.dart';

class QrCheckScreen extends StatelessWidget {
  const QrCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: prmClr,
          title: Text(
            ' Profile',
            style: headingStyle,
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.person),
            )
          ],
        ),
        backgroundColor: bgClr,
        body: Center(
          child: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Scan QR Code',
                    style: titleStyle,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  QrImage(
                    data: "ahmed waleed 12335458489",
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ],
              )),
        ));
  }
}
