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

  ProfilePageBloc(BuildContext context) {
    combineLatestStream = CombineLatestStream.combine2(
        userSingleton.notifications,
        customer,
        (b, c) => ProfilePageBlocObject(notifications: b, customer: c));
    updateCustomer(context);
  }

  signOut(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .pushReplacement(createRoute(LoginPage()));
    UserRepository.signOut();
    userSingleton.dispose();
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
  }
}

class ProfilePageBlocObject {
  List<AppNotifications> notifications;
  Customer customer;
  ProfilePageBlocObject({this.customer, this.notifications});
}
