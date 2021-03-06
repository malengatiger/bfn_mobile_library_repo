import 'package:flutter/material.dart';

class SupplierPaymentsDesktop extends StatefulWidget {
  @override
  _SupplierPaymentsDesktopState createState() =>
      _SupplierPaymentsDesktopState();
}

class _SupplierPaymentsDesktopState extends State<SupplierPaymentsDesktop>
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
