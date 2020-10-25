import 'package:bfnlibrary/data/user.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

class SigninDesktop extends StatefulWidget {
  final BFNUser user;

  const SigninDesktop({Key key, this.user}) : super(key: key);
  @override
  _SigninDesktopState createState() => _SigninDesktopState();
}

class _SigninDesktopState extends State<SigninDesktop>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    p('🥦 SigninDesktop: initState ..............');
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
