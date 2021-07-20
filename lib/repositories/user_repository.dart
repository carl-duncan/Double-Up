import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

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

  static initApp() async {
    try {
      await configureAmplify();
    } catch (e) {
      print("Already Configured");
    }
    return await isSignedIn();
  }

  static signUp(String email, String password, Function onError) async {
    try {
      Map<String, String> userAttributes = {'email': email};
      SignUpResult res = await Amplify.Auth.signUp(
          username: email,
          password: password,
          options: CognitoSignUpOptions(userAttributes: userAttributes));
      return res;
    } on AuthException catch (e) {
      onError(e);
    }
  }

  static signIn(String username, String password, Function onError) async {
    try {
      SignInResult res = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      return res;
    } on AuthException catch (e) {
      onError(e);
    }
  }

  static Future<AuthUser> isSignedIn() async {
    AuthUser user = await Amplify.Auth.getCurrentUser();
    print("User $user");

    return user;
  }

  static signOut() async {
    try {
      Amplify.Auth.signOut();
    } on AuthException catch (e) {
      print(e.message);
    }
  }
}
