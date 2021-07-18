class Business {
  String description;
  String id;
  String image;
  String name;

  Business({this.description, this.id, this.image, this.name});

  Business.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    return data;
  }
}
