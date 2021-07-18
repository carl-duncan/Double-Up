import 'package:double_up/pages/customer/search/search_page_bloc.dart';
import 'package:double_up/pages/loading_page.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/utils.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:double_up/widgets/text_field.dart';
import 'package:double_up/widgets/title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
      slivers: [
        navigationBar(context, "Search", object.notification.length),
        SliverPadding(
          padding: Constant.padding,
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
            Field(
                hint: "Search for Products, Gift Cards",
                controller: searchPageBloc.controller,
                label: null,
                onChanged: (String value) {
                  searchPageBloc.updateProducts(context, value);
                  searchPageBloc.updateGiftCards(context, value);
                },
                obscure: false,
                suffix: FontAwesome5Solid.search,
                enabled: true),
          ])),
        ),
        TitleWidget(
            title: "Categories",
            subtitle: "[TO BE FILLED OUT]",
            padding: Constant.padding.copyWith(top: 15, bottom: 10),
            onTap: null),
        Utils.categoryRow(object.category),
        TitleWidget(
            title: "Gift Cards",
            subtitle: "Search Results for : ${searchPageBloc.controller.text}",
            padding: Constant.padding.copyWith(bottom: 0),
            onTap: null),
        Utils.cardsList(object.giftCards),
        TitleWidget(
            title: "Products",
            subtitle: "Search Results for : ${searchPageBloc.controller.text}",
            padding: Constant.padding,
            onTap: null),
        Utils.productsList(object.products),
        TitleWidget(
            title: "Businesses",
            subtitle: "Search Results for : ${searchPageBloc.controller.text}",
            padding: Constant.padding.copyWith(top: 0),
            onTap: null),
        Utils.businessList(object.business)
      ],
    );
  }
}
