import 'package:bfnlibrary/data/purchase_order.dart';
import 'package:flutter/material.dart';

class PurchaseOrdersMobile extends StatefulWidget {
  final List<PurchaseOrder> purchaseOrders;

  const PurchaseOrdersMobile(this.purchaseOrders);
  @override
  _PurchaseOrdersMobileState createState() => _PurchaseOrdersMobileState();
}

class _PurchaseOrdersMobileState extends State<PurchaseOrdersMobile>
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
