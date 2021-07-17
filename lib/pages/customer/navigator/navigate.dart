import 'package:double_up/pages/customer/dashboard/dashboard.dart';
import 'package:double_up/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CustomerNavigate extends StatefulWidget {
  const CustomerNavigate({Key key}) : super(key: key);

  @override
  _CustomerNavigateState createState() => _CustomerNavigateState();
}

class _CustomerNavigateState extends State<CustomerNavigate> {
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loadUI();
  }

  loadUI() {
    pages = [];
    pages.add(CustomerDashboard());
    pages.add(Container());
    pages.add(Container());
    pages.add(Container());
    return Stack(
      children: <Widget>[
        CupertinoTabScaffold(
          resizeToAvoidBottomInset: false,
          tabBar: CupertinoTabBar(
            iconSize: 25,
            border: null,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            activeColor: Constant.primary,
            inactiveColor: Colors.grey,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(FontAwesome5Solid.tag),
                label: "Dashboard",
              ),
              BottomNavigationBarItem(
                icon: GestureDetector(
                  child: Icon(FontAwesome5Solid.search),
                ),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesome5Solid.gift),
                label: "Rewards",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.circle),
                label: "Space",
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
