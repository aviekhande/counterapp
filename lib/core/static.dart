import 'package:counterapp/features/product_details/data/models/getproduct_model/getproduct_model.dart';

class ProductRepo {
  List<Product> favlist = [];
  List<Product> addProduct(Product model) {
    favlist.add(model);
    return favlist;
  }

  List<Product> removeProduct(int? id) {
    favlist.removeWhere((element) => element.id == id);
    return favlist;
  }

  bool isWishlist(Product model) {
    return favlist.remove(model);
  }
}
