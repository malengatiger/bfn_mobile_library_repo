import 'package:bfnlibrary/api/net_util.dart';
import 'package:bfnlibrary/data/node_info.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:bfnlibrary/util/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NetworkNodeList extends StatefulWidget {
  @override
  _NetworkNodeListState createState() => _NetworkNodeListState();
}

class _NetworkNodeListState extends State<NetworkNodeList>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<NodeInfo> nodes = [];

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _getNodes();
  }

  void _getNodes() async {
    nodes = await Net.getNetworkNodes();
    await Prefs.saveNodes(nodes);
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('BFN Network Nodes', style: Styles.whiteSmall),
            backgroundColor: Colors.brown[300],
            bottom: PreferredSize(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Tap to select the Network Node that you want to connect to',
                      style: Styles.whiteSmall,
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              preferredSize: Size.fromHeight(100),
            ),
          ),
          backgroundColor: Colors.brown[100],
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: nodes.length,
              itemBuilder: (BuildContext context, int index) {
                var node = nodes.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    p('🔵  🔵  🔵 Selected node: ${node.addresses.elementAt(0)}');
                    Navigator.pop(context, node);
                  },
                  child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Icon(Icons.network_check_rounded),
                          title: Text(node.addresses.elementAt(0)),
                          subtitle: Text(node.webServerAddress),
                        ),
                      )),
                );
              },
            ),
          )),
    );
  }
}
