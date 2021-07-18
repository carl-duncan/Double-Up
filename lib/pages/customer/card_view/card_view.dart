import 'package:double_up/models/gift_card.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/widgets/gift_card_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardView extends StatefulWidget {
  final GiftCard card;

  const CardView({Key key, this.card}) : super(key: key);

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        middle: Text(
          "Purchase ${widget.card.caption} Card",
          style: Theme.of(context).textTheme.headline6,
        ),
        border: null,
      ),
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
            GiftCardView(
              card: widget.card,
              onTap: () {},
            )
          ])),
        )
      ],
    );
  }
}
