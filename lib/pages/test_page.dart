import 'package:double_up/widgets/icon_button.dart';
import 'package:double_up/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        middle: Text(
          "Dashboard",
          style: Theme.of(context).textTheme.headline6,
        ),
        trailing: Icon(
          FontAwesome5Solid.bell,
          size: 25,
        ),
        leading: Icon(
          FontAwesome5Solid.user,
          size: 25,
        ),
        border: null,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red,
              ),
              title: Text(
                "Test Title",
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text("Test Subtitle for the Test Title"),
              onTap: () {},
            ),
            IconButtonWidget(
                buttonText: "Sign in with Apple",
                buttonColor: Colors.black,
                onPressed: null,
                icon: Icon(
                  FontAwesome5Brands.apple,
                  color: Colors.white,
                )),
            Field(
                hint: "Field Hint",
                controller: null,
                obscure: false,
                suffix: FontAwesome5Solid.tools,
                label: "Test Label",
                enabled: true)
          ],
        ),
      ),
    );
  }
}
