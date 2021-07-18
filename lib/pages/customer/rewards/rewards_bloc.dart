import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/repositories/blinksky_repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class RewardsBloc extends Bloc {
  BehaviorSubject<List<GiftCard>> giftCards = BehaviorSubject();

  RewardsBloc(BuildContext context) {
    updateGiftCards(context);
  }

  updateGiftCards(BuildContext context) async {
    List<GiftCard> cards = await BlinkSkyRepository.getCatalog();
    for (GiftCard obj in cards) {
      await precacheImage(CachedNetworkImageProvider(obj.logo), context);
    }
    giftCards.add(cards);
  }

  dispose() {
    giftCards.close();
  }
}
