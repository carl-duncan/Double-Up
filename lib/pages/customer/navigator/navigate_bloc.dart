import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/pages/login/login_page.dart';
import 'package:double_up/repositories/user_repository.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class NavigateBloc extends Bloc {
  BehaviorSubject<SignInResult> signUpResult = BehaviorSubject();

  NavigateBloc(String username, String password, BuildContext context) {
    updateResults(username, password, context);
  }

  updateResults(String username, String password, BuildContext context) async {
    if (username == null && password == null) {
      signUpResult.add(SignInResult(isSignedIn: true));
      return;
    }
    signUpResult.add(await UserRepository.signIn(username, password, (e) {
      sendNotification(
          message: e.message,
          context: context,
          icon: Icons.error,
          color: Constant.red);
      Navigator.pushReplacement(context, createRoute(LoginPage()));
    }, (result) {
      userSingleton.initStreams(result);
    }));
  }

  dispose() {
    userSingleton.dispose();
    signUpResult.close();
  }
}
