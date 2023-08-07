import 'package:admin_kangsayur/ui/sidebar/item/list_toko/bloc/list_toko_bloc.dart';
import 'package:admin_kangsayur/ui/sidebar/toko/bloc/list_toko_bloc.dart';
import 'package:admin_kangsayur/ui/sidebar/toko/bloc/produk_bloc/produk_bloc.dart';
import 'package:admin_kangsayur/ui/sidebar/toko/event/list_toko_event.dart';
import 'package:admin_kangsayur/ui/sidebar/toko/model/list_detail_toko_model.dart';
import 'package:admin_kangsayur/ui/sidebar/toko/repository/list_detail_toko_repository.dart';
import 'package:admin_kangsayur/ui/sidebar/toko/repository/produk_repository/produk_repository.dart';
import 'package:admin_kangsayur/ui/sidebar/toko/state/list_toko_state.dart';
import 'package:admin_kangsayur/ui/sidebar/toko/state/produk_state/produk_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../common/color_value.dart';
import '../../../contans/AppContants.dart';
import 'event/produk_event/produk_event.dart';
import 'model/produk_model.dart';

class DetailTokoPage extends StatefulWidget {
  const DetailTokoPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<DetailTokoPage> createState() => _DetailTokoPageState();
}

class _DetailTokoPageState extends State<DetailTokoPage> {

  var mapController = MapController();
  late ListDetailTokoPageBloc listDetailTokoPageBloc;


  List<bool> isChecked = [false, false, false, false, false, false];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listDetailTokoPageBloc = ListDetailTokoPageBloc(listTokoDetailPageRepository: ListDetailTokoRepository());
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
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => listDetailTokoPageBloc..add(GetListDetailToko(widget.index.toString())),
          ),
          BlocProvider(
            create: (context) => ProdukTokoBloc(produkTokoPageRepository: ProdukTokoRepository())..add(GetProduk(widget.index.toString(), "")),
          ),
        ],
        child:BlocBuilder<ListDetailTokoPageBloc, ListDetailTokoPageState>(
              builder: (context, state) {
                if(state is ListDetailTokoPageLoading){
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
                } else if (state is ListDetailTokoPageLoaded){
                  final data = state.listDetailTokoModel;
                  return SingleChildScrollView(
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
                                        Text(
                                          data.data.sellerInfo.namaSeller.toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: ColorValue.neutralColor
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        Text(
                                          data.data.sellerInfo.email,
                                          style: const TextStyle(
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
                              if (MediaQuery.sizeOf(context).width >= 1024 && MediaQuery.sizeOf(context).width < 1292)
                                Expanded(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 555,
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
                                        Text(
                                          data.data.tokoInfo.deksripsiToko,
                                          style: const TextStyle(
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
                                                  _componentToko("Alamat Toko", data.data.tokoInfo.alamatToko),
                                                  const SizedBox(height: 20,),
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        _tittleText("Jam Operasional"),
                                                        const SizedBox(height: 10,),
                                                        _descText("Senin - Jumat : ${data.data.tokoInfo.jamOperasional.open} - ${data.data.tokoInfo.jamOperasional.open}"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    _componentToko("Nomor Telepon", data.data.tokoInfo.nomorTelepon),
                                                    const SizedBox(height: 20,),
                                                    _componentToko("Status toko", data.data.tokoInfo.status),
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    _componentToko("Email", data.data.tokoInfo.email ),
                                                    const SizedBox(height: 20,),
                                                    _componentToko("Tanggal bergabung", data.data.tokoInfo.tanggalBergabung),
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
                                                        _showDialogMapScreen(
                                                          data.data.tokoInfo.titikKoordinat.latitude,
                                                          data.data.tokoInfo.titikKoordinat.longitude,
                                                        );
                                                      },
                                                      child: FlutterMap(
                                                        options: MapOptions(
                                                          center: LatLng(data.data.tokoInfo.titikKoordinat.latitude, data.data.tokoInfo.titikKoordinat.longitude),
                                                          zoom: 14.0,
                                                          //launch url
                                                          onTap: (tapPosition, point) {
                                                            _showDialogMapScreen(
                                                              data.data.tokoInfo.titikKoordinat.latitude,
                                                              data.data.tokoInfo.titikKoordinat.longitude,
                                                            );
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
                                                                point: LatLng(data.data.tokoInfo.titikKoordinat.latitude, data.data.tokoInfo.titikKoordinat.longitude),
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
                              if (MediaQuery.sizeOf(context).width >= 1292)
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
                                        Text(
                                          data.data.tokoInfo.deksripsiToko,
                                          style: const TextStyle(
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
                                                  _componentToko("Alamat Toko", data.data.tokoInfo.alamatToko),
                                                  const SizedBox(height: 20,),
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        _tittleText("Jam Operasional"),
                                                        const SizedBox(height: 10,),
                                                        _descText("Senin - Jumat : ${data.data.tokoInfo.jamOperasional.open} - ${data.data.tokoInfo.jamOperasional.open}"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    _componentToko("Nomor Telepon", data.data.tokoInfo.nomorTelepon),
                                                    const SizedBox(height: 20,),
                                                    _componentToko("Status toko", data.data.tokoInfo.status),
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    _componentToko("Email", data.data.tokoInfo.email ),
                                                    const SizedBox(height: 20,),
                                                    _componentToko("Tanggal bergabung", data.data.tokoInfo.tanggalBergabung),
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
                                                        _showDialogMapScreen(
                                                          data.data.tokoInfo.titikKoordinat.latitude,
                                                          data.data.tokoInfo.titikKoordinat.longitude,
                                                        );
                                                      },
                                                      child: FlutterMap(
                                                        options: MapOptions(
                                                          center: LatLng(data.data.tokoInfo.titikKoordinat.latitude, data.data.tokoInfo.titikKoordinat.longitude),
                                                          zoom: 14.0,
                                                          //launch url
                                                          onTap: (tapPosition, point) {
                                                            _showDialogMapScreen(
                                                              data.data.tokoInfo.titikKoordinat.latitude,
                                                              data.data.tokoInfo.titikKoordinat.longitude,
                                                            );
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
                                                                point: LatLng(data.data.tokoInfo.titikKoordinat.latitude, data.data.tokoInfo.titikKoordinat.longitude),
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
                                          ListView.builder(
                                            itemCount: data.data.kategori.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index){
                                              final int newIndex = index + 1;
                                              return _checkboxKategori(data.data.kategori[index].namaKategori, isChecked[index], (newValue) {
                                                setState(() {
                                                  isChecked[index] = newValue!;
                                                  if(isChecked[index] == true){
                                                    BlocProvider.of<ProdukTokoBloc>(context).add(GetProduk(widget.index.toString(), newIndex.toString()));
                                                  }else{
                                                    BlocProvider.of<ProdukTokoBloc>(context).add(GetProduk(widget.index.toString(), ""));
                                                  }
                                                });
                                              });
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20,),
                              if (MediaQuery.sizeOf(context).width < 1190)
                                BlocConsumer<ProdukTokoBloc, ProdukPageState>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    if(state is IsLoadingProduk){
                                      return const Padding(
                                        padding: EdgeInsets.fromLTRB(300, 160, 80, 70),
                                        child: Center(
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
                                        ),
                                      );
                                    }else if (state is IsLoadedProduk){
                                      final data = state.listProdukModel;
                                      return Flexible(
                                        child: GridView.builder(
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 20,
                                            mainAxisSpacing: 20,
                                          ),
                                          itemCount: data.produk.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index){
                                            return _produk("https://kangsayur.nitipaja.online${data.produk[index].variantImg}", data.produk[index].namaProduk,  data.produk[index].variantDesc, data.produk[index].hargaVariant.toString(), data.produk[index].stok.toString());
                                          },
                                        ),
                                      );
                                    } else if (state is IsErrorProduk){
                                      return Center(
                                        child: Text(state.error),
                                      );
                                    } else {
                                      return const Center(
                                        child: Text("Terjadi kesalahan"),
                                      );
                                    }
                                  },
                                ),
                              if (MediaQuery.sizeOf(context).width < 1285 && MediaQuery.sizeOf(context).width > 1190)
                                BlocConsumer<ProdukTokoBloc, ProdukPageState>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    if(state is IsLoadingProduk){
                                      return const Padding(
                                        padding: EdgeInsets.fromLTRB(250, 100, 80, 70),
                                        child: Center(
                                          child: Column(
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
                                        ),
                                      );
                                    }else if (state is IsLoadedProduk){
                                      final data = state.listProdukModel;
                                      return Flexible(
                                        child: GridView.builder(
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            crossAxisSpacing: 20,
                                            mainAxisSpacing: 20,
                                            childAspectRatio: 0.5,
                                          ),
                                          itemCount: data.produk.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index){
                                            return _produk("https://kangsayur.nitipaja.online${data.produk[index].variantImg}", data.produk[index].namaProduk, data.produk[index].variantDesc, data.produk[index].hargaVariant.toString(), data.produk[index].stok.toString());
                                          },
                                        ),
                                      );
                                    } else if (state is IsErrorProduk){
                                      return Center(
                                        child: Text(state.error),
                                      );
                                    } else {
                                      return const Center(
                                        child: Text("Terjadi kesalahan"),
                                      );
                                    }
                                  },
                                ),
                              if (MediaQuery.sizeOf(context).width >= 1285 && MediaQuery.sizeOf(context).width < 1567)
                                BlocConsumer<ProdukTokoBloc, ProdukPageState>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    if(state is IsLoadingProduk){
                                      return const Padding(
                                        padding: EdgeInsets.fromLTRB(500, 150, 80, 70),
                                        child: Center(
                                          child: Column(
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
                                        ),
                                      );
                                    }else if (state is IsLoadedProduk){
                                      final data = state.listProdukModel;
                                      return Flexible(
                                        child: GridView.builder(
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            crossAxisSpacing: 20,
                                            mainAxisSpacing: 20,
                                            childAspectRatio: 0.7,
                                          ),
                                          itemCount: data.produk.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index){
                                            return _produk("https://kangsayur.nitipaja.online${data.produk[index].variantImg}", data.produk[index].namaProduk, data.produk[index].variantDesc, data.produk[index].hargaVariant.toString(), data.produk[index].stok.toString());
                                          },
                                        ),
                                      );
                                    } else if (state is IsErrorProduk){
                                      return Center(
                                        child: Text(state.error),
                                      );
                                    } else {
                                      return const Center(
                                        child: Text("Terjadi kesalahan"),
                                      );
                                    }
                                  },
                                ),
                              if (MediaQuery.sizeOf(context).width >= 1567 && MediaQuery.sizeOf(context).width < 2200)
                                BlocConsumer<ProdukTokoBloc, ProdukPageState>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    if(state is IsLoadingProduk){
                                      return Container(
                                        padding: const EdgeInsets.fromLTRB(500, 200, 80, 70),
                                        child: const Center(
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
                                        ),
                                      );
                                    }else if (state is IsLoadedProduk){
                                      final data = state.listProdukModel;
                                      return Flexible(
                                        child: GridView.builder(
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            crossAxisSpacing: 20,
                                            mainAxisSpacing: 20,
                                          ),
                                          itemCount: data.produk.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index){
                                            return _produk("https://kangsayur.nitipaja.online${data.produk[index].variantImg}", data.produk[index].namaProduk, data.produk[index].variantDesc, data.produk[index].hargaVariant.toString(), data.produk[index].stok.toString());
                                          },
                                        ),
                                      );
                                    } else if (state is IsErrorProduk){
                                      return Center(
                                        child: Text(state.error),
                                      );
                                    } else {
                                      return const Center(
                                        child: Text("Terjadi kesalahan"),
                                      );
                                    }
                                  },
                                ),
                              if (MediaQuery.sizeOf(context).width >= 2200)
                                BlocConsumer<ProdukTokoBloc, ProdukPageState>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    if(state is IsLoadingProduk){
                                      return Container(
                                        padding: const EdgeInsets.fromLTRB(500, 200, 80, 70),
                                        child: const Center(
                                          child: Column(
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
                                        ),
                                      );
                                    }else if (state is IsLoadedProduk){
                                      final data = state.listProdukModel;
                                      return Flexible(
                                        child: GridView.builder(
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 6,
                                            crossAxisSpacing: 20,
                                            mainAxisSpacing: 20,
                                          ),
                                          itemCount: data.produk.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index){
                                            return _produk("https://kangsayur.nitipaja.online${data.produk[index].variantImg}", data.produk[index].namaProduk, data.produk[index].variantDesc, data.produk[index].hargaVariant.toString(), data.produk[index].stok.toString());
                                          },
                                        ),
                                      );
                                    } else if (state is IsErrorProduk){
                                      return Center(
                                        child: Text(state.error),
                                      );
                                    } else {
                                      return const Center(
                                        child: Text("Terjadi kesalahan"),
                                      );
                                    }
                                  },
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                } else if (state is ListDetailTokoPageError) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else {
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
                }
              },
        ),
        ),
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

  Widget _produk (String image, String name, String desc, String price, String stock){
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
            child: Image.network(
              image,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
              color: ColorValue.primaryColor,
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
                  desc,
                  style: textTheme.headline6!.copyWith(
                    color: ColorValue.hintColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
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
  void _showDialogMapScreen(
      double lat,
      double long,
      ) {
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
                center: LatLng(lat, long),
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
                      point: LatLng(lat, long),
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
