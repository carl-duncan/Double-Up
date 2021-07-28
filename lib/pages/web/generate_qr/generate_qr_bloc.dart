import 'package:double_up/repositories/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class GenerateQRCodeBloc {
  BehaviorSubject<bool> loading = BehaviorSubject();
  BehaviorSubject<String> transaction = BehaviorSubject();
  CombineLatestStream combineLatestStream;

  GenerateQRCodeBloc(BuildContext context) {
    combineLatestStream = CombineLatestStream([loading, transaction], (obj) {
      return GenerateQRCodeBlocObject(loading: obj[0], transaction: obj[1]);
    });

    init(context);
  }

  init(BuildContext context) async {
    Repository.initClient();
    generateTransaction();
    updateLoading(false);
  }

  updateLoading(bool value) {
    loading.add(value);
  }

  generateTransaction() async {
    transaction.add(await Repository.generateRandomTransaction());
  }

  dispose() {
    loading.close();
    transaction.close();
  }
}

class GenerateQRCodeBlocObject {
  bool loading;
  String transaction;

  GenerateQRCodeBlocObject({this.loading, this.transaction});
}
