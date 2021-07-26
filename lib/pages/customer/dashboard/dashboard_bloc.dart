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
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rxdart/rxdart.dart';

class DashboardBloc extends Bloc {
  CombineLatestStream combineLatestStream;
  BehaviorSubject<List<Product>> products = BehaviorSubject();
  BehaviorSubject<List<Business>> businesses = BehaviorSubject();
  BehaviorSubject<List<Category>> categories = BehaviorSubject();
  BehaviorSubject<int> categoryIndex = BehaviorSubject();

  DashboardBloc(BuildContext context) {
    combineLatestStream = CombineLatestStream.combine6(
        userSingleton.giftCards,
        categories,
        products,
        userSingleton.notifications,
        businesses,
        categoryIndex,
        (a, b, c, d, e, f) => DashboardBlocObject(
            giftCards: a,
            category: b,
            products: c,
            notifications: d,
            business: e,
            index: f));
    refreshStreams(context);
  }

  refreshStreams(BuildContext context) {
    updateGiftCards(context);
    updateProducts(context, null, null);
    updateBusinesses(context);
    updateCategories();
  }

  updateCategories() async {
    List<Category> categories = await userSingleton.categories.first;
    List<Category> newList = categories.toList();
    IconData iconData = FontAwesome5Solid.heart;
    categoryIndex.add(0);
    newList.insert(
        0,
        Category(
            name: "Recommended Products",
            image: null,
            id: "",
            family: iconData.fontFamily,
            code: iconData.codePoint));
    this.categories.add(newList);
  }

  updateGiftCards(BuildContext context) async {
    List<GiftCard> cards = await userSingleton.giftCards.first;
    for (GiftCard obj in cards) {
      await precacheImage(CachedNetworkImageProvider(obj.logo), context);
    }
    userSingleton.updateGiftCards();
  }

  openProductList(BuildContext context, Category category) {
    Navigator.of(context, rootNavigator: true).push(createRoute(ProductListPage(
      function: Repository.getProductByCategory(category.id, 3),
      title: category.name,
    )));
  }

  dispose() {
    products.close();
    businesses.close();
    categories.close();
    categoryIndex.close();
  }

  updateProducts(BuildContext context, Category category, int index) async {
    List<Product> objects;
    if (category == null || index == 0)
      objects = await Repository.getProducts(3);
    else
      objects = await Repository.getProductByCategory(category.id, 3);
    for (Product obj in objects) {
      await precacheImage(
          CachedNetworkImageProvider(obj.images.first), context);
    }
    if (index != null) this.categoryIndex.add(index);
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
  int index;
  List<AppNotifications> notifications;
  DashboardBlocObject(
      {this.giftCards,
      this.category,
      this.products,
      this.index,
      this.notifications,
      this.business});
}
