import 'package:double_up/pages/customer/search/search_page_bloc.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/utils.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:double_up/widgets/text_field.dart';
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
            Widget child = Container();
            if (snapshot.hasData) child = loadUI(context, snapshot.data);
            return child;
          }),
    );
  }

  loadUI(BuildContext context, SearchPageBlocObject object) {
    return CustomScrollView(
      slivers: [
        navigationBar(context, "Search"),
        SliverPadding(
          padding: Constant.padding,
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
            Field(
                hint: "Search for Products, Gift Cards",
                controller: null,
                label: null,
                obscure: false,
                suffix: FontAwesome5Solid.search,
                enabled: true),
          ])),
        ),
        Utils.categoryRow(object.category),
        Utils.productsList(object.products)
      ],
    );
  }
}
