import 'package:bfnlibrary/api/bloc.dart';
import 'package:bfnlibrary/data/purchase_order.dart';
import 'package:bfnlibrary/data/user.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:bfnlibrary/util/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PurchaseOrdersMobile extends StatefulWidget {
  final ValueChanged<PurchaseOrder> onTapped;

  const PurchaseOrdersMobile({Key key, this.onTapped}) : super(key: key);
  @override
  _PurchaseOrdersMobileState createState() => _PurchaseOrdersMobileState();
}

class _PurchaseOrdersMobileState extends State<PurchaseOrdersMobile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<PurchaseOrder> _purchaseOrders = [];
  BFNUser user;
  final Bloc bloc = Bloc();

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _getData();
  }

  void _getData() async {
    user = await Prefs.getUser();
    if (user == null) {
      throw Exception("User not found");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Purchase Orders',
            style: Styles.whiteSmall,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                bloc.getPurchaseOrders(user.accountInfo.identifier);
              },
            ),
          ],
        ),
        backgroundColor: Colors.brown[100],
        body: StreamBuilder<List<PurchaseOrder>>(
            stream: bloc.purchaseOrderStream,
            initialData: _purchaseOrders,
            builder: (context, snapshot) {
              _purchaseOrders = snapshot.data;
              p('🔵  🔵  🔵  🔵  🔵  🔵 data from stream .... ${_purchaseOrders.length} purchaseOrders');
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  itemCount:
                      _purchaseOrders == null ? 0 : _purchaseOrders.length,
                  itemBuilder: (BuildContext context, int index) {
                    var po = _purchaseOrders.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        if (widget.onTapped != null) {
                          widget.onTapped(po);
                        }
                      },
                      child: Card(
                        child: ListTile(
                          leading: Text('${index + 1}'),
                          title: Text(po.customer.name),
                          subtitle: Text(po.supplier.name),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
      ),
    );
  }
}
