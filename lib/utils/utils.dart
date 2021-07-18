import 'package:carousel_slider/carousel_slider.dart';
import 'package:double_up/models/category.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/pages/customer/card_view/card_view.dart';
import 'package:double_up/pages/customer/category_view/category_view.dart';
import 'package:double_up/utils/transition.dart';
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

  static productsList(List<Product> objects) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 15, right: 15).copyWith(bottom: 50),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return ProductRow(product: objects[index], onTap: null);
      }, childCount: objects.length)),
    );
  }

  static categoryRow(List<Category> objects) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
      sliver: SliverList(
          delegate: SliverChildListDelegate.fixed([
        Container(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CategoryCard(
                category: objects[index],
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(createRoute(CategoryView(
                    category: objects[index],
                  )));
                },
              );
            },
            itemCount: objects.length,
          ),
        ),
      ])),
    );
  }
}
