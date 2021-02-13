import 'package:bfnlibrary/data/user.dart';
import 'package:bfnlibrary/ui/supplier/payments/supplier_payments_desktop.dart';
import 'package:bfnlibrary/ui/supplier/payments/supplier_payments_mobile.dart';
import 'package:bfnlibrary/ui/supplier/payments/supplier_payments_tablet.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SupplierPaymentsMain extends StatefulWidget {
  @override
  _SupplierPaymentsMainState createState() => _SupplierPaymentsMainState();
}

class _SupplierPaymentsMainState extends State<SupplierPaymentsMain>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool isBusy = false;
  BFNUser user;

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
    return isBusy
        ? Scaffold(
            appBar: AppBar(
              title: Text('Loading Payments ...'),
              bottom: PreferredSize(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
                preferredSize: Size.fromHeight(200),
              ),
            ),
            backgroundColor: Colors.brown[100],
            body: Center(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 8,
                    backgroundColor: Colors.teal,
                  ),
                ),
              ),
            ),
          )
        : ScreenTypeLayout(
            mobile: SupplierPaymentsMobile(),
            tablet: SupplierPaymentsTablet(),
            desktop: SupplierPaymentsDesktop(),
          );
  }
}
