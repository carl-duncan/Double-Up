import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/models/customer.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/models/notification.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class RewardsBloc extends Bloc {
  CombineLatestStream combineLatestStream;
  RewardsBloc(BuildContext context) {
    combineLatestStream = CombineLatestStream.combine3(
        userSingleton.giftCards,
        userSingleton.notifications,
        userSingleton.currentUser,
        (a, b, c) =>
            RewardsBlocObject(giftCards: a, notifications: b, customer: c));
    updateGiftCards(context);
  }
  updateGiftCards(BuildContext context) async {
    List<GiftCard> cards = await userSingleton.giftCards.first;
    for (GiftCard obj in cards) {
      await precacheImage(CachedNetworkImageProvider(obj.logo), context);
    }
    userSingleton.updateGiftCards();
  }
}

class RewardsBlocObject {
  List<GiftCard> giftCards;
  List<AppNotifications> notifications;
  Customer customer;
  RewardsBlocObject({this.giftCards, this.customer, this.notifications});
}
