import 'package:bfnlibrary/ui/signin/signin_desktop.dart';
import 'package:bfnlibrary/ui/signin/signin_mobile.dart';
import 'package:bfnlibrary/ui/signin/signin_tablet.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Signin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: SigninMobile(),
      tablet: SigninTablet(),
      desktop: SigninDesktop(),
    );
  }
}
