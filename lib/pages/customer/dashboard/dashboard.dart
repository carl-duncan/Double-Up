import 'package:double_up/models/category.dart';
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
import 'package:sliver_tools/sliver_tools.dart';

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
  void dispose() {
    dashboardBloc.dispose();
    super.dispose();
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
              controller: dashboardBloc.controller,
              physics: BouncingScrollPhysics(),
              slivers: [
                Utils.refreshControl(() async {
                  await dashboardBloc.refreshStreams(context);
                }),
                navigationBar(
                    context, "Dashboard", object.notifications.length),
                TitleWidget(
                    title: "Categories",
                    // subtitle: "[TO BE FILLED OUT]",
                    padding: Constant.padding.copyWith(top: 15, bottom: 10),
                    onTap: null),
                Utils.categoryRow(object.category,
                    (Category object, int index) {
                  dashboardBloc.updateProducts(context, object, index);
                }),
                TitleWidget(
                    title: object.category[object.index].name,
                    padding: Constant.padding.copyWith(top: 15, bottom: 15),
                    onTap: object.index != 0
                        ? () {
                            dashboardBloc.openProductList(
                                context, object.category[object.index]);
                          }
                        : null),
                SliverAnimatedSwitcher(
                  duration: Duration(milliseconds: Constant.load),
                  child: Utils.productsList(
                      object.products, object.category[object.index].name,
                      limit: 3),
                ),
                TitleWidget(
                    title: "Recommended Supermarkets",
                    padding: Constant.padding.copyWith(top: 15, bottom: 15),
                    onTap: null),
                Utils.businessList(object.business, limit: 3),
                Utils.endOfSliver()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
