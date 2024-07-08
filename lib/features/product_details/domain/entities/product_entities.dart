import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
//-> like model class
@JsonSerializable()
// ignore: must_be_immutable
class Product extends Equatable {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });
 

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        description,
        category,
        image,
        rating,
      ];
}

// ignore: must_be_immutable
class Rating extends Equatable {
  double? rate;
  int? count;

  Rating({this.rate, count});

  @override
  List<Object?> get props => [
        rate,
        count,
      ];
}
