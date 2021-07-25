import 'package:double_up/models/business_type.dart';

class Business {
  String description;
  String id;
  String image;
  num x;
  num y;
  String address;
  BusinessType category;
  String name;

  Business(
      {this.description,
      this.id,
      this.image,
      this.name,
      this.category,
      this.x,
      this.y,
      this.address});

  Business.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    x = json['x'];
    y = json['y'];
    address = json['address'];

    image = json['image'];
    if (json["category"] != null)
      category = BusinessType.fromJson(json["category"]);
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    data['x'] = this.x;
    data['y'] = this.y;
    data['address'] = this.address;
    data['category'] = this.category;
    data['image'] = this.image;
    data['name'] = this.name;
    return data;
  }
}
