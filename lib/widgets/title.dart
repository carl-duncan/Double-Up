import 'package:double_up/utils/const.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title, subtitle;
  final VoidCallback onTap;
  final EdgeInsets padding;
  const TitleWidget(
      {Key key,
      @required this.title,
      this.subtitle,
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
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle != null
                      ? Text(
                          subtitle,
                          style: Theme.of(context)
                              .textTheme
                              .overline
                              .copyWith(color: Colors.grey[600]),
                        )
                      : Container()
                ],
              ),
              Spacer(),
              onTap != null
                  ? InkWell(
                      child: Text(
                        "See More",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Constant.primary),
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
