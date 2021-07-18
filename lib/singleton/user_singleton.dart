import 'package:double_up/models/category.dart';
import 'package:double_up/models/customer.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/models/notification.dart';
import 'package:double_up/repositories/blinksky_repository.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:rxdart/rxdart.dart';

class UserSingleton {
  static final UserSingleton _singleton = UserSingleton._internal();
  BehaviorSubject<List<Category>> categories = BehaviorSubject();
  BehaviorSubject<List<AppNotifications>> notifications = BehaviorSubject();
  BehaviorSubject<Customer> currentUser = BehaviorSubject();
  BehaviorSubject<List<GiftCard>> giftCards = BehaviorSubject();

  static String userId = "36fe4922-3792-4b92-8cfd-86f9eb20dfff";

  updateCategories() async {
    List<Category> categories = await Repository.getCategories();
    this.categories.add(categories);
  }

  updateCurrentUser() async {
    Customer customer = await Repository.getUser(userId);
    customer.favCardsResolved = await resolveCard(customer.favCards);
    currentUser.add(customer);
  }

  resolveCard(List<int> beforeCards) async {
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
    updateCategories();
    updateNotifications();
    updateGiftCards();
    updateCurrentUser();
  }
}
