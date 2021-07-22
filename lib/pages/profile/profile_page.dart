import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/pages/profile/profile_page_bloc.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/utils.dart';
import 'package:double_up/widgets/icon_button.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:double_up/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
            Widget child = Container();
            if (snapshot.hasData) child = loadUI(context, snapshot.data);
            return AnimatedSwitcher(
              duration: Duration(milliseconds: Constant.load),
              child: child,
            );
          }),
    );
  }

  loadUI(BuildContext context, ProfilePageBlocObject object) {
    TextStyle style = TextStyle(
        fontSize: 8, fontWeight: FontWeight.bold, color: Colors.black);
    return CustomScrollView(
      slivers: [
        navigationBar(
            context, object.customer.name, object.notifications.length),
        SliverPadding(
          padding: Constant.padding,
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: CircleAvatar(
                radius: 100,
                backgroundImage:
                    CachedNetworkImageProvider(object.customer.picture),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: IconButtonWidget(
                      buttonText: "Edit Profile",
                      buttonColor: Constant.secondary,
                      onPressed: () {},
                      icon: Icon(FontAwesome5Solid.edit)),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: IconButtonWidget(
                      buttonText: "Sign Out",
                      buttonColor: Constant.secondary,
                      onPressed: () {
                        profilePageBloc.signOut(context);
                      },
                      icon: Icon(AntDesign.logout)),
                ),
              ],
            )
          ])),
        ),
        // TitleWidget(
        //   title: "Shopping History",
        //   subtitle: "[TO BE FILLED OUT]",
        //   onTap: null,
        //   padding: Constant.padding,
        // ),
        object.customer.favProducts == null &&
                object.customer.favProducts == null &&
                object.customer.favCardsResolved.length == 0
            ? Utils.emtpyStateSliver()
            : Utils.blankSliver(),

        object.customer.favProducts != null
            ? TitleWidget(
                title: "Favourite Products",
                subtitle: "[TO BE FILLED OUT]",
                onTap: null,
                padding: Constant.padding.copyWith(bottom: 15),
              )
            : Utils.blankSliver(),
        object.customer.favProducts != null
            ? Utils.productsList(object.customer.favProducts, null)
            : Utils.blankSliver(),
        object.customer.favCardsResolved.length > 0
            ? TitleWidget(
                title: "Favourite Gift Cards",
                subtitle: "[TO BE FILLED OUT]",
                onTap: null,
                padding: Constant.padding.copyWith(bottom: 10),
              )
            : Utils.blankSliver(),
        object.customer.favCardsResolved != null
            ? Utils.detailedCardsList(object.customer.favCardsResolved, context)
            : Utils.blankSliver(),
        Utils.endOfSliver()
      ],
    );
  }
}
