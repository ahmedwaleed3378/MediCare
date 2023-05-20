import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';
import '../theme.dart';
import '../widgets/message_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key,
      required this.patientUid,
      required this.docUid,
      required this.isPatient});
  final String patientUid;
  final String docUid;
  final bool isPatient;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isLoading = false;
  String? messageText;

  String patientName = '';
  final TextEditingController messagecontroller = TextEditingController();

  void getPatientData() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('Patients')
        .doc(widget.patientUid)
        .get()
        .then((DocumentSnapshot q) {
      patientName = q['fullname'];
      // docEmail = q['docEmail'];
      setState(() {
        isLoading = false;
      });
    });

    // medicalHistory = await getMedicalVisits();
  }

  @override
  void initState() {
    super.initState();

    getPatientData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                patientName,
                style: titleStyle.copyWith(color: Colors.white),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: prmClr,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 15, bottom: 10, top: 10),
              child: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.settings)),
            )
          ],
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: prmClr,
                ),
              )
            : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(
                              'chat/${widget.patientUid}${widget.docUid}/messages').orderBy('time')
                          .snapshots(),
                      builder: ((context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            return Container(
                              padding: const EdgeInsets.all(8),
                              child: snapshot.data!.docs[index]['sender'] == 'p'
                                  ? MessageLine(
                                      text: snapshot.data!.docs[index]['text'],
                                      sender: 'Patient',
                                      isCurrent:
                                          widget.isPatient ? true : false,
                                    )
                                  : MessageLine(
                                      text: snapshot.data!.docs[index]['text'],
                                      sender: 'Doctor',
                                      isCurrent:
                                          widget.isPatient ? false : true,
                                    ),
                            );
                          }),
                        );
                      }),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: TextField(
                        controller: messagecontroller,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write your message here...',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20)),
                        onChanged: ((value) {
                          messageText = value;
                        }),
                      )),
                      TextButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection(
                                    'chat/${widget.patientUid}${widget.docUid}/messages')
                                .add({
                              'text': messageText,
                              'sender': widget.isPatient ? 'p' : 'd',
                              'time': FieldValue.serverTimestamp()
                            });
                            messagecontroller.clear();
                            FocusScope.of(context).unfocus();
                          },
                          child: const Text('send',
                              style: TextStyle(
                                  color: prmClr,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)))
                    ],
                  ),
                ],
              ));}
      
  
}
