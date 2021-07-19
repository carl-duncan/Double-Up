import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/models/category.dart';
import 'package:double_up/utils/const.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;
  CategoryCard({Key key, @required this.category, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // IconData iconData = MaterialIcons.restaurant_menu;
    // print(iconData.fontFamily);
    // print(iconData.codePoint);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Hero(
            tag: category.id,
            child: Container(
              decoration: BoxDecoration(
                  color: Constant.secondary,
                  image: category.image != null
                      ? DecorationImage(
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.4),
                              BlendMode.colorBurn),
                          image: CachedNetworkImageProvider(
                            category.image,
                          ),
                          fit: BoxFit.cover)
                      : null),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          IconData(category.code,
                              fontFamily: category.family,
                              fontPackage: "flutter_icons"),
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${category.name}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
