import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/models/business.dart';
import 'package:double_up/models/category.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/models/notification.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/pages/product_list_page/product_list_page.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:double_up/utils/transition.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SearchPageBloc extends Bloc {
  CombineLatestStream combineLatestStream;
  BehaviorSubject<List<Product>> products = BehaviorSubject();
  TextEditingController controller = TextEditingController();
  BehaviorSubject<List<GiftCard>> cards = BehaviorSubject();

  BehaviorSubject<List<Business>> businesses = BehaviorSubject();

  SearchPageBloc(BuildContext context) {
    combineLatestStream = CombineLatestStream.combine5(
        cards,
        userSingleton.categories,
        products,
        userSingleton.notifications,
        businesses,
        (a, b, c, d, e) => SearchPageBlocObject(
            giftCards: a,
            category: b,
            products: c,
            notification: d,
            business: e));
    updateProducts(context, "");
    updateBusinesses(context, "");
    updateGiftCards(context, "");
  }

  updateGiftCards(BuildContext context, String search) async {
    List<GiftCard> results = [];
    List<GiftCard> allCards = await userSingleton.giftCards.first;

    for (GiftCard card in allCards) {
      if (card.caption.contains(search)) results.add(card);
    }
    this.cards.add(results);
  }

  updateBusinesses(BuildContext context, String search) async {
    List<Business> objects = await Repository.searchBusinesses(search, 3);
    for (Business obj in objects) {
      await precacheImage(CachedNetworkImageProvider(obj.image), context);
    }
    this.businesses.add(objects);
  }

  openProductList(BuildContext context) {
    Navigator.of(context, rootNavigator: true).push(createRoute(ProductListPage(
      function: Repository.searchProducts(controller.text, null),
      title: "Search Results",
    )));
  }

  dispose() {
    products.close();
    controller.dispose();
    cards.close();
    businesses.close();
  }

  clearSearch(BuildContext context) {
    controller.text = "";
    updateBusinesses(context, "");
    updateProducts(context, "");
    updateGiftCards(context, "");
  }

  updateProducts(BuildContext context, String search) async {
    List<Product> objects = await Repository.searchProducts(search, 3);
    for (Product obj in objects) {
      await precacheImage(
          CachedNetworkImageProvider(obj.images.first), context);
    }
    this.products.add(objects);
  }
}

class SearchPageBlocObject {
  List<GiftCard> giftCards;
  List<Category> category;
  List<Business> business;
  List<AppNotifications> notification;
  List<Product> products;
  SearchPageBlocObject(
      {this.giftCards,
      this.category,
      this.products,
      this.notification,
      this.business});
}
