import 'package:double_up/pages/customer/rewards/rewards_bloc.dart';
import 'package:double_up/pages/loading_page.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/utils.dart';
import 'package:double_up/widgets/empty_state.dart';
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
          stream: rewardsBloc.combineLatestStream,
          builder: (context, snapshot) {
            Widget child = LoadingPage();
            if (snapshot.hasData) {
              RewardsBlocObject object = snapshot.data;
              if (!object.loading) child = loadUI(context, snapshot.data);
            }
            return AnimatedSwitcher(
              duration: Duration(milliseconds: Constant.load),
              child: child,
            );
          }),
    );
  }

  loadUI(BuildContext context, RewardsBlocObject obj) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        Utils.refreshControl(() async {
          await rewardsBloc.userSingleton.updateCurrentUser(obj.customer.id);
          await rewardsBloc.updateTransaction();
        }),
        navigationBar(context, "My Rewards", obj.notifications.length),
        TitleWidget(
            title: "Recommended Gift Cards",
            // subtitle: "[TO BE FILLED OUT]",
            padding: Constant.padding.copyWith(top: 20, bottom: 0),
            onTap: null),
        Utils.cardsCarousel(
          obj.giftCards,
        ),
        SliverPadding(
          padding: Constant.padding.copyWith(top: 15),
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
            Column(
              children: [
                Text(
                  "Your Balance:",
                  style: Theme.of(context)
                      .textTheme
                      .overline
                      .copyWith(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            Center(
                child: Utils.numberString(obj.customer.balance, context, 50.0)),
            IconButtonWidget(
                buttonText: "Scan QR Code",
                buttonColor: Constant.secondary,
                onPressed: () {
                  rewardsBloc.redeemQrCode(context);
                },
                icon: Icon(AntDesign.qrcode)),
          ])),
        ),
        // Utils.cardsCarousel(cards),
        TitleWidget(
          title: "Redeem History",
          onTap: () {
            rewardsBloc.openRedeemList(context);
          },
          padding: Constant.padding.copyWith(bottom: 15),
        ),

        obj.transaction == null || obj.transaction.length == 0
            ? EmptyState(
                title: "Explore Products",
                onTap: () {
                  rewardsBloc.changePage();
                },
              )
            : Utils.transactionRow(obj.transaction, limit: 3),

        Utils.endOfSliver()
      ],
    );
  }
}
