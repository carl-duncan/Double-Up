import 'package:double_up/models/customer.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/pages/card_view/card_view_bloc.dart';
import 'package:double_up/pages/loading_page.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/utils.dart';
import 'package:double_up/widgets/gift_card_view.dart';
import 'package:double_up/widgets/icon_button.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:double_up/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';

class CardView extends StatefulWidget {
  final GiftCard card;
  final String hero;
  const CardView({Key key, this.card, this.hero}) : super(key: key);

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  CardViewBloc cardViewBloc;

  @override
  Widget build(BuildContext context) {
    // cardViewBloc.email.text = "doubleuptestingacc@gmail.com";
    return Scaffold(
      body: StreamBuilder(
          stream: cardViewBloc.combineLatestStream,
          initialData: CardViewBlocObject(
              value: cardViewBloc.amounts.first,
              user: Customer(favCards: []),
              loading: false),
          builder: (context, snapshot) {
            Widget child = LoadingPage();
            if (snapshot.hasData) {
              CardViewBlocObject object = snapshot.data;
              if (!object.loading) child = loadUI(snapshot.data);
            }
            return AnimatedSwitcher(
              duration: Duration(milliseconds: Constant.load),
              child: child,
            );
          }),
    );
  }

  @override
  void initState() {
    List<String> amounts = widget.card.value.split(",");
    cardViewBloc = CardViewBloc(amounts.first);
    cardViewBloc.amounts = amounts;

    super.initState();
  }

  loadUI(CardViewBlocObject object) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        navigationBarPushed(context, "Purchase ${widget.card.caption} Card"),
        SliverPadding(
          padding: Constant.padding.copyWith(top: 0),
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
            GiftCardView(
              card: widget.card,
              hero: widget.hero,
              onTap: () {},
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Spacer(),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        FontAwesome5Solid.heart,
                        color: cardViewBloc.getHeartColor(
                            object.user.favCards, widget.card.code),
                      ),
                    ),
                    onTap: () {
                      cardViewBloc.addToFav(widget.card, context);
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 15),
              child: Text(
                widget.card.desc,
                textAlign: TextAlign.start,
                style:
                    Theme.of(context).textTheme.caption.copyWith(fontSize: 11),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Container(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            height: 50,
                            width: 70,
                            color: cardViewBloc.amounts[index] == object.value
                                ? Constant.primary.withOpacity(0.2)
                                : Colors.black,
                            child: Center(
                              child: Text(
                                "\$${cardViewBloc.amounts[index]}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        color: cardViewBloc.amounts[index] ==
                                                object.value
                                            ? Constant.primary
                                            : Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        cardViewBloc.updateValue(cardViewBloc.amounts[index]);
                      },
                    );
                  },
                  itemCount: cardViewBloc.amounts.length,
                ),
              ),
            ),
            Field(
                hint: "Email Address",
                controller: cardViewBloc.email,
                obscure: false,
                type: TextInputType.emailAddress,
                suffix: Entypo.email,
                label: null,
                enabled: true),
            Field(
                hint: "Message",
                controller: cardViewBloc.message,
                obscure: false,
                lines: 3,
                type: TextInputType.multiline,
                suffix: Icons.message,
                label: null,
                enabled: true),
            IconButtonWidget(
                buttonText: "Send Gift Card",
                buttonColor: HexColor(widget.card.color),
                onPressed: () {
                  cardViewBloc.sendGiftCard(context, widget.card, object.value);
                },
                icon: Icon(FontAwesome5Solid.gift)),
          ])),
        ),
        Utils.endOfSliver()
      ],
    );
  }

  @override
  void dispose() {
    cardViewBloc.dispose();
    super.dispose();
  }
}
