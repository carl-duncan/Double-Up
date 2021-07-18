import 'package:double_up/pages/customer/dashboard/dashboard_bloc.dart';
import 'package:double_up/pages/loading_page.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/utils.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:double_up/widgets/title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CustomerDashboard extends StatefulWidget {
  @override
  _CustomerDashboardState createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  DashboardBloc dashboardBloc;

  @override
  void initState() {
    dashboardBloc = DashboardBloc(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: dashboardBloc.combineLatestStream,
          builder: (context, snapshot) {
            Widget child = LoadingPage();
            if (snapshot.hasData) {
              DashboardBlocObject object = snapshot.data;
              child = loadUI(object);
            }

            return AnimatedSwitcher(
              duration: Duration(milliseconds: Constant.load),
              child: child,
            );
          }),
    );
  }

  loadUI(DashboardBlocObject object) {
    return AnimationLimiter(
      child: AnimationConfiguration.synchronized(
        duration: Duration(milliseconds: Constant.load),
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: CustomScrollView(
              slivers: [
                navigationBar(context, "Dashboard"),
                TitleWidget(
                    title: "Your Recommended Gift Card",
                    subtitle: "Based on your shopping history.",
                    padding: Constant.padding.copyWith(top: 20, bottom: 0),
                    onTap: null),
                Utils.singleCard(object.giftCards[3], context),
                TitleWidget(
                    title: "Categories",
                    subtitle: "All the goodies we offer to you.",
                    padding: Constant.padding.copyWith(top: 15, bottom: 10),
                    onTap: null),
                Utils.categoryRow(object.category),
                TitleWidget(
                    title: "Recommended Products",
                    subtitle: "All the goodies we offer to you.",
                    padding: Constant.padding.copyWith(top: 15, bottom: 10),
                    onTap: null),
                Utils.productsList(object.products)

                // Utils.productsList(objects);
              ],
            ),
          ),
        ),
      ),
    );
  }
}
