class Category {
  int code;
  String family;
  String id;
  String image;
  String name;

  Category({this.code, this.family, this.id, this.image, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    family = json['family'];
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['family'] = this.family;
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    return data;
  }
}
