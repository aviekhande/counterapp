import 'package:counterapp/features/product_screen%20/data/models/getproduct_model/getproduct_model.dart';

abstract class ApiServiceRepo {
  Future<List<Product>> getProductData();
}
