import 'package:double_up/pages/test_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Double Up',
      themeMode: ThemeMode.system,
      theme: ThemeData(
          // fontFamily: GoogleFonts.robotoMono().fontFamily,
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
          // fontFamily: GoogleFonts.nunito().fontFamily,
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
      home: TestPage(),
    );
  }
}
