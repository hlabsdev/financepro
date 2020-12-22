import 'package:finance/mes-transactions.dart';
import 'package:finance/mon-agent.dart';
import 'package:flutter/material.dart';

import 'my-account.dart';

// class Utils(){

// }

class TabElement extends StatelessWidget {
  const TabElement({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      unselectedLabelColor: Colors.grey,
      labelColor: Colors.black54,
      tabs: [
        Tab(
          icon: Icon(Icons.account_balance),
          text: 'MyAcount',
        ),
        Tab(
          icon: Icon(Icons.account_box),
          text: 'MyAgent',
        ),
        Tab(
          icon: Icon(Icons.track_changes),
          text: 'Transactions',
        ),
      ],
    );
  }
}

class TabLister extends StatelessWidget {
  const TabLister({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        MyAccount(),
        Agent(),
        Transactions(),
      ],
    );
  }
}
