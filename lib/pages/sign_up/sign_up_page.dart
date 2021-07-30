import 'package:double_up/pages/login/login_page.dart';
import 'package:double_up/pages/sign_up/sign_up_page_bloc.dart';
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

class SignUpPage extends StatelessWidget {
  final SignUpPageBLoc signUpPageBLoc = SignUpPageBLoc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loadUI(context),
    );
  }

  loadUI(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // signUpPageBLoc.password.text = "Password123@";
    // signUpPageBLoc.email.text = "doubleuptestingacc@gmail.com";
    // signUpPageBLoc.name.text = "Carl Duncan";

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        navigationBarNormal(context, "Sign up"),
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
                    "Get rewards for shopping at participating supermarkets.",
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
                      hint: "Name",
                      controller: signUpPageBLoc.name,
                      obscure: false,
                      suffix: Octicons.person,
                      label: null,
                      enabled: true),
                  Field(
                      hint: "Email Address",
                      controller: signUpPageBLoc.email,
                      obscure: false,
                      suffix: Icons.email_outlined,
                      label: null,
                      enabled: true),
                  Field(
                      hint: "Password",
                      controller: signUpPageBLoc.password,
                      obscure: true,
                      suffix: Icons.password,
                      label: null,
                      enabled: true),
                  IconButtonWidget(
                      buttonText: "Sign up",
                      buttonColor: Constant.primary,
                      onPressed: () {
                        signUpPageBLoc.goToCodeConfirm(context);
                      },
                      icon: Icon(
                        AntDesign.login,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have account? "),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context, createRoute(LoginPage()));
                          },
                          child: Text(
                            "Sign in here!",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Constant.primary),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ]))
      ],
    );
  }
}
