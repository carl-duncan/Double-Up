class AppNotifications {
  String id;
  String location;
  String message;
  bool read;

  AppNotifications({this.id, this.location, this.message, this.read});

  AppNotifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
    message = json['message'];
    read = json['read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['location'] = this.location;
    data['message'] = this.message;
    data['read'] = this.read;
    return data;
  }
}
