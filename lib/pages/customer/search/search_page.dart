import 'package:double_up/pages/customer/search/search_page_bloc.dart';
import 'package:double_up/pages/loading_page.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/utils.dart';
import 'package:double_up/widgets/empty_state.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:double_up/widgets/text_field.dart';
import 'package:double_up/widgets/title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchPageBloc searchPageBloc;

  @override
  void initState() {
    searchPageBloc = SearchPageBloc(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: searchPageBloc.combineLatestStream,
          builder: (context, snapshot) {
            Widget child = LoadingPage();
            if (snapshot.hasData) child = loadUI(context, snapshot.data);
            // return child;
            return AnimatedSwitcher(
              duration: Duration(milliseconds: Constant.load),
              child: child,
            );
          }),
    );
  }

  loadUI(BuildContext context, SearchPageBlocObject object) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        navigationBar(context, "Search", object.notification.length),
        SliverPadding(
          padding: Constant.padding,
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
            Field(
                hint: "Search for Products",
                controller: searchPageBloc.controller,
                label: null,
                onChanged: (String value) {
                  searchPageBloc.updateProducts(context, value);
                  searchPageBloc.updateBusinesses(context, value);
                },
                obscure: false,
                suffix: FontAwesome5Solid.search,
                enabled: true),
          ])),
        ),
        object.products.length > 0 || object.business.length > 0
            ? Utils.blankSliver()
            : EmptyState(
                title: "Clear Search",
                onTap: () {
                  searchPageBloc.clearSearch(context);
                },
              ),
        object.products.length > 0
            ? TitleWidget(
                title: "Products",
                padding: Constant.padding.copyWith(bottom: 15),
                onTap: () {
                  searchPageBloc.openProductList(context);
                })
            : Utils.blankSliver(),
        SliverAnimatedSwitcher(
          child: Utils.productsList(object.products, null),
          duration: Duration(milliseconds: Constant.load),
        ),
        object.business.length > 0
            ? TitleWidget(
                title: "Supermarkets",
                padding: Constant.padding.copyWith(top: 15, bottom: 15),
                onTap: null)
            : Utils.blankSliver(),
        Utils.businessList(object.business),
        Utils.endOfSliver()
      ],
    );
  }
}
