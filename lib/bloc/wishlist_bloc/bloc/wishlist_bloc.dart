import 'dart:developer';
import 'package:counterapp/model/getproduct_model/getproduct_model.dart';
import 'package:counterapp/view/static.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends HydratedBloc<WishlistEvent, WishlistState> {
  final ProductRepo productrepo;
  WishlistBloc({required this.productrepo}) : super(WishlistInitial()) {
    on<WishListAdd>(addWishList);
    on<WishListRemove>(removeWishList);
  }
  void addWishList(WishListAdd event, Emitter<WishlistState> emit) {
    log("In WishlistLoaded");
    emit(WishlistLoaded(productrepo.addProduct(event.product)));
  }

  void removeWishList(WishListRemove event, Emitter<WishlistState> emit) {
    emit(WishlistLoaded(productrepo.removeProduct(event.id)));
  }

  @override
  WishlistState? fromJson(Map<String, dynamic> json) {
    try {
      if (json['data'] != null && (json['data'] as List<dynamic>).isNotEmpty) {
        List<Product> products = (json['data'] as List)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList();
        print("${products.length}@@@@@@@");
        ProductRepo().favlist=products;
        return WishlistLoaded(products);
      }
      return WishlistInitial();
    } catch (e) {
      log("Error in fromJson: $e");
      return WishlistInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(WishlistState state) {
    if (state is WishlistLoaded) {
      var aa = {'data': state.product.map((e) => e.toJson()).toList()};
      print("$aa");
      return aa;
    }
    return {'data': []};
  }
}
