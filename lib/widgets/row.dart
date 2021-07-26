import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductRow extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final String hero;
  ProductRow({
    @required this.product,
    @required this.onTap,
    this.hero,
  });

  @override
  Widget build(BuildContext context) {
    var rng = new Random();
    ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: this.onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 0,
          shadowColor: Colors.grey,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Hero(
                      tag: hero == null ? product.id : hero,
                      child: CachedNetworkImage(
                        imageUrl: product.images.first,
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
                              color: HexColor(product.category.color)
                                  .withOpacity(0.2),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      product.category.name,
                                      style: theme.textTheme.overline.copyWith(
                                          color:
                                              HexColor(product.category.color),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    )
                                  ],
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text('\$${product.price}',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey)),
                        SizedBox(
                          width: 5,
                        ),
                        Utils.numberString(
                            (product.price * (1 - product.threshold)),
                            context,
                            20.0),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
