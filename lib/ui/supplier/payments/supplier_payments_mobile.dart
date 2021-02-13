import 'package:bfnlibrary/api/bloc.dart';
import 'package:bfnlibrary/data/supplier_payment.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

class SupplierPaymentsMobile extends StatefulWidget {
  @override
  _SupplierPaymentsMobileState createState() => _SupplierPaymentsMobileState();
}

class _SupplierPaymentsMobileState extends State<SupplierPaymentsMobile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<SupplierPayment> _supplierPayments = [];
  final Bloc bloc = Bloc();

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _getData();
  }

  void _getData() async {
    p('🔵 _getData: getting data .... ');
    setState(() {
      isBusy = true;
    });
    await bloc.getSupplierPayments();
    setState(() {
      isBusy = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SupplierPayment>>(
        stream: bloc.supplierPaymentStream,
        builder: (context, snapshot) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Supplier Payments',
                  style: Styles.whiteSmall,
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: _getData,
                  )
                ],
              ),
              backgroundColor: Colors.brown[100],
              body: isBusy
                  ? Center(
                      child: Card(
                        elevation: 4,
                        child: Container(
                          width: 300,
                          height: 200,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text('Loading Supplier Payments'),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: CircularProgressIndicator(
                                  strokeWidth: 8,
                                  backgroundColor: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: _supplierPayments.length,
                            itemBuilder: (BuildContext context, int index) {
                              var payment = _supplierPayments.elementAt(index);
                              prettyPrint(
                                  payment.toJson(), "🍎 Supplier Payment 🍎");
                              return Card(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.payments,
                                    color: Colors.indigo[200],
                                  ),
                                  title: Text(
                                      payment.supplierProfile.account.name),
                                  subtitle: Text(
                                    payment.dateRegistered,
                                    style: Styles.blackTiny,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
            ),
          );
        });
  }
}
