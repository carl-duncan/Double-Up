import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/utils/const.dart';
import 'package:flutter/material.dart';

class MiniGiftCardView extends StatelessWidget {
  final GiftCard card;
  final VoidCallback onTap;
  const MiniGiftCardView({Key key, @required this.card, @required this.onTap})
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
              tag: "Card:${card.code}",
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
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
