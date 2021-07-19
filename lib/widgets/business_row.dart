import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/models/business.dart';
import 'package:double_up/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class BusinessRow extends StatelessWidget {
  final Business business;
  final VoidCallback onTap;
  BusinessRow({
    @required this.business,
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
                borderRadius: BorderRadius.circular(10),
                child: Hero(
                  tag: business.id,
                  child: CachedNetworkImage(
                    imageUrl: business.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        BlurHash(hash: "LGKc%zo#9^IU}YOY\$fOG%MS^t8Kj"),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    height: 76,
                    width: 76,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  business.name,
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
                          color: Constant.primary,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                business.category.name,
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
                            text: business.address,
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
