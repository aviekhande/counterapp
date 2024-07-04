import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counterapp/features/auth/domain/usecases/sessioncontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthMethod {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  // SignUp User

  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        // register user in auth with email and password
        UserCredential cred = await _auth
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((user) {
          return user;
        });

        // add user to your  fireStore database
        await _fireStore.collection("users").doc(cred.user!.uid).set({
          'name': name,
          'uid': cred.user!.uid,
          'email': email,
        });
        FirebaseFirestore.instance
            .collection("profile")
            .doc(SessionController().userId)
            .set({"name": name, "email": email, "mobile": ""});

        res = "success";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logIn user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) {
          SessionController().userId = value.user!.uid.toString();
        });
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // for signOut
  signOut() async {
    await _auth.signOut();
  }
}
