import 'package:double_up/utils/const.dart';
import 'package:double_up/widgets/icon_button.dart';
import 'package:double_up/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        border: null,
      ),
      body: loadUI(context),
    );
  }

  loadUI(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Padding(
        padding: Constant.padding,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: size.height * 0.05, top: size.height * 0.05),
              child: CircleAvatar(
                radius: size.height * 0.1,
                backgroundColor: Constant.primary,
              ),
            ),
            Text(
              "[Tag Line here]",
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et sodales risus. Integer finibus dui diam, molestie varius enim elementum posuere.",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Field(
                hint: "Email Address",
                controller: null,
                obscure: false,
                suffix: Icons.email_outlined,
                label: null,
                enabled: true),
            Field(
                hint: "Password",
                controller: null,
                obscure: true,
                suffix: Icons.password,
                label: null,
                enabled: true),
            IconButtonWidget(
                buttonText: "Sign up",
                buttonColor: Constant.primary,
                onPressed: () {},
                icon: Icon(
                  AntDesign.login,
                )),
          ],
        ),
      ),
    );
  }
}