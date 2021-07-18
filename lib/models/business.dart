import 'package:double_up/models/category.dart';

class Business {
  String description;
  String id;
  String image;
  Category category;
  String name;

  Business({this.description, this.id, this.image, this.name, this.category});

  Business.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    image = json['image'];
    if (json["category"] != null)
      category = Category.fromJson(json["category"]);
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    data['category'] = this.category;
    data['image'] = this.image;
    data['name'] = this.name;
    return data;
  }
}
