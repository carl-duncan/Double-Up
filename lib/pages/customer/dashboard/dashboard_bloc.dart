import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/models/business.dart';
import 'package:double_up/models/category.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/models/notification.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class DashboardBloc extends Bloc {
  CombineLatestStream combineLatestStream;
  BehaviorSubject<List<Product>> products = BehaviorSubject();
  BehaviorSubject<List<Business>> businesses = BehaviorSubject();

  DashboardBloc(BuildContext context) {
    combineLatestStream = CombineLatestStream.combine5(
        userSingleton.giftCards,
        userSingleton.categories,
        products,
        userSingleton.notifications,
        businesses,
        (a, b, c, d, e) => DashboardBlocObject(
            giftCards: a,
            category: b,
            products: c,
            notifications: d,
            business: e));
    updateGiftCards(context);
    updateProducts(context, null);
    updateBusinesses(context);
  }

  updateGiftCards(BuildContext context) async {
    List<GiftCard> cards = await userSingleton.giftCards.first;
    for (GiftCard obj in cards) {
      await precacheImage(CachedNetworkImageProvider(obj.logo), context);
    }
    userSingleton.updateGiftCards();
  }

  dispose() {
    products.close();
    businesses.close();
  }

  updateProducts(BuildContext context, Category category) async {
    List<Product> objects;
    if (category == null)
      objects = await Repository.getProducts();
    else
      objects = await Repository.getProductByCategory(category.id);
    for (Product obj in objects) {
      await precacheImage(
          CachedNetworkImageProvider(obj.images.first), context);
    }
    this.products.add(objects);
  }

  updateBusinesses(BuildContext context) async {
    List<Business> objects = await Repository.getBusinesses();
    for (Business obj in objects) {
      await precacheImage(CachedNetworkImageProvider(obj.image), context);
    }
    this.businesses.add(objects);
  }
}

class DashboardBlocObject {
  List<GiftCard> giftCards;
  List<Category> category;
  List<Business> business;
  List<Product> products;
  List<AppNotifications> notifications;
  DashboardBlocObject(
      {this.giftCards,
      this.category,
      this.products,
      this.notifications,
      this.business});
}
