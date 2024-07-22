import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counterapp/features/auth/domain/usecases/sessioncontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
   final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  // dont't gorget to add firebasea auth and google sign in package
  Future<bool> signInWithGoogle() async {
    try {
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await auth.signInWithCredential(authCredential);
        SessionController().userId = auth.currentUser?.uid;
        log("${auth.currentUser}");
      }
      if (auth.currentUser != null) {
        try {
      DocumentSnapshot docSnapshot = await _fireStore.collection("users").doc(auth.currentUser?.uid).get();
      if(!docSnapshot.exists){
         await _fireStore.collection("users").doc(auth.currentUser?.uid).set({
          'name':googleSignInAccount!.displayName ,
          'uid': auth.currentUser?.uid,
          'email': googleSignInAccount.email,
          "image": "",
          "mobile": ""
        });
      }

    } catch (e) {
      print('Error checking document: $e');
      return false;
    }
       
        return true;
        
      }

      return false;
    } on FirebaseAuthException {
      return false;
    }
  }

// for sign out
  googleSignOut() async {
    await googleSignIn.signOut();
    auth.signOut();
  }
}
