import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:flutter/material.dart';

class RewardsBloc extends Bloc {
  RewardsBloc(BuildContext context) {
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
