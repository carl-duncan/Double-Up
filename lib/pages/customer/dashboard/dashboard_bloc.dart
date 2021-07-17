import 'package:double_up/models/category.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/repositories/blinksky_repository.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class DashboardBloc {
  BehaviorSubject<List<GiftCard>> giftCards = BehaviorSubject();
  BehaviorSubject<List<Category>> categories = BehaviorSubject();
  CombineLatestStream combineLatestStream;

  DashboardBloc(BuildContext context) {
    combineLatestStream = CombineLatestStream.combine2(giftCards, categories,
        (a, b) => DashboardBlocObject(giftCards: a, category: b));
    updateGiftCards(context);
    updateCategories(context);
  }

  dispose() {
    giftCards.close();
    categories.close();
  }

  updateCategories(BuildContext context) async {
    List<Category> categories = await Repository.getCategories(context);
    this.categories.add(categories);
  }

  updateGiftCards(BuildContext context) async {
    List<GiftCard> cards = await BlinkSkyRepository.getCatalog(context);

    giftCards.add(cards);
  }
}

class DashboardBlocObject {
  List<GiftCard> giftCards;
  List<Category> category;

  DashboardBlocObject({this.giftCards, this.category});

  DashboardBlocObject.fromJson(Map<String, dynamic> json) {
    giftCards = json['giftCards'].cast<String>();
    category = json['Category'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['giftCards'] = this.giftCards;
    data['Category'] = this.category;
    return data;
  }
}
