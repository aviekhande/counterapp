import 'package:counterapp/features/product_details/data/models/getproduct_model/getproduct_model.dart';
import 'package:counterapp/features/product_details/domain/repositories/product_repository.dart';

class ApiServiceRepoImp extends ApiServiceRepo {
  @override
  Future<List<Product>> getProductData() {
    throw UnimplementedError();
  }
}
