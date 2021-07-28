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
  GenerateQRCodeBloc generateQRCode;

  @override
  void initState() {
    // TODO: implement initState
    generateQRCode = GenerateQRCodeBloc(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(AssetImage("asset/4-01.png"), context);

    super.didChangeDependencies();
  }

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
          Image.asset(
            "asset/4-01.png",
            height: 100,
          ),
          Container(
            height: 200,
            child: QrImage(
              data: object.transaction.id,
              foregroundColor: Colors.white,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "${object.transaction.business.name}",
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(color: Constant.primary),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Please reload the page to generate a new QR code",
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
    );
  }
}
