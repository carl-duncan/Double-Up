import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/models/business.dart';
import 'package:double_up/utils/const.dart';
import 'package:flutter/material.dart';

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
      splashColor: Colors.transparent,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(109),
                child: Hero(
                  tag: business.id,
                  child: CachedNetworkImage(
                    imageUrl: business.image,
                    fit: BoxFit.cover,
                    height: 66,
                    width: 66,
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
                          color: Constant.secondary,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                business.category.name,
                                style: theme.textTheme.overline.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
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
