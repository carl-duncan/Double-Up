import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/models/customer.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/pages/loading_page.dart';
import 'package:double_up/pages/product_page/product_page_bloc.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/utils.dart';
import 'package:double_up/widgets/icon_button.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  final String hero;
  const ProductPage({Key key, @required this.product, this.hero})
      : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductPageBloc productPageBloc = ProductPageBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          initialData: Customer(),
          stream: productPageBloc.userSingleton.currentUser,
          builder: (context, snapshot) {
            Widget child = LoadingPage();
            if (snapshot.hasData) child = loadUI(snapshot.data, context);
            return AnimatedSwitcher(
              duration: Duration(milliseconds: Constant.load),
              child: child,
            );
          }),
    );
  }

  loadUI(Customer user, BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        navigationBarPushed(context, widget.product.name),
        SliverPadding(
          padding: Constant.padding,
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
            Hero(
              tag: widget.hero == null ? widget.product.id : widget.hero,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: widget.product.images.first,
                  height: 200,
                ),
              ),
            ),

            Row(
              children: [
                Text('\$${widget.product.price}',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey)),
                SizedBox(
                  width: 10,
                ),
                Utils.numberString(
                    (widget.product.price * (1 - widget.product.threshold)),
                    context,
                    60.0),
              ],
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Constant.primary.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            '${(widget.product.price * (widget.product.threshold)).toStringAsFixed(2)} points',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    color: Constant.primary,
                                    fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        FontAwesome5Solid.heart,
                        color: productPageBloc.getHeartColor(
                            user.favProducts, widget.product),
                      ),
                    ),
                    onTap: () {
                      productPageBloc.addToFav(widget.product, context);
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
              padding: EdgeInsets.only(top: 15),
              child: IconButtonWidget(
                  buttonText: "Where to Find?",
                  buttonColor: HexColor(widget.product.category.color),
                  onPressed: () {
                    productPageBloc.findLocation(widget.product);
                  },
                  icon: Icon(IconData(widget.product.category.code,
                      fontFamily: widget.product.category.family,
                      fontPackage: "flutter_icons"))),
            )
            // BusinessRow(business: widget.product.business, onTap: () {})
          ])),
        ),
        Utils.endOfSliver()
      ],
    );
  }
}
