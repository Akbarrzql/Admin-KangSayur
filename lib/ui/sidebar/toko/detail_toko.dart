import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../common/color_value.dart';
import '../../../contans/AppContants.dart';

class DetailTokoPage extends StatefulWidget {
  const DetailTokoPage({Key? key}) : super(key: key);

  @override
  State<DetailTokoPage> createState() => _DetailTokoPageState();
}

class _DetailTokoPageState extends State<DetailTokoPage> {

  var mapController = MapController();



  List<bool> isChecked = [false, false, false, false, false, false];
  List<String> categoryProduk = [
    "Sayuran",
    "Unggas",
    "Daging",
    "Buah-buahan",
    "Bahan Pokok",
    "Telur"
  ];


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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: ColorValue.neutralColor,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 400,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      //box shadow
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/images/ava_seller.png')
                            ),
                            const SizedBox(height: 10,),
                            const Text(
                              'Toko Bu Endah',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: ColorValue.neutralColor
                              ),
                            ),
                            const SizedBox(height: 10,),
                            const Text(
                              'tokobuendah@gmail.com',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: ColorValue.neutralColor
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                               Container(
                                 width: 100,
                                 padding: const EdgeInsets.all(10),
                                 decoration: BoxDecoration(
                                   color: const Color(0xffeeeeee),
                                   borderRadius: BorderRadius.circular(5),
                                 ),
                                 child: const Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                      Text(
                                        'Pengikut',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: ColorValue.neutralColor
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        '735',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: ColorValue.primaryColor
                                        ),
                                      ),
                                    ],
                                 ),
                               ),
                                const SizedBox(width: 20,),
                                Container(
                                  width: 100,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffeeeeee),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Produk',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: ColorValue.neutralColor
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        '100',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: ColorValue.primaryColor
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20,),
                  if (MediaQuery.sizeOf(context).width >= 1024 && MediaQuery.sizeOf(context).width < 1178)
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 450,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          //box shadow
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Deskripsi Toko",
                              style: textTheme.headline6!.copyWith(
                                color: ColorValue.primaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10,),
                            const Text(
                              "Toko Bu Endah adalah toko yang menjual berbagai macam jenis kue kering dan kue basah. Toko ini sudah berdiri sejak tahun 2000 dan sudah memiliki banyak pelanggan. Toko ini juga sudah memiliki banyak cabang di berbagai kota di Indonesia. Toko ini juga sudah memiliki sertifikat halal dari MUI. ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: ColorValue.neutralColor
                              ),
                            ),
                            const Divider(
                              color: ColorValue.hintColor,
                              thickness: 1,
                              height: 40,
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _componentToko("Alamat Toko", "Jl. Raya Bogor KM 30, Jakarta Timur"),
                                      const SizedBox(height: 20,),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            _tittleText("Jam Operasional"),
                                            const SizedBox(height: 10,),
                                            _descText("Senin - Jumat : 08.00 - 17.00"),
                                            _descText("Sabtu : 08.00 - 15.00"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _componentToko("Nomor Telepon", "08123456789"),
                                        const SizedBox(height: 20,),
                                        _componentToko("Status toko", "Aktif"),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _componentToko("Email", "tokobuendah@gmail.com" ),
                                        const SizedBox(height: 20,),
                                        _componentToko("Tanggal bergabung", " 23 April 2023"),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                        width: 200,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white,
                                          //box shadow
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: InkWell(
                                          onTap: (){
                                            //show dialog map screen
                                            _showDialogMapScreen();
                                          },
                                          child: FlutterMap(
                                            options: MapOptions(
                                              center: AppConstants.myLocation,
                                              zoom: 14.0,
                                              //launch url
                                              onTap: (tapPosition, point) {
                                                _showDialogMapScreen();
                                                print("tapPosition: $tapPosition, point: $point");
                                              },
                                            ),
                                            mapController: mapController,
                                            children: [
                                              TileLayer(
                                                urlTemplate: AppConstants.mapBoxStyleId,
                                                additionalOptions: const {
                                                  'accessToken': AppConstants.mapBoxAccessToken,
                                                  'id': 'mapbox.mapbox-streets-v8',
                                                  'mapStyleId': AppConstants.mapBoxStyleId
                                                },
                                              ),
                                              MarkerLayer(
                                                markers: [
                                                  Marker(
                                                    width: 80.0,
                                                    height: 80.0,
                                                    point: AppConstants.myLocation,
                                                    builder: (ctx) => const Icon(
                                                      Icons.location_pin,
                                                      size: 50,
                                                      color: ColorValue.primaryColor,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (MediaQuery.sizeOf(context).width >= 1178)
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          //box shadow
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Deskripsi Toko",
                              style: textTheme.headline6!.copyWith(
                                color: ColorValue.primaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10,),
                            const Text(
                              "Toko Bu Endah adalah toko yang menjual berbagai macam jenis kue kering dan kue basah. Toko ini sudah berdiri sejak tahun 2000 dan sudah memiliki banyak pelanggan. Toko ini juga sudah memiliki banyak cabang di berbagai kota di Indonesia. Toko ini juga sudah memiliki sertifikat halal dari MUI. ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: ColorValue.neutralColor
                              ),
                            ),
                            const Divider(
                              color: ColorValue.hintColor,
                              thickness: 1,
                              height: 40,
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _componentToko("Alamat Toko", "Jl. Raya Bogor KM 30, Jakarta Timur"),
                                      const SizedBox(height: 20,),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            _tittleText("Jam Operasional"),
                                            const SizedBox(height: 10,),
                                            _descText("Senin - Jumat : 08.00 - 17.00"),
                                            _descText("Sabtu : 08.00 - 15.00"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _componentToko("Nomor Telepon", "08123456789"),
                                        const SizedBox(height: 20,),
                                        _componentToko("Status toko", "Aktif"),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _componentToko("Email", "tokobuendah@gmail.com" ),
                                        const SizedBox(height: 20,),
                                        _componentToko("Tanggal bergabung", " 23 April 2023"),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                        width: 200,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white,
                                          //box shadow
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: InkWell(
                                          onTap: (){
                                            //show dialog map screen
                                            _showDialogMapScreen();
                                          },
                                          child: FlutterMap(
                                            options: MapOptions(
                                              center: AppConstants.myLocation,
                                              zoom: 14.0,
                                              //launch url
                                              onTap: (tapPosition, point) {
                                                _showDialogMapScreen();
                                                print("tapPosition: $tapPosition, point: $point");
                                              },
                                            ),
                                            mapController: mapController,
                                            children: [
                                              TileLayer(
                                                urlTemplate: AppConstants.mapBoxStyleId,
                                                additionalOptions: const {
                                                  'accessToken': AppConstants.mapBoxAccessToken,
                                                  'id': 'mapbox.mapbox-streets-v8',
                                                  'mapStyleId': AppConstants.mapBoxStyleId
                                                },
                                              ),
                                              MarkerLayer(
                                                markers: [
                                                  Marker(
                                                    width: 80.0,
                                                    height: 80.0,
                                                    point: AppConstants.myLocation,
                                                    builder: (ctx) => const Icon(
                                                      Icons.location_pin,
                                                      size: 50,
                                                      color: ColorValue.primaryColor,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10,),
              //produk and filter kategori
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      //box shadow
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(40),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Filter Kategori",
                            style: textTheme.headline6!.copyWith(
                              color: ColorValue.primaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10,),
                          const Text(
                            "Pilih kategori yang ingin ditampilkan",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: ColorValue.neutralColor
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Kategori Produk",
                                style: textTheme.headline6!.copyWith(
                                  color: ColorValue.primaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              _checkboxKategori("Sayuran", isChecked[0], (newValue) {
                                setState(() {
                                  isChecked[0] = newValue!;
                                });
                              }),
                              _checkboxKategori("Unggas", isChecked[1], (newValue) {
                                setState(() {
                                  isChecked[1] = newValue!;
                                });
                              }),
                              _checkboxKategori("Daging", isChecked[2], (newValue) {
                                setState(() {
                                  isChecked[2] = newValue!;
                                });
                              }),
                              _checkboxKategori("Bahan Pokok", isChecked[3], (newValue) {
                                setState(() {
                                  isChecked[3] = newValue!;
                                });
                              }),
                              _checkboxKategori("Buah Buahan", isChecked[4], (newValue) {
                                setState(() {
                                  isChecked[4] = newValue!;
                                });
                              }),
                              _checkboxKategori("telur", isChecked[5], (newValue) {
                                setState(() {
                                  isChecked[5] = newValue!;
                                });
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  if (MediaQuery.sizeOf(context).width < 1190)
                    Flexible(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        shrinkWrap: true,
                        children: [
                          _produk("assets/images/sayur_user.png", "Kangkung", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Apel Jepang", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Ayam Potong", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Daging Wagyu", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Ayam Potong", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Daging Wagyu", "Rp 10.000", "10"),
                        ],
                      ),
                    ),
                  if (MediaQuery.sizeOf(context).width < 1285 && MediaQuery.sizeOf(context).width > 1190)
                    Flexible(
                      child: GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.5,
                        shrinkWrap: true,
                        children: [
                          _produk("assets/images/sayur_user.png", "Kangkung", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Apel Jepang", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Ayam Potong", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Daging Wagyu", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Ayam Potong", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Daging Wagyu", "Rp 10.000", "10"),
                        ],
                      ),
                    ),
                  if (MediaQuery.sizeOf(context).width >= 1285 && MediaQuery.sizeOf(context).width < 1567)
                    Flexible(
                      child: GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.7,
                        shrinkWrap: true,
                        children: [
                          _produk("assets/images/sayur_user.png", "Kangkung", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Apel Jepang", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Ayam Potong", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Daging Wagyu", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Ayam Potong", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Daging Wagyu", "Rp 10.000", "10"),
                        ],
                      ),
                    ),
                  if (MediaQuery.sizeOf(context).width >= 1567 && MediaQuery.sizeOf(context).width < 2200)
                    Flexible(
                      child: GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        shrinkWrap: true,
                        children: [
                          _produk("assets/images/sayur_user.png", "Kangkung", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Apel Jepang", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Ayam Potong", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Daging Wagyu", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Ayam Potong", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Daging Wagyu", "Rp 10.000", "10"),
                        ],
                      ),
                    ),
                  if (MediaQuery.sizeOf(context).width >= 2200)
                    Flexible(
                      child: GridView.count(
                        crossAxisCount: 6,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        shrinkWrap: true,
                        children: [
                          _produk("assets/images/sayur_user.png", "Kangkung", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Apel Jepang", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Ayam Potong", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Daging Wagyu", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Ayam Potong", "Rp 10.000", "10"),
                          _produk("assets/images/sayur_user.png", "Daging Wagyu", "Rp 10.000", "10"),
                        ],
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }

  Widget _componentToko(String nameComponent, String descComponenet){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _tittleText(nameComponent),
        const SizedBox(height: 10,),
        _descText(descComponenet),
      ],
    );
  }

  Widget _tittleText(String name){
    final textTheme = Theme.of(context).textTheme;
    return Text(
      name,
      style: textTheme.headline6!.copyWith(
        color: ColorValue.primaryColor,
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    );
  }

  Widget _descText(String desc){
    return Text(
      desc,
      style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: ColorValue.neutralColor
      ),
    );
  }

  Widget _checkboxKategori(String nameKategori, bool value, void Function(bool?)? onChanged) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged != null ? (newValue) => onChanged(newValue) : null,
        ),
        Text(
          nameKategori,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorValue.neutralColor,
          ),
        ),
      ],
    );
  }

  Widget _produk (String image, String name, String price, String stock){
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(
              image,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: textTheme.headline6!.copyWith(
                    color: ColorValue.neutralColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 10,),
                Text(
                  price,
                  style: textTheme.headline6!.copyWith(
                    color: ColorValue.primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  "Stok : $stock",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorValue.neutralColor
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  //show dialog MapScreen
  void _showDialogMapScreen() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Lokasi Toko"),
          content: Container(
            width: double.maxFinite,
            height: 500,
            child: FlutterMap(
              options: MapOptions(
                center: AppConstants.myLocation,
                zoom: 14.0,
                onTap: (tapPosition, point) {
                  print("tapPosition: $tapPosition, point: $point");
                },
              ),
              mapController: mapController,
              children: [
                TileLayer(
                  urlTemplate: AppConstants.mapBoxStyleId,
                  additionalOptions: const {
                    'accessToken': AppConstants.mapBoxAccessToken,
                    'id': 'mapbox.mapbox-streets-v8',
                    'mapStyleId': AppConstants.mapBoxStyleId
                  },
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: AppConstants.myLocation,
                      builder: (ctx) => const Icon(
                        Icons.location_pin,
                        size: 50,
                        color: ColorValue.primaryColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Selesai",
                style: TextStyle(
                  color: ColorValue.primaryColor,
                  fontSize: 18
                ),
              ),
            ),
            //launch to maps google
            TextButton(
              onPressed: () {
                launch('https://www.google.com/maps/dir/?api=1&destination=${AppConstants.myLocation.latitude},${AppConstants.myLocation.longitude}');
              },
              child: const Text(
                "Rute Lokasi",
                style: TextStyle(
                  color: ColorValue.primaryColor,
                  fontSize: 18
                ),
              ),
            ),
          ],
        );
      },
    );
  }

}
