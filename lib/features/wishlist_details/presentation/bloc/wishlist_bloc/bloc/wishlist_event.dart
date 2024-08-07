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

class WishListAdd extends WishlistEvent{
  final Product product;
  const WishListAdd(this.product);
}

class WishlistClicked extends WishlistEvent{
  final int id;
  const WishlistClicked(this.id);
}
class WishListfetch extends WishlistEvent{
  
}