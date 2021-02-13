import 'package:bfnlibrary/data/purchase_order.dart';
import 'package:flutter/material.dart';

class PurchaseOrdersTablet extends StatefulWidget {
  final ValueChanged<PurchaseOrder> onTapped;

  const PurchaseOrdersTablet({Key key, this.onTapped}) : super(key: key);
  @override
  _PurchaseOrdersTabletState createState() => _PurchaseOrdersTabletState();
}

class _PurchaseOrdersTabletState extends State<PurchaseOrdersTablet>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
