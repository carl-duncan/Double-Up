import 'package:badges/badges.dart';
import 'package:double_up/pages/notifications/notifications.dart';
import 'package:double_up/utils/transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';

navigationBar(BuildContext context, String title) {
  return SliverList(
      delegate: SliverChildListDelegate.fixed([
    CupertinoNavigationBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      middle: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Badge(
            position: BadgePosition.bottomEnd(),
            badgeContent: Text(
              "5",
              style: TextStyle(color: Colors.white),
            ),
            child: Material(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: InkWell(
                child: Icon(
                  FontAwesome5Solid.bell,
                  size: 25,
                ),
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(createRoute(Notifications()));
                },
              ),
            ),
          ),
        ],
      ),
      // leading: Icon(
      //   FontAwesome5Solid.user,
      //   size: 25,
      // ),
      border: null,
    )
  ]));
}

navigationBarPushed(BuildContext context, String title) {
  return SliverList(
      delegate: SliverChildListDelegate.fixed([
    CupertinoNavigationBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      middle: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      border: null,
    )
  ]));
}
