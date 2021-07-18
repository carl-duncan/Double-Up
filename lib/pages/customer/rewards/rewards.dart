import 'package:double_up/models/gift_card.dart';
import 'package:double_up/pages/customer/rewards/rewards_bloc.dart';
import 'package:double_up/pages/loading_page.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/widgets/icon_button.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:double_up/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Rewards extends StatefulWidget {
  const Rewards({Key key}) : super(key: key);

  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  RewardsBloc rewardsBloc;

  @override
  void initState() {
    rewardsBloc = RewardsBloc(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: rewardsBloc.giftCards,
          builder: (context, snapshot) {
            Widget child = LoadingPage();
            if (snapshot.hasData) child = loadUI(context, snapshot.data);
            return AnimatedSwitcher(
              duration: Duration(milliseconds: Constant.load),
              child: child,
            );
          }),
    );
  }

  loadUI(BuildContext context, List<GiftCard> cards) {
    return CustomScrollView(
      slivers: [
        navigationBar(context, "My Rewards"),
        SliverPadding(
          padding: Constant.padding,
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
            Column(
              children: [
                Text(
                  "Your Balance:",
                  style: Theme.of(context)
                      .textTheme
                      .overline
                      .copyWith(fontSize: 12),
                ),
                Text(
                  "\$187.00",
                  style: Theme.of(context).textTheme.headline2,
                )
              ],
            ),
            IconButtonWidget(
                buttonText: "Scan QR Code",
                buttonColor: Colors.black,
                onPressed: () {},
                icon: Icon(AntDesign.qrcode)),
            //
            // Text.rich(
            //   TextSpan(
            //     children: <TextSpan>[
            //       TextSpan(
            //           text: 'Balance:',
            //           style: Theme.of(context).textTheme.headline6),
            //       TextSpan(
            //           text: '\$5000',
            //           style: Theme.of(context).textTheme.headline6),
            //     ],
            //   ),
            // ),
          ])),
        ),
        // Utils.cardsCarousel(cards),
        TitleWidget(
            title: "Order History",
            subtitle: "All your gift cards you have and their balances",
            padding: Constant.padding.copyWith(top: 15),
            onTap: null),
      ],
    );
  }
}
