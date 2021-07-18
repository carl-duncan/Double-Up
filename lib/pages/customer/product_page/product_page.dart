import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  const ProductPage({Key key, @required this.product}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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
        SliverList(
            delegate: SliverChildListDelegate.fixed([
          Hero(
            tag: widget.product.id,
            child: CachedNetworkImage(
                imageUrl: Repository.s3 + widget.product.images.first),
          ),
          Text(widget.product.toJson().toString())
        ]))
      ],
    );
  }
}
