import 'package:double_up/models/product.dart';

import 'business.dart';
import 'customer.dart';

class Transaction {
  Business business;
  Customer customer;
  int date;
  double points;
  String id;
  List<Product> products;
  List<String> quantity;
  bool redeemed;

  Transaction(
      {this.business,
      this.customer,
      this.date,
      this.points,
      this.id,
      this.products,
      this.quantity,
      this.redeemed});

  Transaction.fromJson(Map<String, dynamic> json) {
    business = json['business'] != null
        ? new Business.fromJson(json['business'])
        : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    date = json['date'];
    points = json['points'];
    id = json['id'];
    if (json['products'] != null) {
      products = new List<Product>();
      json['products'].forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }
    quantity = json['quantity'].cast<String>();
    redeemed = json['redeemed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.business != null) {
      data['business'] = this.business.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    data['date'] = this.date;
    data['points'] = this.points;
    data['id'] = this.id;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['quantity'] = this.quantity;
    data['redeemed'] = this.redeemed;
    return data;
  }
}
