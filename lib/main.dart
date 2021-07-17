import 'package:double_up/pages/customer/navigator/navigate.dart';
import 'package:double_up/repositories/blinksky_repository.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Repository.initClient();
    BlinkSkyRepository.getCatalog(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Double Up',
      themeMode: ThemeMode.system,
      theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.grey[20],
          appBarTheme: AppBarTheme(backgroundColor: Colors.grey[20]),
          iconTheme: IconThemeData(color: Colors.blueGrey[900]),
          textTheme: TextTheme(
              headline6: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              headline5: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600))),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          cardColor: Colors.grey[900].withOpacity(0.3),
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(backgroundColor: Colors.black),
          textTheme: TextTheme(
              headline6: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              headline5: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600))),
      debugShowCheckedModeBanner: false,
      home: CustomerNavigate(),
    );
  }
}
