import 'package:flutter/material.dart';

import '../../../common/color_value.dart';

class ListToko extends StatefulWidget {
  const ListToko({Key? key}) : super(key: key);

  @override
  State<ListToko> createState() => _ListTokoState();
}

class _ListTokoState extends State<ListToko> {

  bool isSearching = false;
  String searchText = '';

  List<String> originalList = [
    "Toko 1",
    "Toko 2",
    "Toko 3",
    "Toko 4",
    "Toko 5",
    "Toko 6",
    "Toko 7",
    "Toko 8",
    "Toko 9",
    "Toko 10",
    "Toko 11",
    "Toko 12",
    "Toko 13",
    "Toko 14",
    "Toko 15",
  ];

  List<String> filteredList = [];

  int currentPage = 1;
  final int itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    filteredList = originalList;
  }

  void searchToko(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        filteredList = originalList;
        isSearching = false;
      } else {
        filteredList = originalList
            .where((toko) => toko.toLowerCase().contains(searchText.toLowerCase()))
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

  List<String> getNextPageItems() {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    final totalItems = isSearching ? filteredList.length : originalList.length;

    if (currentPage == getPageCount()) {
      return isSearching ? filteredList.sublist(startIndex) : originalList.sublist(startIndex);
    } else {
      return isSearching ? filteredList.sublist(startIndex, endIndex) : originalList.sublist(startIndex, endIndex);
    }
  }

  List<String> getCurrentPageItems() {
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
      body: SingleChildScrollView(
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
                  _gridToko("Jumlah Toko", "assets/images/store.png", "15"),
                  _gridToko("Jumlah Produk", "assets/images/products.png", "100"),
                  _gridToko("Jumlah Pelanggan", "assets/images/rating.png", "1000"),
                  _gridToko("Jumlah Pesanan", "assets/images/cargo.png", "10000"),
                ],
              ),
              const SizedBox(height: 20),
              //container list toko dan search serta hanya list toko yang bisa di scroll
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xFFEEEEEE),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //search and list toko dan hanya bisa scroll list toko
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: TextField(
                        onChanged: (value){
                          setState(() {
                            searchText = value;
                          });
                          searchToko(value);
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
                          prefixIcon: Icon(
                            Icons.search,
                            color: ColorValue.neutralColor,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: ElevatedButton(
                              onPressed: (){
                                searchToko(searchText);
                                print("Cari Toko");
                              },
                              child: Text(
                                "Cari Toko",
                                style: textTheme.bodyText1!.copyWith(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: ColorValue.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide.none,
                                ),
                              ),
                            ),
                          )
                        ),
                        //pojok kanan ada button cari
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: getCurrentPageItems().length,
                      itemBuilder: (context, index) {
                        String tokoName = getCurrentPageItems()[index];

                        return InkWell(
                          onTap: () {
                            print("Toko $tokoName");
                          },
                          child: _listToko(
                            tokoName,
                            "assets/images/store.png",
                            "Jl. $tokoName",
                            "10",
                          ),
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
                  Text(
                    name,
                    style: textTheme.bodyText1!.copyWith(
                      color: ColorValue.neutralColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    total,
                    style: textTheme.bodyText1!.copyWith(
                      color: ColorValue.neutralColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _listToko(String name, String image, String address, String total){
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
              ),
            ),
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
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ),
      ),
    );
  }
}
