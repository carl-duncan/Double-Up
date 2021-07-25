import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/models/transaction.dart';
import 'package:rxdart/rxdart.dart';

class TransactionListPageBloc extends Bloc {
  BehaviorSubject<List<Transaction>> transactions = BehaviorSubject();
  Future<List<Transaction>> function;
  TransactionListPageBloc(Future<List<Transaction>> function) {
    this.function = function;
    updateProducts();
  }

  updateProducts() async {
    transactions.add(await function);
  }

  dispose() {
    transactions.close();
  }
}
