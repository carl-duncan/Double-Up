import 'package:double_up/pages/sign_up/sign_up_page_bloc.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/transition.dart';
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

    return CustomScrollView(
      slivers: [
        navigationBarPushed(context, "Sign up"),
        SliverList(
            delegate: SliverChildListDelegate.fixed([
          Center(
            child: Padding(
              padding: Constant.padding,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.05),
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
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et sodales risus,",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.grey),
                    textAlign: TextAlign.center,
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
                            Navigator.pop(context);
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
