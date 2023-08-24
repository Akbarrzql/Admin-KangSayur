import 'package:admin_kangsayur/ui/sidebar/item/list_toko/bloc/take_down_bloc.dart';
import 'package:admin_kangsayur/ui/sidebar/item/list_toko/repository/take_down_repository.dart';
import 'package:admin_kangsayur/ui/sidebar/item/list_toko/state/take_down_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/color_value.dart';
import '../../toko/model/produk_model.dart';
import 'package:intl/intl.dart';

import 'event/take_down_event.dart';

class DetailTakeDownProduk extends StatefulWidget {
  const DetailTakeDownProduk({super.key, required this.data});
  final Produk data;

  @override
  State<DetailTakeDownProduk> createState() => _DetailTakeDownProdukState();
}

class _DetailTakeDownProdukState extends State<DetailTakeDownProduk> {
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
                                  'https://kangsayur.nitipaja.online${widget.data.variantImg}'
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
                                  widget.data.variantDesc,
                                  style: textTheme.bodyText1!.copyWith(
                                    color: ColorValue.neutralColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(widget.data.hargaVariant),
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
                                    "Rating :",
                                    style: textTheme.bodyMedium!.copyWith(
                                      color: ColorValue.neutralColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  // for (var i = 0; i < widget.data.variant.length; i++)
                                    Container(
                                        margin: const EdgeInsets.only(right: 10),
                                        child: chipVarian(widget.data.rating.toString())),
                                ],
                              ),
                              const SizedBox(height: 90,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                      'Tutup Produk',
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
                                          create: (context) => TakeDownPageBloc(takeDownPageRepository: TekaDownRepository()),
                                          child: BlocConsumer<TakeDownPageBloc, TakeDownState>(
                                            listener: (context, state) {},
                                            builder: (context, state) {
                                              if(state is InitialTakeDownState){
                                                return ElevatedButton(
                                                  onPressed: (){
                                                    BlocProvider.of<TakeDownPageBloc>(context).add(PostTakeDown(
                                                      widget.data.tokoId.toString(),
                                                      widget.data.id.toString(),
                                                      _alasanController.text,
                                                    ));
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
                                              }else if (state is IsLoadingTakeDown){
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
                                              }else if (state is IsLoadedTakeDown){
                                                return Column(
                                                  children: [
                                                    Text(
                                                      "Barang Berhasil Di Takedown",
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
                                              }else if (state is IsErrorTakeDown){
                                                return Center(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(state.error),
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
