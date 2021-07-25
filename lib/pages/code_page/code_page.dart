import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:double_up/models/user.dart';
import 'package:double_up/pages/code_page/code_page_bloc.dart';
import 'package:double_up/pages/loading_page.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/widgets/icon_button.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:double_up/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CodePage extends StatefulWidget {
  final User user;
  const CodePage({Key key, this.user}) : super(key: key);

  @override
  _CodePageState createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  CodePageBloc codePageBloc;
  @override
  void initState() {
    codePageBloc = CodePageBloc(widget.user, context);
    super.initState();
  }

  @override
  void dispose() {
    codePageBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: codePageBloc.signUpResult,
          builder: (context, snapshot) {
            Widget child = LoadingPage();
            if (snapshot.hasData) {
              child = loadUI(context, snapshot.data);
            }
            return AnimatedSwitcher(
              duration: Duration(milliseconds: Constant.load),
              child: child,
            );
          }),
    );
  }

  loadUI(BuildContext context, SignUpResult result) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        navigationBarPushed(context, "Confirm Code"),
        SliverPadding(
          padding: Constant.padding,
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
            Field(
                hint: "Enter Code",
                controller: codePageBloc.code,
                obscure: false,
                suffix: Icons.confirmation_num,
                label: null,
                enabled: true),
            IconButtonWidget(
                buttonText: "Confirm",
                buttonColor: Constant.primary,
                onPressed: () {
                  codePageBloc.confirmCode(context);
                },
                icon: Icon(AntDesign.check))
          ])),
        )
      ],
    );
  }
}
