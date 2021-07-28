import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/models/customer.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/models/send_card_data.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:double_up/singleton/user_singleton.dart';
import 'package:double_up/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rxdart/rxdart.dart';

class CardViewBloc extends Bloc {
  BehaviorSubject<String> value = BehaviorSubject();
  BehaviorSubject<bool> loading = BehaviorSubject();
  CombineLatestStream combineLatestStream;
  List<String> amounts;
  TextEditingController email = TextEditingController();
  TextEditingController message = TextEditingController();

  CardViewBloc(String initialValue) {
    combineLatestStream =
        CombineLatestStream([value, userSingleton.currentUser, loading], (a) {
      return CardViewBlocObject(value: a[0], user: a[1], loading: a[2]);
    });
    value.add(initialValue);
    updateLoading(false);
    message.text = "Thank you for Using Double Up!";
  }

  updateValue(String value) {
    this.value.add(value);
  }

  updateLoading(bool value) {
    loading.add(value);
  }

  addToFav(GiftCard card, BuildContext context) async {
    Customer user = await userSingleton.currentUser.first;
    bool condition = !(user.favCards.contains(num.parse(card.code)));
    if (condition) {
      user.favCards.add(num.parse(card.code));
      sendNotification(
          message: "Added ${card.caption} Card",
          context: context,
          icon: FontAwesome5Solid.heart,
          color: Constant.green);
      user.favCardsResolved.add(card);
    } else {
      sendNotification(
          message: "Removed ${card.caption} Card",
          context: context,
          icon: FontAwesome5Solid.heart,
          color: Constant.secondary);
      user.favCards.removeWhere((val) {
        if (val == num.parse(card.code)) return true;
        return false;
      });
      user.favCardsResolved.removeWhere((GiftCard val) {
        if (val.code == card.code) return true;
        return false;
      });
    }
    userSingleton.currentUser.add(user);
    await Repository.updateFavCards(user.favCards, user.id);
    // await userSingleton.updateCurrentUser(user.id);
  }

  sendGiftCard(BuildContext cntxt, GiftCard card, String value) async {
    Customer user = await userSingleton.currentUser.first;
    bool isValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email.text);
    if (isValid) {
      Customer customer = await userSingleton.currentUser.first;

      if (customer.balance > num.parse(value)) {
        updateLoading(true);
        SendCardData cardData = SendCardData(
          email: email.text,
          message: message.text,
          amount: num.parse(value),
          profile: user.id,
          card: card.code,
        );

        await Repository.sendGiftCard(cardData);
        sendNotification(
            message: "Your Gift Card has been sent",
            context: cntxt,
            icon: FontAwesome5Solid.gift,
            color: Constant.secondary);
        user.balance -= num.parse(value);
        userSingleton.currentUser.add(user);

        updateLoading(false);
      } else {
        showDialog(
            context: cntxt,
            builder: (BuildContext context) => CupertinoAlertDialog(
                  title: new Text("Add Funds"),
                  content: new Text(
                      "You need ${(num.parse(value) - customer.balance).toStringAsFixed(2)} to buy this gift card. Would you like to pay the difference?"),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      child: Text("Yes"),
                      onPressed: () async {
                        Navigator.pop(context);
                        updateLoading(true);

                        await Repository.addPoints(
                            "${num.parse(value) - customer.balance}");
                        await userSingleton
                            .updateCurrentUser(UserSingleton.userId);
                        updateLoading(false);

                        sendNotification(
                            message:
                                "${(num.parse(value) - customer.balance).toStringAsFixed(2)} points given",
                            context: cntxt,
                            icon: FontAwesome5Solid.gift,
                            color: Constant.secondary);
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ));
      }
    } else {
      sendNotification(
          message: "Please correct your email.",
          context: cntxt,
          icon: Icons.error,
          color: Constant.primary);
    }
  }

  getHeartColor(List<int> cards, String code) {
    return cards.contains(num.parse(code)) ? Constant.red : Constant.secondary;
  }

  dispose() {
    value.close();
    loading.close();
  }
}

class CardViewBlocObject {
  String value;
  bool loading;
  Customer user;
  CardViewBlocObject({this.value, this.user, this.loading});
}
