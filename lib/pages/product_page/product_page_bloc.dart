import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/models/customer.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:double_up/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:map_launcher/map_launcher.dart';

class ProductPageBloc extends Bloc {
  findLocation(Product product) async {
    final availableMaps = await MapLauncher.installedMaps;
    print(product.toJson());

    await availableMaps.first.showMarker(
      coords: Coords(product.business.x, product.business.y),
      title: product.business.name,
    );
  }

  addToFav(Product newProduct, BuildContext context) async {
    Customer user = await userSingleton.currentUser.first;
    bool condition = false;
    if (user.favProducts != null)
      for (Product product in user.favProducts) {
        if (product.id == newProduct.id) condition = true;
      }
    else
      user.favProducts = [];
    if (!condition) {
      user.favProducts.add(newProduct);
      sendNotification(
          message: "Added ${newProduct.name}",
          context: context,
          icon: FontAwesome5Solid.heart,
          color: Constant.green);
    } else {
      user.favProducts.removeWhere((element) => (element.id == newProduct.id));
      sendNotification(
          message: "Removed ${newProduct.name}",
          context: context,
          icon: FontAwesome5Solid.heart,
          color: Constant.secondary);
    }
    userSingleton.currentUser.add(user);
    String id = await Repository.updateFavProducts(user.favProducts, user.id);
  }

  getHeartColor(List<int> cards, String code) {}
}
