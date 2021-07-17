import 'package:double_up/models/gift_card.dart';
import 'package:double_up/repositories/blinksky_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class DashboardBloc {
  BehaviorSubject<List<GiftCard>> giftCards = BehaviorSubject();

  DashboardBloc(BuildContext context) {
    updateGiftCards(context);
  }

  dispose() {
    giftCards.close();
  }

  updateGiftCards(BuildContext context) async {
    List<GiftCard> cards = await BlinkSkyRepository.getCatalog(context);

    giftCards.add(cards);
  }
}
