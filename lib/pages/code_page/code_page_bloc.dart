import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:double_up/models/user.dart';
import 'package:double_up/pages/login/login_page.dart';
import 'package:double_up/repositories/user_repository.dart';
import 'package:double_up/utils/transition.dart';
import 'package:double_up/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class CodePageBloc {
  BehaviorSubject<SignUpResult> signUpResult = BehaviorSubject();
  TextEditingController code = TextEditingController();
  User user;

  CodePageBloc(User user, BuildContext context) {
    this.user = user;
    updateSignUpResults(user, context);
  }

  updateSignUpResults(User user, BuildContext context) async {
    signUpResult.add(
        await UserRepository.signUp(user.name, user.email, user.password, (e) {
      Utils.getToast(e.message);
      Navigator.pop(context);
    }));
  }

  confirmCode(BuildContext context) async {
    SignUpResult signUpResult =
        await UserRepository.confirmCode(user.email, code.text);
    if (signUpResult != null) {
      Navigator.pushReplacement(context, createRoute(LoginPage()));
      Utils.getToast(("Your Account has been successfully created"));
    }
  }

  dispose() {
    signUpResult.close();
  }
}
