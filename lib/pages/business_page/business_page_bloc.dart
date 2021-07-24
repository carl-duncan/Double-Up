import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/models/business.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/pages/product_list_page/product_list_page.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:double_up/utils/transition.dart';
import 'package:flutter/cupertino.dart';
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

  openProductList(BuildContext context, Business business) {
    Navigator.of(context, rootNavigator: true).push(createRoute(ProductListPage(
      function: Repository.searchProductsByBusiness(business.id),
      title: business.name,
    )));
  }

  dispose() {
    products.close();
  }
}

class BusinessPageBlocObject {
  List<Product> products;

  BusinessPageBlocObject({this.products});
}
