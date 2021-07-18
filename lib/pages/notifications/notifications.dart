import 'package:double_up/models/notification.dart';
import 'package:double_up/pages/notifications/notifications_bloc.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotificationsBloc notificationsBloc = NotificationsBloc();
    return Scaffold(
      body: StreamBuilder(
          stream: notificationsBloc.userSingleton.notifications,
          builder: (context, snapshot) {
            Widget child = Container();
            if (snapshot.hasData) child = loadUI(context, snapshot.data);
            return AnimatedSwitcher(
              duration: Duration(milliseconds: Constant.load),
              child: child,
            );
          }),
    );
  }

  loadUI(BuildContext context, List<AppNotifications> notifications) {
    return CustomScrollView(
      slivers: [
        navigationBarPushed(context, "My Notifications"),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          String type = notifications[index].location.split(":").first;
          IconData icon;
          if (type == "card") {
            icon = FontAwesome5Solid.gift;
          }
          return ListTile(
            leading: Icon(
              icon,
              size: 40,
            ),
            title: Text(notifications[index].message),
            subtitle: Text(notifications[index].location),
            onTap: () {},
          );
        }, childCount: notifications.length))
      ],
    );
  }
}
