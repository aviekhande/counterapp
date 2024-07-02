// import 'dart:developer';
// import 'package:counterapp/features/product_screen%20/domain/repositories/product_repository.dart';
// import 'package:http/http.dart' as http;
import 'package:counterapp/core/constants/constants.dart';
import 'package:counterapp/features/product_screen%20/data/models/getproduct_model/getproduct_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'getproduct_api.g.dart';

// ----> Using http
// class GetProducts {
//   Future<List<Product>> getProductData() async {
//     try {
//       var url = Uri.parse('https://fakestoreapi.com/products');
//       var response = await http.get(url);
//       final List productList = await (jsonDecode(response.body));
//       log("$productList");
//       List<Product> productList1 = [];
//       for (int i = 0; i < productList.length; i++) {
//         productList1.add(Product.fromJson(productList[i]));
//       }
//       return productList1;
//     } catch (e) {
//       log("$e");
//       throw Exception(e);
//     }
//   }
// }

// ----> using Dio
// class GetProducts {
//   // late List productList = [];
//   Future<List<Product>> getProductData() async {
//     late List productList = [];
//     try {
//       var url = 'https://fakestoreapi.com/products';
//       var response = await Dio().get(url);
//       //  List productList ;
//       productList.addAll(response.data);
//       List<Product> productList1 =
//           productList.map((e) => Product.fromJson(e)).toList();

//       //--> Using Loop
//       // for (int i = 0; i < productList.length; i++) {
//       //   productList1.add(Product.fromJson(productList[i]));
//       // }

//       return productList1;
//     } catch (e) {
//       log("$e");
//       throw Exception(e);
//     }
//   }
// } 

// ----> using Dio
@RestApi(baseUrl:productAPIBaseURL)
abstract class ApiService {
  factory ApiService(Dio dio,{String baseUrl}) = _ApiService;

  //--> Get Request 
  @GET('/products')
  Future<List<Product>> getProductData();
}