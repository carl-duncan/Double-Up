import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CategoryViewBloc extends Bloc {
  BehaviorSubject<List<Product>> products = BehaviorSubject();

  CategoryViewBloc(String id, BuildContext context) {
    updateProducts(id, context);
  }

  updateProducts(String id, BuildContext context) async {
    List<Product> objects = await Repository.getProductByCategory(id);
    for (Product obj in objects) {
      await precacheImage(
          CachedNetworkImageProvider(obj.images.first), context);
    }
    this.products.add(objects);
  }

  dispose() {
    products.close();
  }
}
