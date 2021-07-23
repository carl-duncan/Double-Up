import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/utils/const.dart';
import 'package:flutter/material.dart';

class GiftCardView extends StatelessWidget {
  final GiftCard card;
  final VoidCallback onTap;
  final String hero;
  const GiftCardView(
      {Key key, @required this.card, @required this.onTap, this.hero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constant.padding.copyWith(left: 5, right: 5),
      child: Stack(
        children: [
          InkWell(
            onTap: onTap,
            child: Hero(
              tag: "$hero:${card.code}",
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.015),
                  child: CachedNetworkImage(
                    imageUrl: "${card.logo}",
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
