import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/models/gift_card.dart';
import 'package:double_up/utils/const.dart';
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
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Hero(
                  tag: "",
                  child: CachedNetworkImage(
                    imageUrl: card.logo,
                    fit: BoxFit.cover,
                    height: 76,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${card.caption} Card",
                  style: theme.textTheme.headline6,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 5),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Container(
                          height: 20,
                          width: 100,
                          color: Constant.secondary,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "\$50.00",
                                style: theme.textTheme.overline
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 2),
                  child: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: card.sendcolor,
                            style: Theme.of(context).textTheme.caption),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      onTap: this.onTap,
    );
  }
}
