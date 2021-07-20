import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/models/customer.dart';
import 'package:double_up/models/notification.dart';
import 'package:double_up/pages/login/login_page.dart';
import 'package:double_up/repositories/user_repository.dart';
import 'package:double_up/utils/transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class ProfilePageBloc extends Bloc {
  CombineLatestStream combineLatestStream;

  ProfilePageBloc() {
    combineLatestStream = CombineLatestStream.combine2(
        userSingleton.notifications,
        userSingleton.currentUser,
        (b, c) => ProfilePageBlocObject(notifications: b, customer: c));
  }
  signOut(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .pushReplacement(createRoute(LoginPage()));
    UserRepository.signOut();
    userSingleton.dispose();
  }
}

class ProfilePageBlocObject {
  List<AppNotifications> notifications;
  Customer customer;
  ProfilePageBlocObject({this.customer, this.notifications});
}
