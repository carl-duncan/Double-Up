import 'package:double_up/bloc/bloc.dart';

class NavigateBloc extends Bloc {
  dispose() {
    userSingleton.dispose();
  }
}
