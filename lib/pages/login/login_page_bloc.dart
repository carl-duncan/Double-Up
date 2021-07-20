import 'package:double_up/pages/customer/navigator/navigate.dart';
import 'package:double_up/repositories/user_repository.dart';
import 'package:double_up/utils/transition.dart';
import 'package:flutter/cupertino.dart';

class LoginPageBloc {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  LoginPageBloc() {
    email.text = "carlduncan64@gmail.com";
    password.text = "Carlduncan123@";
    // UserRepository.signOut();
  }
  signIn(BuildContext context) {
    Navigator.of(context).pushReplacement(createRoute(CustomerNavigate(
      username: email.text,
      password: password.text,
    )));
  }

  dispose() {
    email.dispose();
    password.dispose();
  }
}
