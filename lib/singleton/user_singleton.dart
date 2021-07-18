import 'package:double_up/models/category.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:rxdart/rxdart.dart';

class UserSingleton {
  static final UserSingleton _singleton = UserSingleton._internal();
  BehaviorSubject<List<Category>> categories = BehaviorSubject();

  init() async {
    print("UserSingleton.init");
    updateCategories();
  }

  updateCategories() async {
    List<Category> categories = await Repository.getCategories();
    this.categories.add(categories);
  }

  dispose() {
    print("UserSingleton.dispose");
    categories.close();
  }

  factory UserSingleton() {
    return _singleton;
  }

  UserSingleton._internal() {
    updateCategories();
  }
}
