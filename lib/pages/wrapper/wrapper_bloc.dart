import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:double_up/repositories/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class WrapperBloc {
  BehaviorSubject<AuthUser> user = BehaviorSubject();

  WrapperBloc() {
    Repository.initClient();
    updateUser();
  }

  updateUser() async {
    user.add(await UserRepository.initApp());
  }

  dispose() {
    user.close();
  }
}
