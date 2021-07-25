import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:double_up/singleton/user_singleton.dart';
import 'package:double_up/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:overlay_support/overlay_support.dart';

import '../amplifyconfiguration.dart';

class UserRepository {
  static configureAmplify() async {
    Amplify.addPlugin(AmplifyAuthCognito());

    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  static initApp(BuildContext context) async {
    try {
      await configureAmplify();
    } catch (e) {
      print("Already Configured");
    }
    try {
      return await isSignedIn((result) {
        UserSingleton().initStreams(result);
      });
    } catch (e) {
      print("Not Signed in");
    }

    await Utils.cacheLogo(context);

    return AuthUser(userId: null, username: null);
  }

  static confirmCode(String username, String code) async {
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: username, confirmationCode: code);
      return res;
    } on AuthException catch (e) {
      toast(e.message);
    }
  }

  static signUp(
      String name, String email, String password, Function onError) async {
    try {
      String id = await Repository.createUser(name);
      Map<String, String> userAttributes = {'email': email, "profile": id};
      SignUpResult res = await Amplify.Auth.signUp(
          username: email,
          password: password,
          options: CognitoSignUpOptions(userAttributes: userAttributes));
      toast("Please check your email for the confirmation code.");

      return res;
    } on AuthException catch (e) {
      onError(e);
    }
  }

  static signIn(String username, String password, Function onError,
      Function onSuccess) async {
    try {
      SignInResult res = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      onSuccess(await getUserAttributes());
      return res;
    } on AuthException catch (e) {
      onError(e);
    }
  }

  static Future<AuthUser> isSignedIn(Function onSuccess) async {
    AuthUser user = await Amplify.Auth.getCurrentUser();
    onSuccess(await getUserAttributes());
    return user;
  }

  static getUserAttributes() async {
    List<AuthUserAttribute> userAttribute =
        await Amplify.Auth.fetchUserAttributes();
    for (AuthUserAttribute attribute in userAttribute) {
      if (attribute.userAttributeKey == "profile") {
        UserSingleton.userId = attribute.value;
        return attribute.value;
      }
    }
  }

  static signOut() async {
    try {
      Amplify.Auth.signOut();
    } on AuthException catch (e) {
      print(e.message);
    }
  }
}
