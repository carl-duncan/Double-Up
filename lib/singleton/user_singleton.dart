class UserSingleton {
  static final UserSingleton _singleton = UserSingleton._internal();

  init() async {
    print("UserSingleton.init");
  }

  dispose() {
    print("UserSingleton.dispose");
  }

  factory UserSingleton() {
    return _singleton;
  }

  UserSingleton._internal() {
    init();
  }
}
