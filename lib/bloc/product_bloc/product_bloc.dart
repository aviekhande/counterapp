import 'package:counterapp/model/getproduct_model/getproduct_model.dart';
import 'package:counterapp/repository/getproduct_api/getproduct_api.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

// class ProductBloc extends HydratedBloc<ProductEvent, ProductState> {
//   ProductBloc() : super(ProductInitial()) {
//     on<ProductEvent>(_onfetchpost);
//   }
//   void _onfetchpost(ProductEvent event, Emitter<ProductState> emit) async {
//     emit(ProductLoading());
//     List products = await GetProducts().getProductData();
//     List<Product> products1 = [];
//     emit(ProductLoading());
//     for (int i = 0; i < products.length; i++) {
//       products1.add(Product.fromJson(products[i]));
//     }
//     emit(ProductLoaded(products1));
//   }

//   @override
//   ProductLoaded? fromJson(Map<String, dynamic> json) {
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic>? toJson(ProductState state) {
//     throw UnimplementedError();
//   }
// }
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>(_onfetchpost);
  }
  void _onfetchpost(ProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    List products = await GetProducts().getProductData();
    List<Product> products1 = [];
    emit(ProductLoading());
    for (int i = 0; i < 4; i++) {
      products1.add(Product.fromJson(products[i]));
    }
    emit(ProductLoaded(products1));
  }
}
