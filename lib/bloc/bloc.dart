import 'package:double_up/singleton/user_singleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bloc {
  UserSingleton userSingleton = UserSingleton();

  sendNotification(String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: new Text("Alert"),
              content: new Text(message),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("Thank You"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }
}
