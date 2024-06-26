part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}
final class ProductLoading extends ProductState{}
final class ProductLoaded extends ProductState{
  final List product;

  const ProductLoaded(this.product);
}
