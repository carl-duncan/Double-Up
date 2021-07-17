import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/pages/customer/dashboard/dashboard_bloc.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomerDashboard extends StatefulWidget {
  @override
  _CustomerDashboardState createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  DashboardBloc dashboardBloc;

  @override
  void initState() {
    dashboardBloc = DashboardBloc(context);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navigationBar(context, "Dashboard"),
      body: StreamBuilder<List<GiftCard>>(
          stream: dashboardBloc.giftCards,
          builder: (context, snapshot) {
            Widget child = Container();
            if (snapshot.hasData) child = loadUI(snapshot.data);
            return child;
          }),
    );
  }

  loadUI(List<GiftCard> cards) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: Constant.padding,
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: "${cards.first.logo}",
                ))
          ])),
        )
      ],
    );
  }
}
