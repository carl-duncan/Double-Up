import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:double_up/models/business.dart';
import 'package:double_up/models/category.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/pages/card_view/card_view.dart';
import 'package:double_up/pages/product_page/product_page.dart';
import 'package:double_up/utils/transition.dart';
import 'package:double_up/widgets/business_row.dart';
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

  static productsList(List<Product> objects) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 15, right: 15),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return ProductRow(
            product: objects[index],
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .push(createRoute(ProductPage(
                product: objects[index],
              )));
            });
      }, childCount: objects.length)),
    );
  }

  static businessList(List<Business> objects) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 15, right: 15),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return BusinessRow(business: objects[index], onTap: () {});
      }, childCount: objects.length)),
    );
  }

  static detailedCardsList(List<GiftCard> cards, BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            width: 80,
            imageUrl: cards[index].logo,
          ),
        ),
        title: Text(
          "${cards[index].caption} (\$20)",
          style: Theme.of(context).textTheme.bodyText2,
        ),
        isThreeLine: false,
        subtitle: Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'Balance: ',
                  style: Theme.of(context).textTheme.caption),
              TextSpan(
                text: '\$10 USD\n',
              ),
            ],
          ),
        ),
        onTap: () {
          print(cards[index].code);
        },
      );
    }, childCount: cards.length));
  }

  static categoryRow(List<Category> objects) {
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
                  // Navigator.of(context, rootNavigator: true)
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

  static endOfSliver() {
    return SliverList(
        delegate: SliverChildListDelegate.fixed([
      SizedBox(
        height: 50,
      )
    ]));
  }
}
