import 'package:double_up/models/customer.dart';
import 'package:double_up/pages/profile/profile_page_bloc.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/utils.dart';
import 'package:double_up/widgets/icon_button.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:double_up/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProfilePage extends StatelessWidget {
  final ProfilePageBloc profilePageBloc = ProfilePageBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: profilePageBloc.userSingleton.currentUser,
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

  loadUI(BuildContext context, Customer customer) {
    return CustomScrollView(
      slivers: [
        navigationBar(context, customer.name, 99),
        SliverPadding(
          padding: Constant.padding,
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(Repository.s3 + customer.picture),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: IconButtonWidget(
                      buttonText: "Edit Profile",
                      buttonColor: Constant.primary,
                      onPressed: () {},
                      icon: Icon(AntDesign.logout)),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: IconButtonWidget(
                      buttonText: "Sign Out",
                      buttonColor: Constant.primary,
                      onPressed: () {
                        profilePageBloc.signOut(context);
                      },
                      icon: Icon(AntDesign.logout)),
                ),
              ],
            )
          ])),
        ),
        TitleWidget(
          title: "Shopping History",
          subtitle: "[TO BE FILLED OUT]",
          onTap: null,
          padding: Constant.padding,
        ),
        TitleWidget(
          title: "Favourite Products",
          subtitle: "[TO BE FILLED OUT]",
          onTap: null,
          padding: Constant.padding.copyWith(bottom: 15),
        ),
        Utils.productsList(customer.favProducts),
        TitleWidget(
          title: "Favourite Gift Cards",
          subtitle: "[TO BE FILLED OUT]",
          onTap: null,
          padding: Constant.padding.copyWith(bottom: 15),
        ),
        Utils.detailedCardsList(customer.favCardsResolved, context)
      ],
    );
  }
}
