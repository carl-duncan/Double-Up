import 'package:double_up/utils/const.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:double_up/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: null,
          builder: (context, snapshot) {
            Widget child = Container();
            if (!snapshot.hasData) child = loadUI(context);
            return child;
          }),
    );
  }

  loadUI(BuildContext context) {
    return CustomScrollView(
      slivers: [
        navigationBar(context, "Search"),
        SliverPadding(
          padding: Constant.padding,
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
            Field(
                hint: "Search for Products, Gift Cards",
                controller: null,
                obscure: false,
                suffix: FontAwesome5Solid.search,
                enabled: true)
          ])),
        ),
      ],
    );
  }
}
