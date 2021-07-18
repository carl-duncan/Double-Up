import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/models/category.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SearchPageBloc extends Bloc {
  CombineLatestStream combineLatestStream;
  BehaviorSubject<List<Product>> products = BehaviorSubject();
  TextEditingController controller = TextEditingController();

  SearchPageBloc(BuildContext context) {
    combineLatestStream = CombineLatestStream.combine3(
        userSingleton.giftCards,
        userSingleton.categories,
        products,
        (a, b, c) =>
            SearchPageBlocObject(giftCards: a, category: b, products: c));
    updateGiftCards(context, "");
    updateProducts(context, "");
  }

  updateGiftCards(BuildContext context, String search) async {
    List<GiftCard> cards = await userSingleton.giftCards.first;
    for (GiftCard obj in cards) {
      await precacheImage(CachedNetworkImageProvider(obj.logo), context);
    }
    cards.removeWhere((element) => !element.caption.contains(search));
    userSingleton.updateGiftCards();
  }

  dispose() {
    products.close();
    controller.dispose();
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
  List<Product> products;
  SearchPageBlocObject({this.giftCards, this.category, this.products});
}
