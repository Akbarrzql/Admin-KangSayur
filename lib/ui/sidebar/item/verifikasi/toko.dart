import 'package:admin_kangsayur/common/color_value.dart';
import 'package:flutter/material.dart';

class TokoAllPage extends StatefulWidget {
  const TokoAllPage({Key? key}) : super(key: key);

  @override
  State<TokoAllPage> createState() => _TokoAllPageState();
}

class _TokoAllPageState extends State<TokoAllPage> {
// Sample data for the table
  final List<Map<String, dynamic>> _data = List.generate(15, (index) {
    return {
      'id': index + 1,
      'nama': 'Toko ${index + 1}',
      'verifikasi': index % 2 == 0,
    };
  });

  final int _rowsPerPage = 10; // Number of rows per page

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
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
              source: _ProdukDataSource(_data),
              rowsPerPage: _rowsPerPage,
              availableRowsPerPage: const [5, 10, 15],
              onPageChanged: (int pageIndex) {
                // Perform any actions when the page is changed (optional)
                print('Page changed to: $pageIndex');
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ProdukDataSource extends DataTableSource {
  _ProdukDataSource(this._data);

  final List<Map<String, dynamic>> _data;

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) {
      return null;
    }
    final data = _data[index];
    return DataRow(
      cells: [
        DataCell(Text(data['id'].toString())),
        DataCell(Text(data['nama'])),
        DataCell(
          data['verifikasi']
              ? statusVerifikasi(const Color(0xFFFDF2B2), const Color(0xFFEB6D18), 'Belum Terverifikasi')
              : statusVerifikasi(const Color(0xFFD7FEDF), ColorValue.primaryColor, 'Terverifikasi'),
        ),
        DataCell(
          ElevatedButton(
            onPressed: () {
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
  int get rowCount => _data.length;

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