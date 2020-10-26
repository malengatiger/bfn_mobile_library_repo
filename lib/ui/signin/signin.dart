import 'package:bfnlibrary/data/node_info.dart';
import 'package:bfnlibrary/ui/nodes/node_list.dart';
import 'package:bfnlibrary/ui/signin/signin_desktop.dart';
import 'package:bfnlibrary/ui/signin/signin_mobile.dart';
import 'package:bfnlibrary/ui/signin/signin_tablet.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:bfnlibrary/util/prefs.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  var isBusy = false;
  List<NodeInfo> nodes;
  NodeInfo node;
  @override
  void initState() {
    super.initState();
    _getNodes();
  }

  void _getNodes() async {
    node = await Prefs.getNode();
    if (node == null) {
      var mNode = await Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.topLeft,
          duration: Duration(seconds: 1),
          child: NetworkNodeList(),
        ),
      );
      if (mNode is NodeInfo) {
        p('🍊 🍊 🍊 Node returned to signIn ... ${mNode.addresses.elementAt(0)}');
        setState(() {
          node = mNode;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isBusy
        ? Container(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.teal,
                strokeWidth: 16,
              ),
            ),
          )
        : ScreenTypeLayout(
            mobile: SigninMobile(),
            tablet: SigninTablet(),
            desktop: SigninDesktop(),
          );
  }
}
