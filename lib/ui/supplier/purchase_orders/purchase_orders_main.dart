import 'package:bfnlibrary/api/bloc.dart';
import 'package:bfnlibrary/data/purchase_order.dart';
import 'package:bfnlibrary/data/user.dart';
import 'package:bfnlibrary/ui/supplier/purchase_orders/purchase_orders_desktop.dart';
import 'package:bfnlibrary/ui/supplier/purchase_orders/purchase_orders_mobile.dart';
import 'package:bfnlibrary/ui/supplier/purchase_orders/purchase_orders_tablet.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:bfnlibrary/util/prefs.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PurchaseOrdersMain extends StatefulWidget {
  final String supplierId, customerId;

  const PurchaseOrdersMain({Key key, this.supplierId, this.customerId})
      : super(key: key);
  @override
  _PurchaseOrdersMainState createState() => _PurchaseOrdersMainState();
}

class _PurchaseOrdersMainState extends State<PurchaseOrdersMain>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final Bloc bloc = Bloc();

  var isBusy = false;
  BFNUser user;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _getData() async {
    user = await Prefs.getUser();
    if (user == null) {
      throw Exception("User not found");
    }
    setState(() {
      isBusy = true;
    });
    await bloc.getPurchaseOrders(user.accountInfo.identifier);
    setState(() {
      isBusy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isBusy
        ? Container(
            color: Colors.brown[100],
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    'Loading Purchase Orders',
                    style: Styles.blackBoldMedium,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    width: 64,
                    height: 64,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.yellowAccent,
                      strokeWidth: 16,
                    ),
                  ),
                ],
              ),
            ),
          )
        : ScreenTypeLayout(
            mobile: PurchaseOrdersMobile(
              onTapped: _onTapped,
            ),
            tablet: PurchaseOrdersTablet(
              onTapped: _onTapped,
            ),
            desktop: PurchaseOrdersDesktop(
              onTapped: _onTapped,
            ),
          );
  }

  void _onTapped(PurchaseOrder purchaseOrder) {
    p(' 🔵  🔵 PurchaseOrder tapped: ${purchaseOrder.customer.name} ${purchaseOrder.amount}');
  }
}
