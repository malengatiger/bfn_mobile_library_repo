import 'package:bfnlibrary/data/user.dart';
import 'package:bfnlibrary/ui/wallet/wallet_dashboard.dart';
import 'package:bfnlibrary/util/fb_util.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:page_transition/page_transition.dart';

import '../user_list.dart';

class SigninMobile extends StatefulWidget {
  @override
  _SigninMobileState createState() => _SigninMobileState();
}

class _SigninMobileState extends State<SigninMobile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  BFNUser user;

  @override
  void initState() {
    p('🥦 _SigninMobileState: 🥦 🥦 🥦 initState ..............');
    _controller = AnimationController(vsync: this);
    super.initState();
    _checkStatus();
  }

  void _checkStatus() async {
    p('🥦 _SigninMobileState: ............... 🔷 🔷 _checkStatus from .env ....');
    await DotEnv().load('.env');
    var status = DotEnv().env['status'];
    if (status == 'dev') {
      p('🥦 _SigninMobileState: _checkStatus from .env ....status is dev: 🤟 $status');
      user = await Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.topLeft,
          duration: Duration(seconds: 1),
          child: UserList(
            quitOnTapped: true,
          ),
        ),
      );
      p('🥦 _SigninMobileState: UserList has returned ... 🥦 ${user == null ? 'NOPE' : user.accountInfo.name} 🔷 ... will set state');
      setState(() {
        if (user != null) {
          emailController.text = user.email;
          passwordController.text = 'pass123';
        }
      });
    } else {
      p('🥦 _SigninMobileState: status is prod; 🔷 🔷 $status');
    }
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
          title: Text(
            'BFN Mobile SignIn',
            style: Styles.whiteSmall,
          ),
          backgroundColor: Colors.indigo[300],
          bottom: PreferredSize(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Please use the credentials that have been emailed to you',
                      style: Styles.whiteSmall,
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
              preferredSize: Size.fromHeight(160)),
        ),
        backgroundColor: Colors.brown[100],
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: 'Email Address',
                          hintText: 'Please enter email address',
                          icon: Icon(Icons.email)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Please enter password',
                          icon: Icon(Icons.lock)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState.validate()) {
                          _startSignIn();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Submit',
                          style: Styles.whiteMedium,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startSignIn() async {
    if (emailController.text.isEmpty) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Missing email')));
      return;
    }
    if (passwordController.text.isEmpty) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Missing password')));
      return;
    }
    var res = await FireBaseUtil.signInUser(
        email: emailController.text, password: passwordController.text);
    p('🥦🥦 User may be signed in: displayName: 🥦🥦🥦 ${res.displayName}');
    if (res is User) {
      Navigator.pop(context);
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.topLeft,
          duration: Duration(seconds: 1),
          child: WalletDashboard(),
        ),
      );
    }
  }
}
