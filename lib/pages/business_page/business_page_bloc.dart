import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:rxdart/rxdart.dart';

class BusinessPageBloc extends Bloc {
  BehaviorSubject<List<Product>> products = BehaviorSubject();
  CombineLatestStream combineLatestStream;
  BusinessPageBloc(String id) {
    combineLatestStream = CombineLatestStream([products], (objects) {
      return BusinessPageBlocObject(products: objects[0]);
    });
    updateProducts(id);
  }

  updateProducts(String id) async {
    List<Product> objects = await Repository.searchProductsByBusiness(id);
    products.add(objects);
  }

  dispose() {
    products.close();
  }
}

class BusinessPageBlocObject {
  List<Product> products;

  BusinessPageBlocObject({this.products});
}
