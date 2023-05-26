import 'package:flutter/material.dart';

import '../../../common/color_value.dart';

class ListToko extends StatefulWidget {
  const ListToko({Key? key}) : super(key: key);

  @override
  State<ListToko> createState() => _ListTokoState();
}

class _ListTokoState extends State<ListToko> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'List Toko',
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
            'List Toko',
            style: TextStyle(fontSize: 35),
          ),
        ),
      ),
    );
  }
}
