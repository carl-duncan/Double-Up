import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/pages/loading_page.dart';
import 'package:double_up/pages/profile/profile_page_bloc.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/refresh.dart' as refresh;
import 'package:double_up/utils/utils.dart';
import 'package:double_up/widgets/empty_state.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:double_up/widgets/title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfilePageBloc profilePageBloc;

  @override
  void initState() {
    profilePageBloc = ProfilePageBloc(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: profilePageBloc.combineLatestStream,
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

  loadUI(BuildContext context, ProfilePageBlocObject object) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        refresh.CupertinoSliverRefreshControl(),
        navigationBar(context, "My Profile", object.notifications.length),
        SliverPadding(
          padding: Constant.padding,
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: CircleAvatar(
                radius: 70,
                backgroundImage:
                    CachedNetworkImageProvider(object.customer.picture),
              ),
            ),
            Text(
              object.customer.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              object.username,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.grey),
            ),
          ])),
        ),
        TitleWidget(
          title: "Favourite Gift Cards",
          // subtitle: "[TO BE FILLED OUT]",
          onTap: null,
          padding: Constant.padding.copyWith(
              bottom: object.customer.favCardsResolved == null ||
                      object.customer.favCardsResolved.length == 0
                  ? 15
                  : 0),
        ),
        object.customer.favCardsResolved == null ||
                object.customer.favCardsResolved.length == 0
            ? EmptyState(
                title: "Find Gift Cards",
                onTap: () {
                  profilePageBloc.changeToDashboard();
                },
              )
            : Utils.cardsList(object.customer.favCardsResolved),
        TitleWidget(
          title: "Favourite Products",
          // subtitle: "[TO BE FILLED OUT]",
          onTap: null,
          padding: Constant.padding.copyWith(bottom: 15),
        ),
        object.customer.favProducts == null ||
                object.customer.favProducts.length == 0
            ? EmptyState(
                title: "Explore Products",
                onTap: () {
                  profilePageBloc.changePage();
                },
              )
            : Utils.productsList(object.customer.favProducts, null),
        SliverPadding(
          padding: Constant.padding,
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
            TextButton(
                onPressed: () {
                  profilePageBloc.signOut(context);
                },
                child: Text(
                  "Sign out",
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.red),
                )),
          ])),
        ),
        Utils.endOfSliver()
      ],
    );
  }
}
