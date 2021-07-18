import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/models/category.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:double_up/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  final Category category;
  const CategoryView({Key key, this.category}) : super(key: key);

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        middle: Text(
          "Purchase ${widget.category.name} Card",
          style: Theme.of(context).textTheme.headline6,
        ),
        border: null,
      ),
      body: StreamBuilder(
          stream: null,
          builder: (context, snapshot) {
            Widget child = Container();
            if (!snapshot.hasData) child = loadUI();
            return child;
          }),
    );
  }

  loadUI() {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: Constant.padding,
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
            Hero(
              tag: widget.category.id,
              child: Container(
                child: CachedNetworkImage(imageUrl: Repository.s3 + widget.category.image,),
              ),
            )
          ])),
        )
      ],
    );
  }
}
