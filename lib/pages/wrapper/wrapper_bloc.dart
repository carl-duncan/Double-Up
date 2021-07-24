import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:double_up/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class WrapperBloc {
  BehaviorSubject<AuthUser> user = BehaviorSubject();

  WrapperBloc(BuildContext context) {
    Repository.initClient();
    updateUser(context);
  }

  updateUser(BuildContext context) async {
    AuthUser user = await UserRepository.initApp(context);
    await Future.delayed(Duration(seconds: 3), () {
      this.user.add(user);
    });
  }

  dispose() {
    user.close();
  }
}
