import 'package:double_up/models/gift_card.dart';
import 'package:double_up/models/product.dart';

class Customer {
  String id;
  int balance;
  List<int> cards;
  List<int> favCards;
  List<GiftCard> favCardsResolved = [];
  List<Product> favProducts;
  String name;
  String picture;
  List<String> prefs;

  Customer(
      {this.id,
      this.balance,
      this.cards,
      this.favCards,
      this.favProducts,
      this.name,
      this.picture,
      this.prefs});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    balance = json['balance'];
    if (json['cards'] != null) cards = json['cards'].cast<int>();
    if (json['fav_cards'] != null) favCards = json['fav_cards'].cast<int>();
    if (json['fav_products'] != null) {
      favProducts = new List<Product>();
      json['fav_products'].forEach((v) {
        favProducts.add(new Product.fromJson(v));
      });
    }
    name = json['name'];
    picture = json['picture'];
    if (json['prefs'] != null) prefs = json['prefs'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['balance'] = this.balance;
    data['cards'] = this.cards;
    data['fav_cards'] = this.favCards;
    if (this.favProducts != null) {
      data['fav_products'] = this.favProducts.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['picture'] = this.picture;
    data['prefs'] = this.prefs;
    return data;
  }
}
