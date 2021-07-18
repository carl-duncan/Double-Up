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
      appBar: navigationBar(context, "Search"),
      body: StreamBuilder(
          stream: null,
          builder: (context, snapshot) {
            Widget child = Container();
            if (!snapshot.hasData) child = loadUI();
            return child;
          }),
    );
  }

  loadUI() {
    return CustomScrollView(
      slivers: [
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
