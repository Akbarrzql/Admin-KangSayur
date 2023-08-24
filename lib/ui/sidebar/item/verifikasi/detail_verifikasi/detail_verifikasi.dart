import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/respository/verify_produk/verifikasi_ditolak_repository.dart';
import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/respository/verify_produk/verify_produk_repository.dart';
import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/state/verfikasi_produk_state.dart';
import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/state/verify_produk_state/verifikasi_ditolak_state.dart';
import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/state/verify_produk_state/verify_produk_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../common/color_value.dart';
import '../bloc/verfikasi_produk_bloc.dart';
import '../bloc/verify_produk_bloc/verifikasi_produk_ditolak_bloc.dart';
import '../bloc/verify_produk_bloc/verifiy_produk_bloc.dart';
import '../event/verifikasi_produk_event.dart';
import '../event/verify_produk_event/verifikasi_ditolak_event.dart';
import '../event/verify_produk_event/verify_produk_event.dart';
import '../model/verifikasi_produk_model.dart';
import '../produk.dart';
import '../respository/verifikasi_produk_repository.dart';

class DetailVerifikasiProduk extends StatefulWidget {
  const DetailVerifikasiProduk({super.key, required this.data});
  final Datum data;

  @override
  State<DetailVerifikasiProduk> createState() => _DetailVerifikasiProdukState();
}

class _DetailVerifikasiProdukState extends State<DetailVerifikasiProduk> {

  bool _isExpanded = false;
  final TextEditingController _alasanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                              image: NetworkImage(
                                  'https://kangsayur.nitipaja.online${widget.data.variant[0].variantImg}'
                              ),
                                fit: BoxFit.cover,
                                width: 300,
                                height: 300,
                            ),
                          ),
                          const SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.data.namaProduk,
                                style: textTheme.headline6!.copyWith(
                                  color: ColorValue.neutralColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Text(
                                  widget.data.variant[0].variantDesc,
                                  style: textTheme.bodyText1!.copyWith(
                                    color: ColorValue.neutralColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(widget.data.variant[0].hargaVariant),
                                style: textTheme.bodyText1!.copyWith(
                                  color: ColorValue.primaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              // Row(
                              //   children: [
                              //     Text(
                              //       "Kategori :",
                              //       style: textTheme.bodyMedium!.copyWith(
                              //         color: ColorValue.neutralColor,
                              //         fontWeight: FontWeight.w600,
                              //         fontSize: 16,
                              //       ),
                              //     ),
                              //     const SizedBox(width: 10,),
                              //     Container(
                              //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(5),
                              //         color: const Color(0xFFE5F4E3),
                              //       ),
                              //       child: Text(
                              //         'Unggas',
                              //         style: textTheme.bodyText1!.copyWith(
                              //           color: ColorValue.primaryColor,
                              //           fontWeight: FontWeight.w600,
                              //           fontSize: 16,
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  Text(
                                    "List Variant :",
                                    style: textTheme.bodyMedium!.copyWith(
                                      color: ColorValue.neutralColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  for (var i = 0; i < widget.data.variant.length; i++)
                                    Container(
                                        margin: const EdgeInsets.only(right: 10),
                                        child: chipVarian(widget.data.variant[i].variant)),
                                ],
                              ),
                              const SizedBox(height: 90,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BlocProvider(
                                      create: (context) => VerifyProdukBloc(verifyProdukRepository: VerifyProdukRepository()),
                                      child: BlocConsumer<VerifyProdukBloc,VerifyProdukState>(
                                        listener: (context, state) {},
                                        builder: (context, state) {
                                          if(state is VerifyProdukInitial){
                                            return ElevatedButton(
                                              onPressed: (){
                                                BlocProvider.of<VerifyProdukBloc>(context).add(GetVerify(idProduk: widget.data.variant[0].productId.toString()));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: ColorValue.primaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                minimumSize: Size(250, 50),
                                              ),
                                              child: Text(
                                                'Verifikasi',
                                                style: textTheme.bodyText1!.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            );
                                          }else if (state is VerifyProdukLoading){
                                            return const Center(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Text("Loading...")
                                                ],
                                              ),
                                            );
                                          }else if (state is VerifyProdukLoaded){
                                            return Column(
                                              children: [
                                                Text(
                                                  "Barang Berhasil Diverifikasi",
                                                  style: textTheme.bodyText1!.copyWith(
                                                    color: ColorValue.primaryColor,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(height: 20,),
                                                ElevatedButton(
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    primary: ColorValue.primaryColor,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5),
                                                    ),
                                                    minimumSize: Size(250, 50),
                                                  ),
                                                  child: Text(
                                                    'Kembali',
                                                    style: textTheme.bodyText1!.copyWith(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }else if (state is VerifyProdukError){
                                            return Center(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(state.errorMessage),
                                                  ElevatedButton(
                                                    onPressed: (){
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Kembali'),
                                                  )
                                                ],
                                              ),
                                            );
                                          }else {
                                            return Center(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Text('Terjadi Kesalahan'),
                                                  ElevatedButton(
                                                    onPressed: (){
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Kembali'),
                                                  )
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                      )
                                  ),
                                  const SizedBox(width: 10,),
                                  ElevatedButton(
                                    onPressed: (){
                                      setState(() {
                                        _isExpanded = !_isExpanded;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: ColorValue.quaternaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: Size(250, 50),
                                    ),
                                    child: Text(
                                      'Tolak',
                                      style: textTheme.bodyText1!.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              //expanded widget textfield
                              if(_isExpanded)
                                Material(
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.34,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: ColorValue.neutralColor,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: _alasanController,
                                            keyboardType: TextInputType.multiline,
                                            textInputAction: TextInputAction.newline,
                                            maxLines: 5,
                                            decoration: InputDecoration(
                                              hintText: 'Alasan Penolakan',
                                              hintStyle: textTheme.bodyText1!.copyWith(
                                                color: ColorValue.hintColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      BlocProvider(
                                        create: (context) => VerifikasiProdukDitolakBloc(verifikasiProdukDitolakRepository: VerifikasiDitolakRepository()),
                                        child: BlocConsumer<VerifikasiProdukDitolakBloc, VerifyProdukRejectState>(
                                          listener: (context, state) {},
                                          builder: (context, state) {
                                            if(state is InitialVerifyProdukRejectState){
                                              return ElevatedButton(
                                                onPressed: (){
                                                  BlocProvider.of<VerifikasiProdukDitolakBloc>(context).add(PostVerifyProdukReject(idProduk: widget.data.variant[0].productId.toString(), idToko: widget.data.tokoId.toString(), alasan: _alasanController.text));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: ColorValue.primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  minimumSize: Size(250, 50),
                                                ),
                                                child: Text(
                                                  'Kirim',
                                                  style: textTheme.bodyText1!.copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              );
                                            }else if (state is VerifyProdukRejectLoading){
                                              return const Center(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 50,
                                                      width: 50,
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                    SizedBox(height: 10,),
                                                    Text("Loading...")
                                                  ],
                                                ),
                                              );
                                            }else if (state is VerifyProdukRejectSuccess){
                                              return Column(
                                                children: [
                                                  Text(
                                                    "Barang Berhasil Ditolak",
                                                    style: textTheme.bodyText1!.copyWith(
                                                      color: ColorValue.primaryColor,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20,),
                                                  ElevatedButton(
                                                    onPressed: (){
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      primary: ColorValue.primaryColor,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      minimumSize: Size(250, 50),
                                                    ),
                                                    child: Text(
                                                      'Kembali',
                                                      style: textTheme.bodyText1!.copyWith(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }else if (state is VerifyProdukRejectError){
                                              return Center(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(state.errorMessage),
                                                    ElevatedButton(
                                                      onPressed: (){
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('Kembali'),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }else{
                                              return Center(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Text('Terjadi Kesalahan'),
                                                    ElevatedButton(
                                                      onPressed: (){
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('Kembali'),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }
                                          },
                                        )
                                      )
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      Material(
                        color: Colors.grey[300],
                        child: Positioned(
                            right: 0,
                            child: IconButton(
                              color: Colors.grey[300],
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.close, color: ColorValue.neutralColor,),
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget chipVarian(String textVarian){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      alignment: Alignment.center,
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorValue.neutralColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        textVarian,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: ColorValue.neutralColor,
        ),
      ),
    );
  }
}
