import 'package:double_up/pages/profile/profile_page_bloc.dart';
import 'package:double_up/utils/const.dart';
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
      // appBar: navigationBar(context, "Dashboard"),
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
        navigationBar(context, "My Profile"),
        SliverPadding(
          padding: Constant.padding,
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                    "https://media.istockphoto.com/photos/portrait-of-smiling-handsome-man-in-blue-tshirt-standing-with-crossed-picture-id1045886560?k=6&m=1045886560&s=612x612&w=0&h=hXrxai1QKrfdqWdORI4TZ-M0ceCVakt4o6532vHaS3I="),
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
          subtitle: "All your receipts you claimed goes here!",
          onTap: null,
          padding: Constant.padding,
        ),
        TitleWidget(
          title: "Favourite Products",
          subtitle: "Your Favourite Products",
          onTap: null,
          padding: Constant.padding,
        ),
        TitleWidget(
          title: "Favourite Gift Cards",
          subtitle: "Your Favourite Gift Cards",
          onTap: null,
          padding: Constant.padding,
        )
      ],
    );
  }
}
