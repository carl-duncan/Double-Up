import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/utils/const.dart';
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
          "Dashboard",
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
            Hero(
              tag: "Card:${widget.card.code}",
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: "${widget.card.logo}",
                  )),
            )
          ])),
        )
      ],
    );
  }
}
