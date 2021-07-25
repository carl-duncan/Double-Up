import 'business.dart';
import 'customer.dart';

class Transaction {
  String id;
  Business business;
  double points;
  int date;
  Customer customer;
  List<String> quantity;
  bool redeemed;

  Transaction(
      {this.id,
      this.business,
      this.points,
      this.date,
      this.customer,
      this.quantity,
      this.redeemed});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    business = json['business'] != null
        ? new Business.fromJson(json['business'])
        : null;
    points = json['points'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    quantity = json['quantity'].cast<String>();
    date = json['date'];
    redeemed = json['redeemed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.business != null) {
      data['business'] = this.business.toJson();
    }
    data['points'] = this.points;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    data['quantity'] = this.quantity;
    data["date"] = this.date;
    data['redeemed'] = this.redeemed;
    return data;
  }
}
