import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counterapp/features/profile_details/presentation/pages/profil_screen.dart';

import '../../auth/domain/usecases/sessioncontroller.dart';

Future<DocumentSnapshot?> getUserData() async {
  log("${SessionController().userId}>>>>>>>>>>>>>>>>>>>>>>>>>>");
  await FirebaseFirestore.instance
      .collection("users")
      .doc(SessionController().userId)
      .get()
      .then((value) {
    docSnap = value;
  });
  // nameController.text = docSnap?['name'];
  // numberController.text = docSnap?['mobile'];
  // emailController.text = docSnap?['email'];
  // imageUrl = docSnap?['image'];
  // setState(() {});
  //  User user =U?ser.fromJson(!docSnap);
  return docSnap;
}
