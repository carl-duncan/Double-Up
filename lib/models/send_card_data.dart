class SendCardData {
  String email;
  int amount;
  String message;
  String card;
  String profile;

  SendCardData(
      {this.email, this.amount, this.message, this.card, this.profile});

  SendCardData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    amount = json['amount'];
    message = json['message'];
    card = json['card'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['amount'] = this.amount;
    data['message'] = this.message;
    data['card'] = this.card;
    data['profile'] = this.profile;
    return data;
  }
}
