import 'business.dart';
import 'category.dart';

class Product {
  Business business;
  Category category;
  String description;
  String id;
  List<String> images;
  String name;
  String price;
  double threshold;

  Product(
      {this.business,
      this.category,
      this.description,
      this.id,
      this.images,
      this.name,
      this.price,
      this.threshold});

  Product.fromJson(Map<String, dynamic> json) {
    business = json['business'] != null
        ? new Business.fromJson(json['business'])
        : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    description = json['description'];
    id = json['id'];
    images = json['images'].cast<String>();
    name = json['name'];
    price = json['price'];
    threshold = json['threshold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.business != null) {
      data['business'] = this.business.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['description'] = this.description;
    data['id'] = this.id;
    data['images'] = this.images;
    data['name'] = this.name;
    data['price'] = this.price;
    data['threshold'] = this.threshold;
    return data;
  }
}
