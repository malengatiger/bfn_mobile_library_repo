import 'package:bfnlibrary/data/user.dart';
import 'package:bfnlibrary/util/fb_util.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  final bool quitOnTapped;

  const UserList({Key key, @required this.quitOnTapped}) : super(key: key);
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var users = List<BFNUser>();

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _getUsers();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _getUsers() async {
    p('🔷 🔷 _getUsers: Getting users from Firestore ....');
    users = await FireBaseUtil.getBFNUsers();
    users.sort((a, b) => (a.accountInfo.name).compareTo(b.accountInfo.name));
    users.forEach((element) {
      p('🔷 🔷 User: 🤟 ${element.accountInfo.name}');
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Business Finance Network',
            style: Styles.whiteSmall,
          ),
          actions: [
            IconButton(icon: Icon(Icons.refresh), onPressed: _getUsers)
          ],
          bottom: PreferredSize(
              child: Column(
                children: [
                  Text(
                    'Registered BFN Users',
                    style: Styles.whiteBoldMedium,
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
              preferredSize: Size.fromHeight(80)),
        ),
        backgroundColor: Colors.brown[100],
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users.elementAt(index);
              return Card(
                elevation: 2,
                child: GestureDetector(
                  onTap: () {
                    if (widget.quitOnTapped) {
                      Navigator.pop(context, user);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.indigo,
                      ),
                      title: Text(user.accountInfo.name),
                      subtitle: Text(
                        user.email,
                        style: Styles.blackTiny,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
