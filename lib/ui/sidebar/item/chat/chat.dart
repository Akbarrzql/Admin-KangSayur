import 'dart:async';
import 'dart:convert';

import 'package:admin_kangsayur/ui/sidebar/item/chat/massage_admin.dart';
import 'package:admin_kangsayur/ui/sidebar/item/chat/repository/list_chat_repository.dart';
import 'package:admin_kangsayur/ui/sidebar/item/chat/state/list_chat_seller_state.dart';
import 'package:admin_kangsayur/ui/widget/list_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:pusher_client/pusher_client.dart';
import '../../../../common/color_value.dart';
import 'bloc/list_chat_seller_bloc.dart';
import 'event/list_chat_seller_event.dart';
import 'model/room_chat_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  bool isClicked = false;
  bool toogleAdmin = false;


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: BlocProvider(
            create: (context) => ListChatSellerPageBloc(listChatSellerPageRepository: ListChatSellerRepository())..add(GetListChatSeller()),
            child: BlocBuilder<ListChatSellerPageBloc, ListChatSellerState>(
              builder: (context, state) {
                if (state is ListChatSellerLoading){
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
                }else if (state is ListChatSellerLoaded){
                  final listChatSellerModel = state.listChatSellerModel;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffE5E5E5),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Flexible(
                                    child: ListView.builder(
                                      padding: const EdgeInsets.all(10),
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: listChatSellerModel.list.length,
                                      itemBuilder: (context, index) {
                                        return ListChart(
                                          onTap: () {
                                            //jika chat ditekan maka ubah isClicked menjadi true
                                            setState(() {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                  MassageAdminDart(
                                                    data: listChatSellerModel.list[index],
                                                  )));
                                            });
                                          },
                                          imagePelanggan: 'https://kangsayur.nitipaja.online${listChatSellerModel.list[index].photo}',
                                          namePelanggan: listChatSellerModel.list[index].name,
                                          pesanPelanggan: listChatSellerModel.list[index].lastConvo.message,
                                          waktuPesan: DateFormat('HH:mm').format(DateTime.parse(listChatSellerModel.list[index].lastConvo.createdAt.toString())),
                                        );
                                      },
                                    ),
                                  ),
                                )
                            ),
                            const SizedBox(height: 20,),
                            Container(
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                  color: Color(0xffE5E5E5),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sesi Chat",
                                        style: textTheme.headline6!.copyWith(
                                          color: ColorValue.neutralColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      Text(
                                        "Jadwal Chat Hari Ini",
                                        style: textTheme.headline6!.copyWith(
                                          color: ColorValue.neutralColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      Text(
                                        "Selalu berhati-hati dalam memberikan masukan, dan jangan lupa untuk menggunakan bahasa Indonesia yang sopan, baku, baik dan benar!",
                                        style: textTheme.headline6!.copyWith(
                                          color: ColorValue.hintColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 20,),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Expanded(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                        width: 310,
                                                        height: 50,
                                                        alignment: Alignment.center,
                                                        decoration: BoxDecoration(
                                                          color: ColorValue.primaryColor,
                                                          borderRadius: BorderRadius.circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey.withOpacity(0.5),
                                                              spreadRadius: 1,
                                                              blurRadius: 1,
                                                              offset: const Offset(0, 1), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: Flexible(
                                                          child: Row(
                                                            //icon jam dan tanggal hari ini
                                                            children: [
                                                              const SizedBox(width: 20,),
                                                              const Flexible(
                                                                child: Icon(
                                                                  Icons.date_range,
                                                                  color: Colors.white,
                                                                ),
                                                              ),
                                                              const SizedBox(width: 10,),
                                                              Flexible(
                                                                child: Text(
                                                                  //tanggal bulan dan tahun secara otomatis dan bulan menggunakan format bahasa indonesia (ex: 1 Januari 2021)
                                                                  "${DateTime.now().day} ${DateTime.now().month == 1 ? 'Januari' : DateTime.now().month == 2 ? 'Februari' : DateTime.now().month == 3 ? 'Maret' : DateTime.now().month == 4 ? 'April' : DateTime.now().month == 5 ? 'Mei' : DateTime.now().month == 6 ? 'Juni' : DateTime.now().month == 7 ? 'Juli' : DateTime.now().month == 8 ? 'Agustus' : DateTime.now().month == 9 ? 'September' : DateTime.now().month == 10 ? 'Oktober' : DateTime.now().month == 11 ? 'November' : 'Desember'} ${DateTime.now().year}",
                                                                  style: textTheme.headline6!.copyWith(
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 14,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(width: 10,),
                                                            ],
                                                          ),
                                                        )
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10,),
                                              Expanded(
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                        width: 310,
                                                        height: 50,
                                                        alignment: Alignment.center,
                                                        decoration: BoxDecoration(
                                                          color: ColorValue.primaryColor,
                                                          borderRadius: BorderRadius.circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey.withOpacity(0.5),
                                                              spreadRadius: 1,
                                                              blurRadius: 1,
                                                              offset: const Offset(0, 1), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: Flexible(
                                                          child: Row(
                                                            //icon jam dan tanggal hari ini
                                                            children: [
                                                              const SizedBox(width: 20,),
                                                              const Icon(
                                                                Icons.access_time,
                                                                color: Colors.white,
                                                              ),
                                                              const SizedBox(width: 10,),
                                                              Flexible(
                                                                child: Text(
                                                                  //jam secara otomatis
                                                                  "08:00 : 15:00 WIB",
                                                                  style: textTheme.headline6!.copyWith(
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 14,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(width: 10,),
                                                            ],
                                                          ),
                                                        )
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),

                                        ),
                                      ),
                                      const SizedBox(height: 20,),
                                    ],
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }else if (state is ListChatSellerError){
                  return Center(
                    child: Text(state.errorMessage),
                  );
                }else{
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Lottie.asset("assets/json/chatnf.json", width: 300, height: 300,),
                          Text(
                            'Belum terdapat chat dengan pelanggan yang masuk',
                            style: textTheme.headline6!.copyWith(
                              color: ColorValue.neutralColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        )
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String name;
  final String message;
  final String date;
  final bool isCurrentUser;

  const ChatBubble({
    required this.name,
    required this.message,
    required this.date,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isCurrentUser)
              const CircleAvatar(
                // Foto profil User
                radius: 16,
                backgroundImage: AssetImage('assets/images/logo_kangsayur.png'),
                backgroundColor: ColorValue.primaryColor,
              ),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      name, // Tampilkan nama pengirim
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isCurrentUser ? ColorValue.neutralColor : ColorValue.neutralColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: isCurrentUser ? const Color(0xFFDDEDE7) : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Text(
                          message, // Tampilkan pesan
                          style: TextStyle(
                            color: isCurrentUser ? ColorValue.neutralColor : ColorValue.neutralColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          date, // Tampilkan waktu pengiriman
                          style: TextStyle(
                            fontSize: 12,
                            color: isCurrentUser ? ColorValue.hintColor : ColorValue.hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isCurrentUser)
              const CircleAvatar(
                // Foto profil Toko
                radius: 16,
                backgroundColor: ColorValue.tertiaryColor,
                backgroundImage: AssetImage('assets/images/logo_kangsayur.png'),
              ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class ChatMessage {
  final String name;
  final String message;
  final String date;
  final bool isCurrentUser;

  ChatMessage({
    required this.name,
    required this.message,
    required this.date,
    required this.isCurrentUser,
  });
}

