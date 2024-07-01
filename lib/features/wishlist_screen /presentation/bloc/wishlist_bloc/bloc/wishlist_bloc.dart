import 'dart:developer';
import 'package:counterapp/core/static.dart';
import 'package:counterapp/features/product_screen%20/data/models/getproduct_model/getproduct_model.dart';
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
    final currentState = state;
    emit(WishlistLoaded(productrepo.addProduct(event.product)));
    if (currentState is WishlistLoaded) {}
  }

  void removeWishList(WishListRemove event, Emitter<WishlistState> emit) {
    final currentState = state;
    if (currentState is WishlistLoaded) {
      if (currentState.product.length != 1) {
        emit(WishlistLoaded(productrepo.removeProduct(event.id)));
      } else {
        emit(WishlistInitial());
      }
    }
  }

  @override
  WishlistState? fromJson(Map<String, dynamic> json) {
    try {
      if (json['data'] != null && (json['data'] as List<dynamic>).isNotEmpty) {
        List<Product> products = (json['data'] as List)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList();
        productrepo.favlist = products;
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
      productrepo.favlist =
          aa["data"]!.map((e) => Product.fromJson(e)).toList();
      return aa;
    }
    return {'data': []};
  }

}
