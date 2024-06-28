part of 'wishlist_bloc.dart';

sealed class WishlistState  {
  
}

final class WishlistInitial extends WishlistState {}

final class WishlistLoaded extends WishlistState{ 
  final List<Product> product;
  WishlistLoaded(this.product);
}
