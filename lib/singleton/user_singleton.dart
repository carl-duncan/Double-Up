import 'package:double_up/models/category.dart';
import 'package:double_up/models/customer.dart';
import 'package:double_up/models/notification.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:rxdart/rxdart.dart';

class UserSingleton {
  static final UserSingleton _singleton = UserSingleton._internal();
  BehaviorSubject<List<Category>> categories = BehaviorSubject();
  BehaviorSubject<List<AppNotifications>> notifications = BehaviorSubject();
  BehaviorSubject<Customer> currentUser = BehaviorSubject();
  static String userId = "36fe4922-3792-4b92-8cfd-86f9eb20dfff";

  updateCategories() async {
    List<Category> categories = await Repository.getCategories();
    this.categories.add(categories);
  }

  updateCurrentUser() async {
    Customer customer = await Repository.getUser(userId);
    currentUser.add(customer);
  }

  updateNotifications() async {
    List<AppNotifications> notifications =
        await Repository.getNotifications(userId);
    this.notifications.add(notifications);
  }

  dispose() {
    print("UserSingleton.dispose");
    categories.close();
    currentUser.close();
    notifications.close();
  }

  factory UserSingleton() {
    return _singleton;
  }

  UserSingleton._internal() {
    updateCategories();
    updateNotifications();
    updateCurrentUser();
  }
}
