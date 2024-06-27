part of 'wishlist_bloc.dart';

sealed class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}
class WishListRemove extends WishlistEvent{
 final int? id;
 const WishListRemove(this.id);
}
// ignore: must_be_immutable
class WishListAdd extends WishlistEvent{
  final Product product;

  const WishListAdd(this.product);
}
