
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
  WishlistLoaded? fromJson(Map<String, dynamic> json) {
    Product pro=Product.fromJson(json);
    return WishlistLoaded([pro]);

  }
  
  @override
  Map<String, dynamic>? toJson(WishlistState state) {
    return {"":""};
  }
}
