class BusinessType {
  String color;
  String id;
  String title;

  BusinessType({this.color, this.id, this.title});

  BusinessType.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
