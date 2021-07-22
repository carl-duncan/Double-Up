import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/models/product.dart';
import 'package:rxdart/rxdart.dart';

class ProductListPageBloc extends Bloc {
  BehaviorSubject<List<Product>> products = BehaviorSubject();
  Future<List<Product>> function;
  ProductListPageBloc(Future<List<Product>> function) {
    this.function = function;
    updateProducts();
  }

  updateProducts() async {
    products.add(await function);
  }

  dispose() {
    products.close();
  }
}
