import 'package:double_up/pages/customer/category_view/category_view.dart';
import 'package:double_up/pages/customer/dashboard/dashboard_bloc.dart';
import 'package:double_up/pages/loading_page.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/transition.dart';
import 'package:double_up/utils/utils.dart';
import 'package:double_up/widgets/category_card.dart';
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

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navigationBar(context, "Dashboard"),
      body: StreamBuilder(
          stream: dashboardBloc.combineLatestStream,
          builder: (context, snapshot) {
            Widget child = LoadingPage();
            if (snapshot.hasData) {
              DashboardBlocObject object = snapshot.data;
              child = loadUI(object);
            }
            return child;
          }),
    );
  }

  loadUI(DashboardBlocObject object) {
    return AnimationLimiter(
      child: AnimationConfiguration.synchronized(
        duration: const Duration(milliseconds: Constant.load),
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildListDelegate.fixed([
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TitleWidget(
                        title: "Your Recommended Gift Card",
                        subtitle: "Based on your shopping history we recommend",
                        onTap: null),
                  ),
                  Utils.cardsCarousel(object.giftCards)
                ])),
                SliverPadding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 0, bottom: 0),
                  sliver: SliverList(
                      delegate: SliverChildListDelegate.fixed([
                    TitleWidget(
                        title: "Categories",
                        subtitle: "All the goodies we offer to you.",
                        onTap: null),
                    Container(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryCard(
                            category: object.category[index],
                            onTap: () {
                              Navigator.of(context, rootNavigator: true)
                                  .push(createRoute(CategoryView(
                                category: object.category[index],
                              )));
                            },
                          );
                        },
                        itemCount: object.category.length,
                      ),
                    ),
                  ])),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate.fixed([
                      TitleWidget(
                          title: "Your Recommended Products",
                          subtitle:
                              "Based on your shopping history we recommend",
                          onTap: () {}),
                    ]),
                  ),
                ),
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
