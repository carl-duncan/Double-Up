import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/models/customer.dart';
import 'package:double_up/models/notification.dart';
import 'package:double_up/pages/login/login_page.dart';
import 'package:double_up/repositories/user_repository.dart';
import 'package:double_up/utils/transition.dart';
import 'package:double_up/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class ProfilePageBloc extends Bloc {
  CombineLatestStream combineLatestStream;
  BehaviorSubject<Customer> customer = BehaviorSubject();
  BehaviorSubject<String> email = BehaviorSubject();

  ProfilePageBloc(BuildContext context) {
    combineLatestStream = CombineLatestStream.combine3(
        userSingleton.notifications,
        customer,
        email,
        (b, c, d) =>
            ProfilePageBlocObject(notifications: b, customer: c, username: d));
    updateCustomer(context);
    getCurrentUserEmail();
  }

  signOut(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .pushReplacement(createRoute(LoginPage()));
    UserRepository.signOut();
    userSingleton.dispose();
  }

  getCurrentUserEmail() async {
    List<AuthUserAttribute> userAttribute =
        await Amplify.Auth.fetchUserAttributes();
    for (AuthUserAttribute attribute in userAttribute) {
      if (attribute.userAttributeKey == "email") {
        email.add(attribute.value);
      }
    }
  }

  updateCustomer(BuildContext context) async {
    Customer customer = await userSingleton.currentUser.first;
    precacheImage(CachedNetworkImageProvider(customer.picture), context);
    this.customer.add(customer);
  }

  changePage() async {
    Utils.changeNavigationBarPage(userSingleton.globalKey, 1);
  }

  changeToDashboard() async {
    Utils.changeNavigationBarPage(userSingleton.globalKey, 0);
  }

  dispose() {
    customer.close();
    email.close();
  }
}

class ProfilePageBlocObject {
  List<AppNotifications> notifications;
  Customer customer;
  String username;
  ProfilePageBlocObject({this.customer, this.notifications, this.username});
}
