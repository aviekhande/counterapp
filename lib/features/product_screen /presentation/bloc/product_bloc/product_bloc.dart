import 'package:counterapp/features/product_screen%20/data/models/getproduct_model/getproduct_model.dart';
import 'package:counterapp/main.dart';
import 'package:counterapp/features/product_screen%20/data/repositories/getproduct_api/getproduct_api.dart';
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
    List<Product> products = await getIt<GetProducts>().getProductData();
    emit(ProductLoaded(products));
  }
}
