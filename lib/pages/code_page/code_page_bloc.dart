import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:double_up/models/user.dart';
import 'package:double_up/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:overlay_support/overlay_support.dart';
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
      toast(e.message);
      Navigator.pop(context);
    }));
  }

  confirmCode(BuildContext context) async {
    SignUpResult signUpResult =
        await UserRepository.confirmCode(user.email, code.text);
    if (signUpResult != null) {
      Navigator.pop(context);
      Navigator.pop(context);
      toast(("Your Account has been successfully created"));
    }
  }

  dispose() {
    signUpResult.close();
  }
}
