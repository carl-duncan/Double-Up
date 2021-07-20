import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:double_up/models/user.dart';
import 'package:double_up/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rxdart/rxdart.dart';

class CodePageBloc {
  BehaviorSubject<SignUpResult> signUpResult = BehaviorSubject();

  CodePageBloc(User user, BuildContext context) {
    updateSignUpResults(user, context);
  }

  updateSignUpResults(User user, BuildContext context) async {
    signUpResult.add(
        await UserRepository.signUp(user.name, user.email, user.password, (e) {
      toast(e.message);
      Navigator.pop(context);
    }));
  }

  dispose() {
    signUpResult.close();
  }
}
