import 'package:double_up/models/transaction.dart';
import 'package:double_up/pages/loading_page.dart';
import 'package:double_up/pages/transaction_list_page/transaction_list_page_bloc.dart';
import 'package:double_up/utils/const.dart';
import 'package:double_up/utils/utils.dart';
import 'package:double_up/widgets/navigation_bar_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionListPage extends StatefulWidget {
  final String title;
  final Future<List<Transaction>> function;
  const TransactionListPage(
      {Key key, @required this.function, @required this.title})
      : super(key: key);

  @override
  _TransactionListPageState createState() => _TransactionListPageState();
}

class _TransactionListPageState extends State<TransactionListPage> {
  TransactionListPageBloc transactionListPageBloc;
  @override
  void initState() {
    transactionListPageBloc = TransactionListPageBloc(widget.function);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: transactionListPageBloc.transactions,
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

  loadUI(BuildContext context, List<Transaction> transactions) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        navigationBarPushed(
          context,
          widget.title,
        ),
        Utils.transactionRow(transactions)
      ],
    );
  }
}
