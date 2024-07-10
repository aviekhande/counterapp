import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counterapp/features/product_details/data/models/getproduct_model/getproduct_model.dart';

import '../features/auth/domain/usecases/sessioncontroller.dart';

class ProductRepo {
  List<Product> favlist = [];
  List<Product> addProduct(Product model) {
    favlist.add(model);
    addData();
    return favlist;
  }

  void addData() async {
    await FirebaseFirestore.instance
        .collection("wishlist")
        .doc(SessionController().userId)
        .set({
      "data": favlist
          .map((e) => Product(
                id: e.id,
                title: e.title,
                price: e.price,
                description: e.description,
                category: e.category,
                image: e.image,
                rating: e.rating,
              ).toJson())
          .toList()
    });
  }

  List<Product> removeProduct(int? id) {
    favlist.removeWhere((element) => element.id == id);
    addData();
    return favlist;
  }

  bool isWishlist(Product model) {
    return favlist.remove(model);
  }
}
