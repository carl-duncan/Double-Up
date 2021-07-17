import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class ProductRow extends StatelessWidget {
  final String name, category, description;
  final VoidCallback onTap;
  ProductRow({
    @required this.name,
    @required this.category,
    @required this.description,
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
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://source.unsplash.com/20${rng.nextInt(9)}x20${rng.nextInt(9)}/?meat",
                  placeholder: (context, url) =>
                      BlurHash(hash: "LGKc%zo#9^IU}YOY\$fOG%MS^t8Kj"),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  height: 76,
                  width: 76,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.name,
                  style: theme.textTheme.headline6,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: Container(
                      height: 20,
                      width: 100,
                      color: Constant.primary,
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            this.category,
                            style: theme.textTheme.overline
                                .copyWith(color: Colors.white),
                          )
                        ],
                      )),
                    ),
                  ),
                ),
                Text(
                  this.description,
                  style: theme.textTheme.caption.copyWith(color: Colors.grey),
                  maxLines: 4,
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
