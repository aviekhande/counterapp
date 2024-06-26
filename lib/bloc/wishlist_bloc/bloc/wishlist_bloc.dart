
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:counterapp/model/getproduct_model/getproduct_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends HydratedBloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishListAdd>(addWishList);

  }
  void addWishList(WishListAdd event, Emitter<WishlistState> emit){
    log("In WishlistLoaded");
    emit(WishlistLoaded(event.product));
  }
  
  @override
  WishlistState? fromJson(Map<String, dynamic> json) {
    try {
      if (json['data'] != null && (json['data'] as List<dynamic>).isNotEmpty) {
        List<Product> products = (json['data'] as List)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList();
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
      return {'data': state.product.map((e) => e.toJson()).toList()};
    }
    return {'data': []};
  }
}
