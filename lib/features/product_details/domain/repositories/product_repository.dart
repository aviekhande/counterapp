import 'package:counterapp/features/product_details/data/models/getproduct_model/getproduct_model.dart';

abstract class ApiServiceRepo {
  Future<List<Product>> getProductData();
}
