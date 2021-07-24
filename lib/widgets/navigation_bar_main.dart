import 'package:badges/badges.dart';
import 'package:double_up/pages/notifications/notifications.dart';
import 'package:double_up/utils/transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';

navigationBar(BuildContext context, String title, int num) {
  return SliverList(
      delegate: SliverChildListDelegate.fixed([
    CupertinoNavigationBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      middle: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .push(createRoute(Notifications()));
            },
            child: Badge(
              position: BadgePosition.topStart(),
              badgeContent: num != 0
                  ? Text(
                      "$num",
                      style: TextStyle(color: Colors.white),
                    )
                  : null,
              child: Material(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Icon(
                  FontAwesome5Solid.bell,
                  size: 20,
                ),
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
      leading: InkWell(child: Icon(CupertinoIcons.back),onTap: (){
        Navigator.pop(context);
      },),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      middle: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      border: null,
    )
  ]));
}
