import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/models/customer.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/models/notification.dart';
import 'package:double_up/models/transaction.dart';
import 'package:double_up/pages/transaction_list_page/transaction_list_page.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:double_up/singleton/user_singleton.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/transition.dart';
import 'package:double_up/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rxdart/rxdart.dart';

class RewardsBloc extends Bloc {
  CombineLatestStream combineLatestStream;
  BehaviorSubject<List<Transaction>> transactions = BehaviorSubject();
  BehaviorSubject<bool> loading = BehaviorSubject();

  RewardsBloc(BuildContext context) {
    combineLatestStream = CombineLatestStream.combine5(
        userSingleton.giftCards,
        userSingleton.notifications,
        userSingleton.currentUser,
        transactions,
        loading,
        (a, b, c, d, e) => RewardsBlocObject(
            giftCards: a,
            notifications: b,
            customer: c,
            transaction: d,
            loading: e));
    updateGiftCards(context);
    updateLoading(false);

    updateTransaction();
  }
  updateGiftCards(BuildContext context) async {
    List<GiftCard> cards = await userSingleton.giftCards.first;
    for (GiftCard obj in cards) {
      await precacheImage(CachedNetworkImageProvider(obj.logo), context);
    }
    userSingleton.updateGiftCards();
  }

  updateLoading(bool value) {
    loading.add(value);
  }

  updateTransaction() async {
    Customer currentUser = await userSingleton.currentUser.first;
    List<Transaction> transaction =
        await Repository.getTransactionHistory(currentUser.id);
    this.transactions.add(transaction);
  }

  redeemQrCode(BuildContext context) async {
    var result = await BarcodeScanner.scan();
    updateLoading(true);

    Map<String, dynamic> redeemed =
        await Repository.redeemPoints(result.rawContent);
    if (redeemed != null) {
      if (redeemed["redeemed"] == true) {
        await userSingleton.updateCurrentUser(UserSingleton.userId);
        await updateTransaction();
        // userSingleton.incrementBalance(redeemed["price"]);
        sendNotification(
            message: "Your balance has been updated.",
            context: context,
            icon: FontAwesome5Solid.dollar_sign,
            color: Colors.green);
      } else {
        sendNotification(
            message: redeemed["redeemed"],
            context: context,
            icon: Icons.error,
            color: Constant.red);
      }
    }
    updateLoading(false);
  }

  changePage() async {
    Utils.changeNavigationBarPage(userSingleton.globalKey, 1);
  }

  openRedeemList(BuildContext context) async {
    Customer currentUser = await userSingleton.currentUser.first;

    Navigator.of(context, rootNavigator: true)
        .push(createRoute(TransactionListPage(
      function: Repository.getTransactionHistory(currentUser.id),
      title: "Redeem History",
    )));
  }

  dispose() {
    transactions.close();
    loading.close();
  }
}

class RewardsBlocObject {
  List<GiftCard> giftCards;
  List<AppNotifications> notifications;
  bool loading;

  List<Transaction> transaction;
  Customer customer;
  RewardsBlocObject(
      {this.giftCards,
      this.customer,
      this.notifications,
      this.transaction,
      this.loading});
}
