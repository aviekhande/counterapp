import 'package:counterapp/features/product_screen%20/data/models/getproduct_model/getproduct_model.dart';
import 'package:counterapp/features/product_screen%20/domain/repositories/product_repository.dart';

class ApiServiceRepoImp extends ApiServiceRepo {
  @override
  Future<List<Product>> getProductData() {
    throw UnimplementedError();
  }
}
