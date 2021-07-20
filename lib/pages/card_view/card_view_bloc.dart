import 'package:double_up/bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CardViewBloc extends Bloc {
  BehaviorSubject<String> value = BehaviorSubject();
  CombineLatestStream combineLatestStream;
  CardViewBloc(String initialValue) {
    combineLatestStream = CombineLatestStream([value], (a) {
      return CardViewBlocObject(value: a[0]);
    });
    value.add(initialValue);
  }

  updateValue(String value) {
    this.value.add(value);
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

  dispose() {
    value.close();
  }
}

class CardViewBlocObject {
  String value;
  CardViewBlocObject({this.value});
}
