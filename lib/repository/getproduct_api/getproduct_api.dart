import 'dart:convert';
import 'dart:developer';
import 'package:counterapp/model/getproduct_model/getproduct_model.dart';
import 'package:http/http.dart' as http;

class GetProducts {
  Future<List<Product>> getProductData() async {
    try {
      var url = Uri.parse('https://fakestoreapi.com/products');
      var response = await http.get(url);
      final List productList = await (jsonDecode(response.body));
      log("$productList");
      List<Product> productList1 = [];
      for (int i = 0; i < productList.length; i++) {
        productList1.add(Product.fromJson(productList[i]));
      }
      return productList1;
    } catch (e) {
      log("$e");
      throw Exception(e);
    }
  }
}
