import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:double_up/pages/customer/navigator/navigate.dart';
import 'package:double_up/pages/loading_page.dart';
import 'package:double_up/pages/login/login_page.dart';
import 'package:double_up/pages/wrapper/wrapper_bloc.dart';
import 'package:double_up/utils/const.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  WrapperBloc wrapperBloc = WrapperBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    wrapperBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthUser>(
        stream: wrapperBloc.user,
        builder: (context, snapshot) {
          Widget child = LoadingPage();
          if (snapshot.hasData) {
            child = CustomerNavigate(
              username: null,
              password: null,
            );
            if (snapshot.data.username == null) child = LoginPage();
          }
          return AnimatedSwitcher(
            duration: Duration(milliseconds: Constant.load),
            child: child,
          );
        });
  }
}
