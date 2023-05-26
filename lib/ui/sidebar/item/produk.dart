import 'package:flutter/material.dart';

import '../../../common/color_value.dart';

class ProdukALlPage extends StatefulWidget {
  const ProdukALlPage({Key? key}) : super(key: key);

  @override
  State<ProdukALlPage> createState() => _ProdukALlPageState();
}

class _ProdukALlPageState extends State<ProdukALlPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'List dan Verifikasi Produk',
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
            'List dan Verifikasi Produk',
            style: TextStyle(fontSize: 35),
          ),
        ),
      ),
    );
  }
}
