import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Product extends Equatable {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  Product(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating,
      required ratingCount});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'].toDouble();
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['category'] = category;
    data['image'] = image;
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    return data;
  }
  
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
class Rating extends Equatable{
  double? rate;
  int? count;

  Rating({this.rate, count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate'].toDouble();
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['rate'] = rate;
    data['count'] = count;
    return data;
  }
  @override
  List<Object?> get props => [
        rate,
        count,
      ];
}
