import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class GetProducts {
  Future getProductData() async {
    try {
      var url = Uri.parse('https://fakestoreapi.com/products');
      var response = await http.get(url);
      var productList = await (jsonDecode(response.body));
      log("$productList");
      return productList;
    } catch (e) {
      log("$e");
    }
  }
}
