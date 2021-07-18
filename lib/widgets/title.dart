import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title, subtitle;
  final VoidCallback onTap;
  final EdgeInsets padding;
  const TitleWidget(
      {Key key,
      @required this.title,
      @required this.subtitle,
      @required this.onTap,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding,
      sliver: SliverList(
        delegate: SliverChildListDelegate.fixed([
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  subtitle != null
                      ? Text(
                          subtitle,
                          style: Theme.of(context)
                              .textTheme
                              .overline
                              .copyWith(color: Colors.grey),
                        )
                      : Container()
                ],
              ),
              Spacer(),
              onTap != null
                  ? InkWell(
                      child: Text(
                        "See All",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onTap: onTap,
                    )
                  : Container()
            ],
          )
        ]),
      ),
    );
  }
}
