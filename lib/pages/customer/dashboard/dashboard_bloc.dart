import 'package:double_up/models/category.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/repositories/blinksky_repository.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class DashboardBloc {
  BehaviorSubject<List<GiftCard>> giftCards = BehaviorSubject();
  BehaviorSubject<List<Category>> categories = BehaviorSubject();
  BehaviorSubject<List<Product>> products = BehaviorSubject();
  CombineLatestStream combineLatestStream;

  DashboardBloc(BuildContext context) {
    combineLatestStream = CombineLatestStream.combine3(
        giftCards,
        categories,
        products,
        (a, b, c) =>
            DashboardBlocObject(giftCards: a, category: b, products: c));
    updateGiftCards(context);
    updateCategories(context);
    updateProducts(context);
  }

  dispose() {
    giftCards.close();
    categories.close();
    products.close();
  }

  updateCategories(BuildContext context) async {
    List<Category> categories = await Repository.getCategories(context);
    this.categories.add(categories);
  }

  updateProducts(BuildContext context) async {
    List<Product> objects = await Repository.getProducts(context);
    this.products.add(objects);
  }

  updateGiftCards(BuildContext context) async {
    List<GiftCard> cards = await BlinkSkyRepository.getCatalog(context);

    giftCards.add(cards);
  }
}

class DashboardBlocObject {
  List<GiftCard> giftCards;
  List<Category> category;
  List<Product> products;
  DashboardBlocObject({this.giftCards, this.category, this.products});
}
