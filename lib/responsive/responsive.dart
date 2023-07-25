import 'package:admin_kangsayur/ui/auth/login/login.dart';
import 'package:admin_kangsayur/ui/sidebar/sidebar_navigation.dart';
import 'package:flutter/material.dart';

import '../ui/sidebar/toko/detail_toko.dart';

class ResponsivePage extends StatefulWidget {
  const ResponsivePage({Key? key}) : super(key: key);

  @override
  State<ResponsivePage> createState() => _ResponsivePageState();
}

class _ResponsivePageState extends State<ResponsivePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 1024) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Image.asset(
                'assets/images/responsive.png',
              ),
            ),
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
