import 'package:double_up/models/gift_card.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/widgets/gift_card_view.dart';
import 'package:double_up/widgets/icon_button.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:double_up/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
        navigationBarPushed(context, "Purchase ${widget.card.caption} Card"),
        SliverPadding(
          padding: Constant.padding,
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
            GiftCardView(
              card: widget.card,
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Text(
                widget.card.desc,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Field(
                hint: "Phone Number",
                controller: null,
                obscure: false,
                type: TextInputType.number,
                suffix: AntDesign.phone,
                label: null,
                enabled: true),
            IconButtonWidget(
                buttonText: "Send Gift Card",
                buttonColor: Constant.primary,
                onPressed: () {},
                icon: Icon(FontAwesome5Solid.gift)),
          ])),
        )
      ],
    );
  }
}
