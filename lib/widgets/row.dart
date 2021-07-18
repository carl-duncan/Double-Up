import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:double_up/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class ProductRow extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  ProductRow({
    @required this.product,
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
                  imageUrl: Repository.s3 + product.images.first,
                  fit: BoxFit.cover,
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
                  product.name,
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
                                product.category.name,
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
                            text: '\$${product.price}',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey)),
                        TextSpan(
                            text:
                                ' \$${(num.parse(product.price) * (1 - product.threshold)).toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.headline6),
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
