import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/models/category.dart';
import 'package:double_up/repositories/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;
  CategoryCard({Key key, @required this.category, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconData = FontAwesome5Solid.apple_alt;
    print(iconData.fontFamily);
    print(iconData.codePoint);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                image: DecorationImage(
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.4), BlendMode.colorBurn),
                    image: CachedNetworkImageProvider(
                      Repository.s3 + category.image,
                    ),
                    fit: BoxFit.cover)),
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
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
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
