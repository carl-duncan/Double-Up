import 'package:double_up/models/category.dart';
import 'package:double_up/models/customer.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/models/notification.dart';
import 'package:double_up/repositories/blinksky_repository.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class UserSingleton {
  static final UserSingleton _singleton = UserSingleton._internal();
  BehaviorSubject<List<Category>> categories = BehaviorSubject();
  BehaviorSubject<List<AppNotifications>> notifications = BehaviorSubject();
  BehaviorSubject<Customer> currentUser = BehaviorSubject();
  BehaviorSubject<List<GiftCard>> giftCards = BehaviorSubject();
  GlobalKey globalKey = new GlobalKey(debugLabel: 'app_bar');

  static String userId;

  updateCategories() async {
    List<Category> categories = await Repository.getCategories();
    this.categories.add(categories);
  }

  updateCurrentUser(String id) async {
    Customer customer = await Repository.getUser(id);
    customer.cardsResolved = await resolveCards(customer.cards);
    customer.favCardsResolved = await resolveCards(customer.favCards);
    currentUser.add(customer);
  }

  initStreams(String id) async {
    print("UserSingleton.init");
    if (currentUser.isClosed ||
        notifications.isClosed ||
        giftCards.isClosed ||
        categories.isClosed ||
        currentUser == null ||
        notifications == null ||
        giftCards == null ||
        categories == null) {
      currentUser = BehaviorSubject();
      notifications = BehaviorSubject();
      giftCards = BehaviorSubject();
      categories = BehaviorSubject();
    }
    updateCategories();
    updateNotifications();
    updateGiftCards();
    updateCurrentUser(id);
  }

  incrementBalance(num increment) async {
    Customer customer = await currentUser.first;
    customer.balance += increment;
    currentUser.add(customer);
  }

  resolveCards(List<int> beforeCards) async {
    await updateGiftCards();
    List<GiftCard> resolved = [];
    List<GiftCard> cards = await giftCards.first;

    for (int i in beforeCards) {
      for (GiftCard obj in cards) {
        if (obj.code == i.toString()) {
          resolved.add(obj);
        }
      }
    }
    return resolved;
  }

  updateGiftCards() async {
    List<GiftCard> cards = await BlinkSkyRepository.getCatalog();
    giftCards.add(cards);
  }

  updateNotifications() async {
    List<AppNotifications> notifications =
        await Repository.getNotifications(userId);
    this.notifications.add(notifications);
  }

  dispose() {
    print("UserSingleton.dispose");
    categories.close();
    currentUser.close();
    notifications.close();
    giftCards.close();
  }

  factory UserSingleton() {
    return _singleton;
  }

  UserSingleton._internal() {
    // initStreams();
  }
}
