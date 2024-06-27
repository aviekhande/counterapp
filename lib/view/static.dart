import 'package:counterapp/model/getproduct_model/getproduct_model.dart';

class ProductRepo {
  List<Product> favlist = [];
  List<Product> addProduct(Product model) {
        print("$favlist>>>>>>>>>>>>>>>>>");

    favlist.add(model);
        print("$favlist<<<<<<<<<<<<");

    return favlist;
  }

  List<Product> removeProduct(int? id) {
     print("$favlist>>>>>>>>>>>>>>>>>");
    favlist.removeWhere((element) => element.id == id);
    return favlist;
  }
}
