import 'package:carousel_slider/carousel_slider.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/pages/customer/card_view/card_view.dart';
import 'package:double_up/utils/transition.dart';
import 'package:double_up/widgets/gift_card_view.dart';
import 'package:double_up/widgets/row.dart';
import 'package:flutter/material.dart';

class Utils {
  static cardsCarousel(List<GiftCard> giftCards) {
    return Padding(
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
      ),
    );
  }

  static productsList(List<Product> objects) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 15, right: 15).copyWith(bottom: 50),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return ProductRow(
            name: objects[index].name,
            category: objects[index].category.name,
            description: objects[index].description,
            onTap: null);
      }, childCount: objects.length)),
    );
  }
}
