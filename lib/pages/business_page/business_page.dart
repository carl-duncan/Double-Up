import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_up/models/business.dart';
import 'package:double_up/pages/business_page/business_page_bloc.dart';
import 'package:double_up/pages/loading_page.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/utils.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BusinessPage extends StatefulWidget {
  final Business business;
  const BusinessPage({Key key, this.business}) : super(key: key);

  @override
  _BusinessPageState createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  BusinessPageBloc businessPageBloc;

  @override
  void initState() {
    businessPageBloc = BusinessPageBloc(widget.business.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: businessPageBloc.combineLatestStream,
          builder: (context, snapshot) {
            Widget child = LoadingPage();
            if (snapshot.hasData) child = loadUI(context, snapshot.data);
            return AnimatedSwitcher(
              duration: Duration(milliseconds: Constant.load),
              child: child,
            );
          }),
    );
  }

  loadUI(BuildContext context, BusinessPageBlocObject object) {
    return CustomScrollView(
      slivers: [
        navigationBarPushed(context, ""),
        SliverPadding(
          padding: Constant.padding,
          sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Container(
                height: 150.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.contain,
                    image:
                        new CachedNetworkImageProvider(widget.business.image),
                  ),
                ),
              ),
            ),
            Text(
              widget.business.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              widget.business.address,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.grey),
            ),
          ])),
        ),
        Utils.productsList(object.products, widget.business.id)
      ],
    );
  }
}
