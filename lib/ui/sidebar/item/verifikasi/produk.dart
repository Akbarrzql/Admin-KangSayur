import 'package:admin_kangsayur/common/color_value.dart';
import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/bloc/verfikasi_produk_bloc.dart';
import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/event/verifikasi_produk_event.dart';
import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/model/verifikasi_produk_model.dart';
import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/respository/verifikasi_produk_repository.dart';
import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/state/verfikasi_produk_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'detail_verifikasi/detail_verifikasi.dart';

class ProdukALlPage extends StatefulWidget {
  const ProdukALlPage({Key? key}) : super(key: key);

  @override
  State<ProdukALlPage> createState() => _ProdukALlPageState();
}

class _ProdukALlPageState extends State<ProdukALlPage> {
// Sample data for the table
  final List<Map<String, dynamic>> _data = List.generate(15, (index) {
    return {
      'id': index + 1,
      'nama': 'Produk ${index + 1}',
      'verifikasi': index % 2 == 0,
    };
  });

  late VerifikasiProdukPageBloc _verifikasiProdukPageBloc;
  bool isAscending = false;
  final int _rowsPerPage = 10; // Number of rows per page

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifikasiProdukPageBloc =  VerifikasiProdukPageBloc(verifikasiProdukRepository: VerifikasiProdukRepository());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocProvider(
        create: (context) => _verifikasiProdukPageBloc..add(GetListVerfikasi()),
        child: BlocBuilder<VerifikasiProdukPageBloc, VerfikasiProdukPageState>(
          builder: (context, state) {
            if(state is VerifikasiProdukPageLoading){
              return const Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(),
                    ),
                    SizedBox(height: 10,),
                    Text("Loading...")
                  ],
                ),
              );
            }else if (state is VerifikasiProdukPageLoaded){
              final data = state.verifikasiProduk;
              //return data table
              return data.data.length == 0 ? Center(
                //lotie loading
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50,),
                    Lottie.network("https://assets4.lottiefiles.com/packages/lf20_eogwvdor.json", width: 400, height: 400),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Saat ini belum ada produk yang ingin diverifikasi',
                        textAlign: TextAlign.center,
                        style: textTheme.headline6!.copyWith(
                            color: ColorValue.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                        ),
                      ),
                    )
                  ],
                ),
              ) : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  child: Container(
                    width: screenWidth,
                    child: PaginatedDataTable(
                      columnSpacing: 20,
                      dataRowHeight: 50,
                      columns: const [
                        DataColumn(label: Text('ID'), tooltip: 'ID'),
                        DataColumn(label: Text('Nama Toko'), tooltip: 'Nama Toko'),
                        DataColumn(label: Text('Status Verifikasi'), tooltip: 'Status Verifikasi'),
                        DataColumn(label: Text('Aksi'), tooltip: 'Aksi'),
                      ],
                      source: _ProdukDataSource(context, data),
                      rowsPerPage: _rowsPerPage,
                      availableRowsPerPage: const [5, 10, 15],
                      onPageChanged: (int pageIndex) {
                        // Perform any actions when the page is changed (optional)
                        print('Page changed to: $pageIndex');
                      },
                    ),
                  ),
                ),
              );
            }else if (state is VerifikasiProdukPageError){
              return const Center(
                child: Text("Terjadi kesalahan saat memuat data"),
              );
            }else {
              return const Center(
                child: Text("Terjadi kesalahan saat memuat data"),
              );
            }
          },
        ),
      ),
    );
  }
}

class _ProdukDataSource extends DataTableSource {
  _ProdukDataSource(this._context, this._data);

  final BuildContext _context;
  final VerifikasiProdukModel _data;

  @override
  DataRow? getRow(int index) {
    if (index >= _data.data.length) {
      return null;
    }
    final data = _data.data[index];
    return DataRow(
      cells: [
        DataCell(Text("${index + 1}")),
        DataCell(Text(data.namaProduk)),
        DataCell(
          data.status == "Pending" ? statusVerifikasi(const Color(0xFFFDF2B2), const Color(0xFFEB6D18), 'Belum Terverifikasi') : statusVerifikasi(const Color(0xFFD7FEDF), ColorValue.primaryColor, 'Terverifikasi'),
        ),
        DataCell(
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: _context,
                builder: (context) => DetailVerifikasiProduk(
                  data: data,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(100, 40),
              primary: ColorValue.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text('Detail'),
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => _data.data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

Widget statusVerifikasi(Color colorbg, Color colortext, String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    alignment: Alignment.center,
    height: 30,
    width: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: colorbg,
    ),
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: colortext,
      ),
    ),
  );
}