import 'package:admin_kangsayur/ui/sidebar/item/list_toko/bloc/list_toko_bloc.dart';
import 'package:admin_kangsayur/ui/sidebar/item/list_toko/event/list_toko_event.dart';
import 'package:admin_kangsayur/ui/sidebar/item/list_toko/repository/list_toko_repository.dart';
import 'package:admin_kangsayur/ui/sidebar/item/list_toko/state/list_toko_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/color_value.dart';
import '../../toko/detail_toko.dart';
import 'model/list_toko_model.dart';

class ListToko extends StatefulWidget {
  const ListToko({Key? key}) : super(key: key);

  @override
  State<ListToko> createState() => _ListTokoState();
}

class _ListTokoState extends State<ListToko> {

  bool isSearching = false;
  String searchText = '';
  late ListTokoPageBloc listTokoPageBloc;

  List<Datum> originalList = [];
  List<Datum> filteredList = [];


  int currentPage = 1;
  final int itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    filteredList = originalList;
    listTokoPageBloc = ListTokoPageBloc(listTokoRepository: ListTokoRepository());
  }

  void searchToko(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        filteredList = originalList;
        isSearching = false;
      } else {
        filteredList = originalList
            .where((toko) => toko.namaToko.toLowerCase().contains(searchText.toLowerCase()))
            .toList();
        isSearching = true;
      }
      currentPage = 1;
    });
  }

  int getPageCount() {
    return (filteredList.length / itemsPerPage).ceil();
  }

  void changePage(int page) {
    setState(() {
      currentPage += page;
      if (currentPage < 1) currentPage = 1;
      if (currentPage > getPageCount()) currentPage = getPageCount();
    });
  }

  List<Datum> getNextPageItems() {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    final totalItems = isSearching ? filteredList.length : originalList.length;

    if (currentPage == getPageCount()) {
      return isSearching ? filteredList.sublist(startIndex) : originalList.sublist(startIndex);
    } else {
      return isSearching ? filteredList.sublist(startIndex, endIndex) : originalList.sublist(startIndex, endIndex);
    }
  }

  List<Datum> getCurrentPageItems() {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    final totalItems = isSearching ? filteredList.length : originalList.length;

    if (currentPage == getPageCount()) {
      return isSearching ? filteredList.sublist(startIndex) : originalList.sublist(startIndex);
    } else {
      return isSearching ? filteredList.sublist(startIndex, endIndex) : originalList.sublist(startIndex, endIndex);
    }
  }


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
      body: BlocProvider(
        create: (context) => listTokoPageBloc..add(GetListToko()),
        child: BlocBuilder<ListTokoPageBloc, ListTokoPageState>(
          builder: (context, state) {
            if(state is ListTokoPageLoading){
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
            } else if(state is ListTokoPageLoaded){
              final listToko = state.listToko;
              filteredList = listToko.data;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 4,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 2,
                        children: [
                          _gridToko("Jumlah Toko", "assets/images/store.png", listToko.data.length.toString()),
                          _gridToko("Jumlah Produk", "assets/images/products.png", "100"),
                          _gridToko("Jumlah Pelanggan", "assets/images/rating.png", "1000"),
                          _gridToko("Jumlah Pesanan", "assets/images/cargo.png", "10000"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xFFEEEEEE),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                              child: TextField(
                                onChanged: (value){
                                  context.read<ListTokoPageBloc>().add(GetListDetailTokoBySearch(value));
                                },
                                decoration: InputDecoration(
                                    hintText: "Cari Toko",
                                    hintStyle: textTheme.bodyText1!.copyWith(
                                      color: ColorValue.neutralColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: ColorValue.neutralColor,
                                    ),
                                ),
                                //pojok kanan ada button cari
                              ),
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filteredList.length,
                              itemBuilder: (context, index) {
                                return _listToko(
                                  filteredList[index].namaToko.toString(),
                                  filteredList[index].imgProfile.toString(),
                                  filteredList[index].alamat.toString(),
                                      () {
                                    print("Toko ke $index");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailTokoPage(
                                          index: index + 1,
                                        ),
                                      ),
                                    );
                                  },
                                  context,
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: currentPage > 1 ? () => changePage(-1) : null,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorValue.primaryColor,
                                      ),
                                      child: const Icon(Icons.arrow_back)
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Halaman $currentPage dari ${getPageCount()}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                      onPressed: currentPage < getPageCount() ? () => changePage(1) : null,
                                      child: const Icon(Icons.arrow_forward),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorValue.primaryColor,
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if(state is ListDetailTokoPageFilter){
              filteredList = state.filteredListDetailTokoModel;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 4,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 2,
                        children: [
                          _gridToko("Jumlah Toko", "assets/images/store.png", filteredList.length.toString()),
                          _gridToko("Jumlah Produk", "assets/images/products.png", "100"),
                          _gridToko("Jumlah Pelanggan", "assets/images/rating.png", "1000"),
                          _gridToko("Jumlah Pesanan", "assets/images/cargo.png", "10000"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xFFEEEEEE),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                              child: TextField(
                                onChanged: (value){
                                  context.read<ListTokoPageBloc>().add(GetListDetailTokoBySearch(value));
                                },
                                decoration: InputDecoration(
                                    hintText: "Cari Toko",
                                    hintStyle: textTheme.bodyText1!.copyWith(
                                      color: ColorValue.neutralColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: ColorValue.neutralColor,
                                    ),
                                ),
                                //pojok kanan ada button cari
                              ),
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filteredList.length,
                              itemBuilder: (context, index) {
                                return _listToko(
                                  filteredList[index].namaToko.toString(),
                                  filteredList[index].imgProfile.toString(),
                                  filteredList[index].alamat.toString(),
                                      () {
                                    print("Toko ke $index");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailTokoPage(
                                          index: index + 1,
                                        ),
                                      ),
                                    );
                                  },
                                  context,
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: currentPage > 1 ? () => changePage(-1) : null,
                                      child: const Icon(Icons.arrow_back),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorValue.primaryColor,
                                      )
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Halaman $currentPage dari ${getPageCount()}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                      onPressed: currentPage < getPageCount() ? () => changePage(1) : null,
                                      child: const Icon(Icons.arrow_forward),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorValue.primaryColor,
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is ListTokoPageError){
              return const Center(
                child: Text("Terjadi kesalahan"),
              );
            } else {
              return const Center(
                child: Text("State tidak diketahui"),
              );
            }
          },
        )
      )
    );
  }


  Widget _gridToko(String name, String image, String total){
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(0xFFEEEEEE),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Stack(
                children: [
                  //background circle center
                  Flexible(
                    child: Container(
                      width: 80,
                      height: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        color: const Color(0xFFE0E0E0),
                      ),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(image),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      name,
                      style: textTheme.bodyText1!.copyWith(
                        color: ColorValue.neutralColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: Text(
                      total,
                      style: textTheme.bodyText1!.copyWith(
                        color: ColorValue.neutralColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _listToko(String name, String image, String address, VoidCallback onTap, BuildContext context){
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: Image.network("https://kangsayur.nitipaja.online/${image}").image,
              ),
              title: Text(
                name,
                style: textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                address,
                style: textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              trailing: IconButton(
                onPressed: (){},
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
          ),
        ),
      ),
    );
  }
}
