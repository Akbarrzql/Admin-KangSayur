import 'package:flutter/material.dart';

import '../../../common/color_value.dart';

class LaporanPengguna extends StatefulWidget {
  const LaporanPengguna({Key? key}) : super(key: key);

  @override
  State<LaporanPengguna> createState() => _LaporanPenggunaState();
}

class _LaporanPenggunaState extends State<LaporanPengguna> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Laporan Pengguna',
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
            'Laporan Pengguna',
            style: TextStyle(fontSize: 35),
          ),
        ),
      ),
    );
  }
}
