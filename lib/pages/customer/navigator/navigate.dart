import 'package:badges/badges.dart';
import 'package:double_up/pages/customer/dashboard/dashboard.dart';
import 'package:double_up/pages/customer/navigator/navigate_bloc.dart';
import 'package:double_up/pages/customer/rewards/rewards.dart';
import 'package:double_up/pages/customer/search/search_page.dart';
import 'package:double_up/pages/loading_page.dart';
import 'package:double_up/pages/profile/profile_page.dart';
import 'package:double_up/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CustomerNavigate extends StatefulWidget {
  final String username;
  final String password;
  const CustomerNavigate({Key key, this.username, this.password})
      : super(key: key);

  @override
  _CustomerNavigateState createState() => _CustomerNavigateState();
}

class _CustomerNavigateState extends State<CustomerNavigate> {
  List<Widget> pages = [];
  NavigateBloc navigateBloc;

  @override
  void initState() {
    navigateBloc = NavigateBloc(widget.username, widget.password, context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    navigateBloc.userSingleton.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: navigateBloc.signUpResult,
        builder: (context, snapshot) {
          Widget child = LoadingPage();
          if (snapshot.hasData) {
            child = loadUI();
          }
          return AnimatedSwitcher(
            duration: Duration(milliseconds: Constant.load),
            child: child,
          );
        });
  }

  loadUI() {
    if (pages.length == 0) {
      pages.add(CustomerDashboard());
      pages.add(SearchPage());
      pages.add(Rewards());
      pages.add(ProfilePage());
    }

    return Stack(
      children: <Widget>[
        CupertinoTabScaffold(
          resizeToAvoidBottomInset: false,
          tabBar: CupertinoTabBar(
            iconSize: 25,
            key: navigateBloc.userSingleton.globalKey,
            border: null,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            activeColor: Constant.primary,
            inactiveColor: Colors.grey,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: "Dashboard",
              ),
              BottomNavigationBarItem(
                icon: GestureDetector(
                  child: Icon(FontAwesome5Solid.search),
                ),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Badge(child: Icon(FontAwesome5Solid.gift)),
                label: "Rewards",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "My Profile",
              ),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            return CupertinoTabView(
              builder: (BuildContext context) {
                return Container(
                  child: pages[index],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
