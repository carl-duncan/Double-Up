import 'package:double_up/models/user.dart';
import 'package:double_up/pages/code_page/code_page.dart';
import 'package:double_up/utils/transition.dart';
import 'package:flutter/cupertino.dart';

class SignUpPageBLoc {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  SignUpPageBLoc() {
    // name.text = "Carl Duncan";
    // email.text = "carlduncan64@gmail.com";
    // password.text = "Carlduncan123@";
  }

  goToCodeConfirm(BuildContext context) {
    Navigator.of(context).push(createRoute(CodePage(
      user: User(
          name: name.text.trim(),
          email: email.text.trim(),
          password: password.text.trim()),
    )));
  }

  dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
  }
}
