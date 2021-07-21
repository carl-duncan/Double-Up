import 'dart:async';

import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanPageBLoc extends Bloc {
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  StreamSubscription subscription;

  redeemQrCode(String transactionID) async {
    String redeemed = await Repository.redeemGiftCard(transactionID);
    userSingleton.updateCurrentUser();
  }

  void onQRViewCreated(QRViewController controller, BuildContext context) {
    this.controller = controller;

    subscription = controller.scannedDataStream.listen((scanData) async {
      if (scanData.code != null) {
        await redeemQrCode(scanData.code);
      }
      dispose();
      // Navigator.pop(context);
    });
  }

  dispose() {
    subscription.cancel();
    controller.dispose();
  }
}
