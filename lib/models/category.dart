class Category {
  int code;
  String family;
  String id;
  String color;
  String image;
  String name;

  Category(
      {this.code, this.family, this.id, this.image, this.name, this.color});

  Category.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    family = json['family'];
    id = json['id'];
    color = json["color"];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['family'] = this.family;
    data['id'] = this.id;
    data["color"] = this.color;
    data['image'] = this.image;
    data['name'] = this.name;
    return data;
  }
}
