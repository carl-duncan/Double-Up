import 'package:double_up/pages/wrapper/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
  runApp(MyApp());
}

ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    cardColor: HexColor("#1E1E1E").withOpacity(0.2),
    scaffoldBackgroundColor: HexColor("#121212"),
    splashColor: Colors.transparent,
    appBarTheme: AppBarTheme(backgroundColor: Colors.black),
    textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        headline5: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)));

ThemeData light = ThemeData(
    brightness: Brightness.light,
    splashColor: Colors.transparent,
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey[20]),
    iconTheme: IconThemeData(color: Colors.blueGrey[900]),
    textTheme: TextTheme(
        headline6: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        headline5: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600)));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return OverlaySupport.global(
      child: MaterialApp(
        title: 'Double Up',
        themeMode: ThemeMode.system,
        theme: light,
        darkTheme: dark,
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
