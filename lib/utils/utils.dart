import 'package:carousel_slider/carousel_slider.dart';
import 'package:double_up/models/business.dart';
import 'package:double_up/models/category.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/pages/business_page/business_page.dart';
import 'package:double_up/pages/card_view/card_view.dart';
import 'package:double_up/pages/product_page/product_page.dart';
import 'package:double_up/utils/transition.dart';
import 'package:double_up/widgets/business_row.dart';
import 'package:double_up/widgets/card_row.dart';
import 'package:double_up/widgets/category_card.dart';
import 'package:double_up/widgets/gift_card_view.dart';
import 'package:double_up/widgets/row.dart';
import 'package:flutter/material.dart';

class Utils {
  static cardsCarousel(List<GiftCard> giftCards, {num height}) {
    return SliverList(
        delegate: SliverChildListDelegate.fixed([
      Container(
        height: height == null ? 250 : height,
        child: CarouselSlider.builder(
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            pageSnapping: true,
            enableInfiniteScroll: true,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            viewportFraction: 0.9,
            initialPage: 0,
          ),
          itemBuilder: (context, index, index2) {
            return GiftCardView(
              card: giftCards[index],
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .push(createRoute(CardView(
                  card: giftCards[index],
                )));
              },
            );
          },
          itemCount: giftCards.length,
        ),
      )
    ]));
  }

  static cardsList(List<GiftCard> giftCards, {num height}) {
    return SliverList(
        delegate: SliverChildListDelegate.fixed([
      Container(
        height: height == null ? 100 : height,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GiftCardView(
              card: giftCards[index],
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .push(createRoute(CardView(
                  card: giftCards[index],
                )));
              },
            );
          },
          itemCount: giftCards.length,
        ),
      )
    ]));
  }

  static singleCard(GiftCard card, BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate.fixed([
      Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Stack(
          children: [
            GiftCardView(
              card: card,
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .push(createRoute(CardView(
                  card: card,
                )));
              },
            ),
          ],
        ),
      )
    ]));
  }

  static productsList(List<Product> objects, String hero) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 15, right: 15),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return ProductRow(
            product: objects[index],
            hero: hero != null ? hero + objects[index].id : null,
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .push(createRoute(ProductPage(
                product: objects[index],
                hero: hero != null ? hero + objects[index].id : null,
              )));
            });
      }, childCount: objects.length)),
    );
  }

  static emtpyStateSliver() {
    return SliverFillRemaining(
      child: new Container(
        child: Center(
          child: Text("Nothing here to see"),
        ),
      ),
    );
  }

  static num getNumber(double input, {int precision = 2}) =>
      num.parse('$input'.substring(0, '$input'.indexOf('.') + precision + 1));

  static Widget numberString(num balance, BuildContext context, num size) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Transform.translate(
              offset: const Offset(0.0, -7.0),
              child: Text(
                '\$',
                style: Theme.of(context).textTheme.headline4.copyWith(
                    color: Theme.of(context).scaffoldBackgroundColor ==
                            Colors.black
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: size * 0.6),
              ),
            ),
          ),
          TextSpan(
            text:
                "${Utils.getNumber(balance, precision: 0).toStringAsFixed(0)}",
            style: Theme.of(context).textTheme.headline2.copyWith(
                color: Theme.of(context).scaffoldBackgroundColor == Colors.black
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: size),
          ),
          WidgetSpan(
            child: Transform.translate(
              offset: const Offset(0.0, -9.0),
              child: Text(
                "${((balance - Utils.getNumber(balance, precision: 0)).toStringAsFixed(2)).substring(1, 4)}",
                style: Theme.of(context).textTheme.headline3.copyWith(
                    color: Theme.of(context).scaffoldBackgroundColor ==
                            Colors.black
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: size * 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static businessList(List<Business> objects) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 15, right: 15),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return BusinessRow(
            business: objects[index],
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .push(createRoute(BusinessPage(
                business: objects[index],
              )));
            });
      }, childCount: objects.length)),
    );
  }

  static detailedCardsList(List<GiftCard> cards, BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 15, right: 15),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return CardRow(card: cards[index], onTap: () {});
      }, childCount: cards.length)),
    );
  }

  static categoryRow(List<Category> objects, Function event) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
      sliver: SliverList(
          delegate: SliverChildListDelegate.fixed([
        Container(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CategoryCard(
                category: objects[index],
                onTap: () {
                  event(objects[index], index);
                  // Navigator.of(context, rootNavigator: false)
                  //     .push(createRoute(CategoryView(
                  //   category: objects[index],
                  // )));
                },
              );
            },
            itemCount: objects.length,
          ),
        ),
      ])),
    );
  }

  static blankSliver() {
    return SliverList(delegate: SliverChildListDelegate.fixed([]));
  }

  static endOfSliver() {
    return SliverList(
        delegate: SliverChildListDelegate.fixed([
      SizedBox(
        height: 50,
      )
    ]));
  }
}
