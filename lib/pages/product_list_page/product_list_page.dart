import 'package:double_up/models/product.dart';
import 'package:double_up/pages/loading_page.dart';
import 'package:double_up/pages/product_list_page/product_list_page_bloc.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/utils.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  final String title;
  final Future<List<Product>> function;
  const ProductListPage(
      {Key key, @required this.function, @required this.title})
      : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  ProductListPageBloc productListPageBloc;
  @override
  void initState() {
    productListPageBloc = ProductListPageBloc(widget.function);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: productListPageBloc.products,
          builder: (context, snapshot) {
            Widget child = LoadingPage();
            if (snapshot.hasData) child = loadUI(context, snapshot.data);
            return AnimatedSwitcher(
              duration: Duration(milliseconds: Constant.load),
              child: child,
            );
          }),
    );
  }

  loadUI(BuildContext context, List<Product> products) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        navigationBarPushed(
          context,
          widget.title,
        ),
        Utils.productsList(products, "list")
      ],
    );
  }
}
