import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/pages/customer/card_view/card_view.dart';
import 'package:double_up/pages/customer/dashboard/dashboard_bloc.dart';
import 'package:double_up/pages/loading_page.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/transition.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:double_up/widgets/row.dart';
import 'package:double_up/widgets/title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
      body: StreamBuilder<List<GiftCard>>(
          stream: dashboardBloc.giftCards,
          builder: (context, snapshot) {
            Widget child = LoadingPage();
            if (snapshot.hasData) child = loadUI(snapshot.data);
            return child;
          }),
    );
  }

  loadUI(List<GiftCard> cards) {
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
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Container(
                      height: 200,
                      child: CarouselSlider.builder(
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          pageSnapping: true,
                          enableInfiniteScroll: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale,
                          viewportFraction: 0.9,
                          // aspectRatio: 1,
                          initialPage: 0,
                        ),
                        itemBuilder: (context, index, index2) {
                          return Padding(
                            padding: Constant.padding,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .push(createRoute(CardView(
                                  card: cards[index],
                                )));
                              },
                              child: Hero(
                                tag: "Card:${cards[index].code}",
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl: "${cards[index].logo}",
                                    )),
                              ),
                            ),
                          );
                        },
                        itemCount: cards.length,
                      ),
                    ),
                  )
                ])),
                getCategories(context),
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
                SliverPadding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return ProductRow(
                        name: "Name of Product",
                        category: "Category",
                        description: "Description of the Product",
                        onTap: null);
                  }, childCount: 3)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getCategories(BuildContext context) {
    var rng = new Random();
    List<String> categories = [
      "Dinner",
      "Lunch",
      "Breakfast",
      "Fast Food",
      "Pastries"
    ];
    return SliverPadding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      height: 50,
                      width: 110,
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          image: DecorationImage(
                              image: NetworkImage(
                                'https://source.unsplash.com/50${rng.nextInt(10)}x50${rng.nextInt(10)}/?food")',
                              ),
                              fit: BoxFit.cover)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                MaterialCommunityIcons.food,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${categories[index]}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
              );
            },
            itemCount: categories.length,
          ),
        ),
      ])),
    );
  }
}
