import 'package:double_up/singleton/user_singleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Bloc {
  UserSingleton userSingleton = UserSingleton();
  FToast fToast = FToast();

  sendNotification(
      {@required String message,
      @required BuildContext context,
      @required IconData icon,
      @required Color color}) {
    fToast.init(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            message,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 1),
    );
  }
}
