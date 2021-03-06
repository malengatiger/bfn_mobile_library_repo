import 'package:bfnlibrary/data/purchase_order.dart';
import 'package:flutter/material.dart';

class PurchaseOrdersDesktop extends StatefulWidget {
  final ValueChanged<PurchaseOrder> onTapped;

  const PurchaseOrdersDesktop({Key key, this.onTapped}) : super(key: key);
  @override
  _PurchaseOrdersDesktopState createState() => _PurchaseOrdersDesktopState();
}

class _PurchaseOrdersDesktopState extends State<PurchaseOrdersDesktop>
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
