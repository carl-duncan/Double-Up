import 'package:double_up/pages/login/login_page_bloc.dart';
import 'package:double_up/pages/sign_up/sign_up_page.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/transition.dart';
import 'package:double_up/utils/utils.dart';
import 'package:double_up/widgets/icon_button.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:double_up/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginPageBloc loginPageBloc = LoginPageBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loadUI(context),
    );
  }

  loadUI(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        navigationBarNormal(context, "Log in"),
        SliverList(
            delegate: SliverChildListDelegate.fixed([
          Center(
            child: Padding(
              padding: Constant.padding,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 0, top: size.height * 0.1),
                    child: Utils.logo(context),
                  ),
                  Text(
                    "Exclusive Shoppers Club",
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "The Rewards App that rewards you something meaningful.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Field(
                      hint: "Email Address",
                      controller: loginPageBloc.email,
                      obscure: false,
                      suffix: Icons.email_outlined,
                      label: null,
                      enabled: true),
                  Field(
                      hint: "Password",
                      controller: loginPageBloc.password,
                      obscure: true,
                      suffix: Icons.password,
                      label: null,
                      enabled: true),
                  IconButtonWidget(
                      buttonText: "Sign in",
                      buttonColor: Constant.secondary,
                      onPressed: () {
                        loginPageBloc.signIn(context);
                      },
                      icon: Icon(
                        AntDesign.login,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont have an account? "),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacement(createRoute(SignUpPage()));
                        },
                        child: Text(
                          "Click here!",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Constant.primary),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ])),
      ],
    );
  }
}
