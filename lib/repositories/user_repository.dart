import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:double_up/singleton/user_singleton.dart';

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
    try {
      return await isSignedIn();
    } catch (e) {
      print("Not Signed in");
    }
    return AuthUser(userId: null, username: null);
  }

  static signUp(String email, String password, Function onError) async {
    try {
      Map<String, String> userAttributes = {
        'email': email,
        "profile": "36fe4922-3792-4b92-8cfd-86f9eb20dfff"
      };
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
      await getUserAttributes();
      return res;
    } on AuthException catch (e) {
      onError(e);
    }
  }

  static Future<AuthUser> isSignedIn() async {
    AuthUser user = await Amplify.Auth.getCurrentUser();
    await getUserAttributes();

    print("User $user");

    return user;
  }

  static getUserAttributes() async {
    List<AuthUserAttribute> userAttribute =
        await Amplify.Auth.fetchUserAttributes();
    for (AuthUserAttribute attribute in userAttribute) {
      if (attribute.userAttributeKey == "profile") {
        UserSingleton.userId = attribute.value;
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
