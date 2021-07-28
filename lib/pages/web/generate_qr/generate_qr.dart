import 'package:double_up/pages/loading_page.dart';
import 'package:double_up/pages/web/generate_qr/generate_qr_bloc.dart';
import 'package:double_up/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRCode extends StatefulWidget {
  const GenerateQRCode({Key key}) : super(key: key);

  @override
  _GenerateQRCodeState createState() => _GenerateQRCodeState();
}

class _GenerateQRCodeState extends State<GenerateQRCode> {
  GenerateQRCodeBloc generateQRCode = GenerateQRCodeBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: generateQRCode.combineLatestStream,
          builder: (context, snapshot) {
            Widget child = LoadingPage();
            if (snapshot.hasData) child = loadUI(context, snapshot.data);
            return AnimatedSwitcher(
              duration: Duration(milliseconds: Constant.load),
              child: child,
            );
          }),
    );
  }

  loadUI(BuildContext context, GenerateQRCodeBlocObject object) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            child: QrImage(
              data: object.transaction,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
