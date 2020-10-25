import 'package:bfnlibrary/data/user.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

class SigninTablet extends StatefulWidget {
  final BFNUser user;

  const SigninTablet({Key key, this.user}) : super(key: key);
  @override
  _SigninTabletState createState() => _SigninTabletState();
}

class _SigninTabletState extends State<SigninTablet>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    p('🥦 SigninTablet: initState ..............');
    if (widget.user != null) {
      emailController.text = widget.user.email;
      passwordController.text = 'pass123';
    }
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
