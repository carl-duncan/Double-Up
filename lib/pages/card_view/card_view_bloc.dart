import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:rxdart/rxdart.dart';

class CardViewBloc extends Bloc {
  BehaviorSubject<String> value = BehaviorSubject();
  CombineLatestStream combineLatestStream;
  CardViewBloc(String initialValue) {
    combineLatestStream = CombineLatestStream([value], (a) {
      return CardViewBlocObject(value: a[0]);
    });
    value.add(initialValue);
  }

  updateValue(String value) {
    this.value.add(value);
  }

  sendGiftCard(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => NetworkGiffyDialog(
              image: CachedNetworkImage(
                imageUrl: Constant.dialog,
                fit: BoxFit.cover,
              ),
              title: Text('Scheduled Send?',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
              description: Text(
                'Would you like to schedule this message to be sent later?',
                textAlign: TextAlign.center,
              ),
              buttonCancelText: Text("No"),
              buttonOkText: Text("Yes"),
              onOkButtonPressed: () {},
            ));
  }

  dispose() {
    value.close();
  }
}

class CardViewBlocObject {
  String value;
  CardViewBlocObject({this.value});
}
