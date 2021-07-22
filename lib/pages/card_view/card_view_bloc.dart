import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/models/customer.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:double_up/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rxdart/rxdart.dart';

class CardViewBloc extends Bloc {
  BehaviorSubject<String> value = BehaviorSubject();
  CombineLatestStream combineLatestStream;
  CardViewBloc(String initialValue) {
    combineLatestStream =
        CombineLatestStream([value, userSingleton.currentUser], (a) {
      return CardViewBlocObject(value: a[0], user: a[1]);
    });
    value.add(initialValue);
  }

  updateValue(String value) {
    this.value.add(value);
  }

  addToFav(String name, String code, BuildContext context) async {
    Customer user = await userSingleton.currentUser.first;
    bool condition = !(user.favCards.contains(num.parse(code)));
    if (condition) {
      user.favCards.add(num.parse(code));
    } else {
      user.favCards.removeWhere((val) {
        if (val == num.parse(code)) return true;
        return false;
      });
    }
    await Repository.updateFavCards(user.favCards, user.id);
    await userSingleton.updateCurrentUser(user.id);

    if (condition) {
      sendNotification(
          message: "Added $name Card",
          context: context,
          icon: FontAwesome5Solid.heart,
          color: Constant.green);
    } else {
      sendNotification(
          message: "Removed $name Card",
          context: context,
          icon: FontAwesome5Solid.heart,
          color: Constant.secondary);
    }
  }

  sendGiftCard(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: new Text("Scheduled Send?"),
              content: new Text(
                  "Would you like to schedule this message to be sent later?"),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("Yes"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  isDefaultAction: false,
                  child: Text("No"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  isDefaultAction: false,
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

  getHeartColor(List<int> cards, String code) {
    return cards.contains(num.parse(code)) ? Constant.red : Constant.secondary;
  }

  dispose() {
    value.close();
  }
}

class CardViewBlocObject {
  String value;
  Customer user;
  CardViewBlocObject({this.value, this.user});
}
