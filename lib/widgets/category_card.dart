import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CategoryCard extends StatelessWidget {
  final String url;
  final String name;
  final VoidCallback onTap;
  CategoryCard({Key key, @required this.url, @required this.name, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            height: 50,
            width: 110,
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      url,
                    ),
                    fit: BoxFit.cover)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      MaterialCommunityIcons.food,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "$name",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
