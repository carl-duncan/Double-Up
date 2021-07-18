import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/pages/login/login_page.dart';
import 'package:double_up/utils/transition.dart';
import 'package:flutter/cupertino.dart';

class ProfilePageBloc extends Bloc {
  signOut(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .pushReplacement(createRoute(LoginPage()));
    userSingleton.dispose();
  }
}
