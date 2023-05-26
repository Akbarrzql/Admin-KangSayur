import 'package:admin_kangsayur/common/color_value.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: textTheme.headline6!.copyWith(
            color: ColorValue.neutralColor,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          )
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text(
            'Dashboard',
            style: TextStyle(fontSize: 35),
          ),
        ),
      ),
    );
  }
}
