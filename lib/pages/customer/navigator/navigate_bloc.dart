import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/pages/code_page/code_page.dart';
import 'package:double_up/pages/login/login_page.dart';
import 'package:double_up/repositories/user_repository.dart';
import 'package:double_up/utils/transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:overlay_support/overlay_support.dart';
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
      print(e.message);
      toast(e.message);
      if (e.message == "User is not confirmed.") {
        Navigator.pushReplacement(context, createRoute(CodePage()));
      } else {
        Navigator.pushReplacement(context, createRoute(LoginPage()));
      }
    }));
  }

  dispose() {
    userSingleton.dispose();
    signUpResult.close();
  }
}
