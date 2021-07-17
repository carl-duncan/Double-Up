import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

CupertinoNavigationBar navigationBar(BuildContext context, String title) {
  return CupertinoNavigationBar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    middle: Text(
      "Dashboard",
      style: Theme.of(context).textTheme.headline6,
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Badge(
          position: BadgePosition.bottomEnd(),
          badgeContent: Text(
            "5",
            style: TextStyle(color: Colors.white),
          ),
          child: Icon(
            FontAwesome5Solid.bell,
            size: 25,
          ),
        ),
      ],
    ),
    leading: Icon(
      FontAwesome5Solid.user,
      size: 25,
    ),
    border: null,
  );
}
