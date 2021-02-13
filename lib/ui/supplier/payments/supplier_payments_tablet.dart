import 'package:flutter/material.dart';

class SupplierPaymentsTablet extends StatefulWidget {
  @override
  _SupplierPaymentsTabletState createState() => _SupplierPaymentsTabletState();
}

class _SupplierPaymentsTabletState extends State<SupplierPaymentsTablet>
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
