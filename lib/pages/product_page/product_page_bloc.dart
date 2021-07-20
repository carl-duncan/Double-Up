import 'package:double_up/bloc/bloc.dart';
import 'package:double_up/models/product.dart';
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
}
