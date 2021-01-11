import 'package:flutter/material.dart';

class RefreshableView extends StatelessWidget {
  final Widget child;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  final Future<Null> refreshPage;

  const RefreshableView({
    Key key,
    this.child,
    this.refreshIndicatorKey,
    this.refreshPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: () => refreshPage,
        child: Container(
          child: SingleChildScrollView(
            child: child,
          ),
        ));
  }
}
