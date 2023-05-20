import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraqi_project_graduation/views/screens/doc_screens/patient_list_screen.dart';
import 'package:eraqi_project_graduation/views/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CHeckQrScreen extends StatefulWidget {
  const CHeckQrScreen(
      {super.key,
      required this.name,
      required this.docEmail,
      required this.place});
  final String name;
  final String docEmail;
  final String place;
  @override
  State<CHeckQrScreen> createState() => _CHeckQrScreenState();
}

class _CHeckQrScreenState extends State<CHeckQrScreen> {
  Map<String, String> patient = {};
  String? searchedPatient;
  bool isLoading = false;
  getPatientData() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('Patients')
        .where('Id', isEqualTo: result!.code)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        patient[element['Id']] = element['uid'];
        searchedPatient = element['uid'];
      });
    });
  }

  findPatient() async {
    await getPatientData();
    if (patient.containsKey(result!.code)) {
      //   serachedPatient = patient[id]!;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PatientListScreen(
              uid: patient[result!.code]!,
              name: widget.name,
              docEmail: widget.docEmail,
              place: widget.place,
            ),
          ));
    } else {
      Fluttertoast.showToast(
          msg:  'patient not found',
          //'Patint not found',
          backgroundColor: Colors.black,
          toastLength: Toast.LENGTH_LONG);
    }
  }
  @override
  
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  @override
  void dispose() {
    qrViewController!.dispose();
    super.dispose();
  }
  QRViewController? qrViewController;
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Check Qr Code',
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: QRView(
                overlay: QrScannerOverlayShape(borderRadius: BorderSide.strokeAlignCenter),
                key: qrKey,
                onQRViewCreated: (p0) {
                  qrViewController = p0;
                  p0.scannedDataStream.listen((event) {
                    setState(() {
                      result = event;
                    });
                    if (result != null && result!.code!.isNotEmpty) {
                      result!.code != searchedPatient;
                      findPatient();
                    }
                  });
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: (result != null)
                    ? Text(' Data: ${result!.code}')
                    : const Text('Scan a code'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
