import 'package:double_up/utils/const.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: null,
          builder: (context, snapshot) {
            Widget child = Container();
            if (!snapshot.hasData) child = loadUI(context);
            return AnimatedSwitcher(
              duration: Duration(milliseconds: Constant.load),
              child: child,
            );
          }),
    );
  }

  loadUI(BuildContext context) {
    return CustomScrollView(
      slivers: [
        navigationBarPushed(context, "My Notifications"),
      ],
    );
  }
}
