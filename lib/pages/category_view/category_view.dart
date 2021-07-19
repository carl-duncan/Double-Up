import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/models/category.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/pages/category_view/category_view_bloc.dart';
import 'package:double_up/pages/loading_page.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  final Category category;
  const CategoryView({Key key, this.category}) : super(key: key);

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  CategoryViewBloc categoryViewBloc;

  @override
  void initState() {
    categoryViewBloc = CategoryViewBloc(widget.category.id, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: categoryViewBloc.products,
          builder: (context, snapshot) {
            Widget child = LoadingPage();
            if (snapshot.hasData) child = loadUI(snapshot.data);
            return child;
          }),
    );
  }

  loadUI(List<Product> products) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 70.0,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          pinned: false,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(widget.category.name,
                  style: Theme.of(context).textTheme.headline6),
              background: Hero(
                tag: widget.category.id,
                child: Container(
                  child: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Constant.primary, Colors.transparent],
                        ).createShader(
                            Rect.fromLTRB(0, 0, rect.width, rect.height));
                      },
                      blendMode: BlendMode.dstIn,
                      child: Container(
                        child: CachedNetworkImage(
                          imageUrl: widget.category.image,
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
              )),
        ),
        Utils.productsList(products),
        SliverPadding(
          padding: Constant.padding,
          sliver: SliverList(delegate: SliverChildListDelegate.fixed([])),
        )
      ],
    );
  }
}
