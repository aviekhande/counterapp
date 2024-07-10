import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counterapp/features/product_details/data/models/getproduct_model/getproduct_model.dart';
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

Future<List<Product>> getWishlistData() async {
  List<Product> wishlist = [];
  await FirebaseFirestore.instance
      .collection("wishlist")
      .doc(SessionController().userId)
      .get()
      .then((value) {
    // log("${value["data"]}");
    docSnap = value;
  });
  // var x = jsonDecode(docSnap?["data"]);
  if (docSnap != null) {
    for (int i = 0; i < docSnap?["data"].length; i++) {
      wishlist.add(Product.fromJson(docSnap?["data"][i]));
    }
  }
  // for (int i = 0; i < docSnap?["data"].length; i++) {
  //   wishlist.add(Product.fromJson(docSnap?["data"][i]));
  // }
  // nameController.text = docSnap?['name'];
  // numberController.text = docSnap?['mobile'];
  // emailController.text = docSnap?['email'];
  // imageUrl = docSnap?['image'];
  // setState(() {});
  //  User user =U?ser.fromJson(!docSnap);
  return wishlist;
}
