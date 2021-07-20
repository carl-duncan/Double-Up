import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/pages/product_page/product_page_bloc.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/widgets/icon_button.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  const ProductPage({Key key, @required this.product}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductPageBloc productPageBloc = ProductPageBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: null,
          builder: (context, snapshot) {
            Widget child = Container();
            if (!snapshot.hasData) child = loadUI(context);
            return AnimatedSwitcher(
              duration: Duration(milliseconds: Constant.load),
              child: child,
            );
          }),
    );
  }

  loadUI(BuildContext context) {
    return CustomScrollView(
      slivers: [
        navigationBarPushed(context, widget.product.name),
        SliverPadding(
          padding: Constant.padding,
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
            Hero(
              tag: widget.product.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: widget.product.images.first,
                  height: 200,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              child: Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '\$${widget.product.price}',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey)),
                        TextSpan(
                            text:
                                ' \$${(num.parse(widget.product.price) * (1 - widget.product.threshold)).toStringAsFixed(2)}',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color,
                                    fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    child: Icon(
                      FontAwesome5Solid.heart,
                      color: Constant.red,
                    ),
                    onTap: () {
                      productPageBloc.sendNotification(
                          "${widget.product.name} has been added to your favorites.",
                          context);
                    },
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                "Description",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Text(
              widget.product.description,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.grey),
            ),

            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3),
              child: IconButtonWidget(
                  buttonText: "Find Supermarket",
                  buttonColor: Constant.secondary,
                  onPressed: () {},
                  icon: Icon(Icons.fastfood)),
            )
            // BusinessRow(business: widget.product.business, onTap: () {})
          ])),
        )
      ],
    );
  }
}
