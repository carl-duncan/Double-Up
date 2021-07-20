import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:double_up/pages/customer/navigator/navigate.dart';
import 'package:double_up/pages/login/login_page.dart';
import 'package:double_up/pages/wrapper/wrapper_bloc.dart';
import 'package:double_up/repositories/repository.dart';
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
    Repository.initClient();
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
          if (snapshot.hasData) {
            print(snapshot.data);
            return CustomerNavigate(
              username: null,
              password: null,
            );
          }

          return LoginPage();
        });
  }
}
