import 'dart:io';

import 'package:double_up/pages/qr_scan/qr_scan_page_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({Key key}) : super(key: key);

  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  QrScanPageBLoc qrScanPageBLoc = QrScanPageBLoc();
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrScanPageBLoc.controller.pauseCamera();
    } else if (Platform.isIOS) {
      qrScanPageBLoc.controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CupertinoNavigationBar(
        border: null,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrScanPageBLoc.qrKey,
              onQRViewCreated: (controller) {
                qrScanPageBLoc.onQRViewCreated(controller, context);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    qrScanPageBLoc.dispose();
    super.dispose();
  }
}
