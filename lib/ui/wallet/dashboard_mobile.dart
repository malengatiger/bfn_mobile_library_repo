// ignore: avoid_web_libraries_in_flutter

import 'package:bfnlibrary/data/node_info.dart';
import 'package:bfnlibrary/data/user.dart';
import 'package:bfnlibrary/ui/nodes/node_list.dart';
import 'package:bfnlibrary/ui/supplier/payments/supplier_payments_main.dart';
import 'package:bfnlibrary/ui/supplier/purchase_orders/purchase_orders_main.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:bfnlibrary/util/prefs.dart';
import 'package:bfnlibrary/util/stellar_lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart' as stellar;

class DashboardMobile extends StatefulWidget {
  @override
  _DashboardMobileState createState() => _DashboardMobileState();
}

class _DashboardMobileState extends State<DashboardMobile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  BFNUser user;
  stellar.AccountResponse accountResponse;
  bool isBusy = false;
  NodeInfo node;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _getNode();
    _getAccount();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _getAccount() async {
    setState(() {
      isBusy = true;
    });
    user = await Prefs.getUser();
    try {
      p('🍎 Stellar Asset: 🔷 🔷 trying to run'
          ' StellarUtility.getAccountResponse with user account:  🔷 🔷 ${user.stellarAccountId}');
      accountResponse =
          await StellarUtility.getAccountResponse(user.stellarAccountId);
      accountResponse.balances.forEach((element) {
        p('🍎 Stellar Asset: 🔷 🔷 ${element.assetCode} ${element.balance} '
            '🍊 issued by: ${element.assetIssuer}');
      });
    } catch (e) {
      p('🔵🔵🔵🔵🔵 Stellar account not available at this time 🔵');
      p(e);
    }
    setState(() {
      isBusy = false;
    });
    // await StellarUtility.getTransactions(user.stellarAccountId);
    // FireBaseUtil.getSupplierPayments(user.accountInfo.identifier);
    // FireBaseUtil.getInvestorPayments(user.accountInfo.identifier);
  }

  void _getNode() async {
    node = await Prefs.getNode();
    if (node == null) {
      node = await Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.topLeft,
          duration: Duration(seconds: 1),
          child: NetworkNodeList(),
        ),
      );
      if (node is NodeInfo) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[200],
        elevation: 0,
        title: Text(
          'BFN Wallet',
          style: Styles.whiteSmall,
        ),
        actions: [
          IconButton(
            onPressed: _getAccount,
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: _getAccount,
            icon: Icon(Icons.widgets_outlined),
          ),
        ],
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Account Balances',
                    style: Styles.whiteSmall,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  user == null
                      ? Container()
                      : Text(
                          user.accountInfo.name,
                          style: Styles.whiteBoldMedium,
                        ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(node == null
                      ? 'Network Node'
                      : node.addresses.elementAt(0)),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            preferredSize: Size.fromHeight(140)),
      ),
      backgroundColor: Colors.brown[100],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isBusy
            ? Center(
                child: Container(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    strokeWidth: 12,
                    backgroundColor: Colors.teal,
                  ),
                ),
              )
            : accountResponse == null
                ? Center(
                    child: Text('Stellar Wallet Unavailable'),
                  )
                : ListView.builder(
                    itemCount: accountResponse == null
                        ? 0
                        : accountResponse.balances.length,
                    itemBuilder: (context, index) {
                      var bal = accountResponse.balances.elementAt(index);
                      return Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_balance,
                                color: Colors.grey.shade300,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(bal.assetCode == null
                                  ? 'XLM'
                                  : bal.assetCode),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                getCurrency(accountResponse.balances
                                    .elementAt(index)
                                    .balance),
                                style: Styles.blackBoldMedium,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              label: 'Payments', icon: Icon(Icons.attach_money)),
          BottomNavigationBarItem(label: 'Offers', icon: Icon(Icons.backpack)),
          BottomNavigationBarItem(
              label: 'Purchase Orders', icon: Icon(Icons.dashboard)),
        ],
        onTap: _bottomNav,
      ),
    ));
  }

  void _bottomNav(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.topLeft,
            duration: Duration(seconds: 1),
            child: SupplierPaymentsMain(),
          ),
        );
        break;
      case 1:
        break;
      case 2:
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.topLeft,
            duration: Duration(seconds: 1),
            child: PurchaseOrdersMain(),
          ),
        );
        break;
    }
  }
}
