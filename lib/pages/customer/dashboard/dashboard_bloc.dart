import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/models/category.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class DashboardBloc extends Bloc {
  CombineLatestStream combineLatestStream;
  BehaviorSubject<List<Product>> products = BehaviorSubject();

  DashboardBloc(BuildContext context) {
    combineLatestStream = CombineLatestStream.combine3(
        userSingleton.giftCards,
        userSingleton.categories,
        products,
        (a, b, c) =>
            DashboardBlocObject(giftCards: a, category: b, products: c));
    updateGiftCards(context);
    updateProducts(context);
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
  }

  updateProducts(BuildContext context) async {
    List<Product> objects = await Repository.getProducts();
    for (Product obj in objects) {
      await precacheImage(
          CachedNetworkImageProvider(Repository.s3 + obj.images.first),
          context);
    }
    this.products.add(objects);
  }
}

class DashboardBlocObject {
  List<GiftCard> giftCards;
  List<Category> category;
  List<Product> products;
  DashboardBlocObject({this.giftCards, this.category, this.products});
}
