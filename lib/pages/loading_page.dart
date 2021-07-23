import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  final logo;
  const LoadingPage({Key key, this.logo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo != null ? Utils.logo(context, width: 250.0) : Container(),
            logo != null
                ? SizedBox(
                    height: 10,
                  )
                : Container(),
            Container(
              height: 20,
              width: 20,
              child: Center(
                  child: CircularProgressIndicator(
                color: Constant.primary,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
