import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:flutter/material.dart';

class CardRow extends StatelessWidget {
  final GiftCard card;
  final VoidCallback onTap;
  CardRow({
    @required this.card,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var rng = new Random();
    ThemeData theme = Theme.of(context);

    return InkWell(
      splashColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Hero(
                  tag: card.code,
                  child: CachedNetworkImage(
                    imageUrl: card.logo,
                    fit: BoxFit.cover,
                    height: 56,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: this.onTap,
    );
  }
}
