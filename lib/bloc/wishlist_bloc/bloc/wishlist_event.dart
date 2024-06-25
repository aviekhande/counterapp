part of 'wishlist_bloc.dart';

sealed class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}
// ignore: must_be_immutable
class WishListAdd extends WishlistEvent{
  final List product;

  const WishListAdd(this.product);
}
