import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  UserCredential? userCredential ;
  Future<String> signUpUsers(
    String name,
    String email,
    String password,
    String phoneNumber,
    String nationalID,
    String address,
    String gender,
    String birthDate,
    String type,
  ) async {
    bool ok =false;
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firebaseFirestore
          .collection(type=='1'?'Patients':'Doctors')
          .doc(userCredential.user!.uid)
          .set({
        'email': email,
        'fullname': name,
        'Id': nationalID,
        'address': address,
        'birthDate': birthDate,
        'gender': gender,
        'type': type,
        'phoneNumber': phoneNumber,
        'uid':userCredential.user!.uid
      });

      return ok ?'false' : userCredential.user!.uid;
    } catch (e) {
      print(e.toString());
      return 'false';
    }
  }

  Future<UserCredential?> loginUsers(
    String email,
    String password,
  ) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
     userCredential =   await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);

        return userCredential;
      }
    } catch (e) {
      log(e.toString());
      return userCredential;
    }
  }
  void signOut()async{
    await _firebaseAuth.signOut();
  }
}
