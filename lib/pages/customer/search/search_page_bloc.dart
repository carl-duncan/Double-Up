import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/models/business.dart';
import 'package:double_up/models/category.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/models/notification.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SearchPageBloc extends Bloc {
  CombineLatestStream combineLatestStream;
  BehaviorSubject<List<Product>> products = BehaviorSubject();
  TextEditingController controller = TextEditingController();
  BehaviorSubject<List<Business>> businesses = BehaviorSubject();

  SearchPageBloc(BuildContext context) {
    combineLatestStream = CombineLatestStream.combine5(
        userSingleton.giftCards,
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
    updateGiftCards(context, "");
    updateProducts(context, "");
    updateBusinesses(context);
  }

  updateGiftCards(BuildContext context, String search) async {
    List<GiftCard> cards = await userSingleton.giftCards.first;
    for (GiftCard obj in cards) {
      await precacheImage(CachedNetworkImageProvider(obj.logo), context);
    }
    cards.removeWhere((element) => !element.caption.contains(search));
    userSingleton.updateGiftCards();
  }

  updateBusinesses(BuildContext context) async {
    List<Business> objects = await Repository.getBusinesses();
    for (Business obj in objects) {
      await precacheImage(
          CachedNetworkImageProvider(Repository.s3 + obj.image), context);
    }
    this.businesses.add(objects);
  }

  dispose() {
    products.close();
    controller.dispose();
    businesses.close();
  }

  updateProducts(BuildContext context, String search) async {
    List<Product> objects = await Repository.searchProducts(search);
    for (Product obj in objects) {
      await precacheImage(
          CachedNetworkImageProvider(Repository.s3 + obj.images.first),
          context);
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
