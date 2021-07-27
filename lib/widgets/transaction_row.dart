import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/models/transaction.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/utils.dart';
import 'package:flutter/material.dart';

class TransactionRow extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback onTap;
  TransactionRow({
    @required this.transaction,
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
                  tag: transaction.id,
                  child: CachedNetworkImage(
                    imageUrl: transaction.business.image,
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
                  transaction.business.name,
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
                          color: Constant.primary2.withOpacity(0.1),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${transaction.points.toStringAsFixed(2)} points",
                                style: theme.textTheme.overline.copyWith(
                                    color: Constant.primary,
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
                            text: "${Utils.readTimestamp(transaction.date)}",
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
