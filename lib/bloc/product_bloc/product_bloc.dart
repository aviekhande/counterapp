import 'package:counterapp/model/getproduct_model/getproduct_model.dart';
import 'package:counterapp/repository/getproduct_api/getproduct_api.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>(_onfetchpost);
  }
  void _onfetchpost(ProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    List<Product> products = await GetProducts().getProductData();
    emit(ProductLoaded(products));
  }
}
