import 'package:double_up/bloc/bloc.dart';
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
  dispose(){
    value.close();
  }
}

class CardViewBlocObject {
  String value;
  CardViewBlocObject({this.value});
}
