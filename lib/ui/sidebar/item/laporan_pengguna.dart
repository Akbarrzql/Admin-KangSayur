import 'package:flutter/material.dart';

import '../../../common/color_value.dart';
import '../../widget/list_chat.dart';

class LaporanPengguna extends StatefulWidget {
  const LaporanPengguna({Key? key}) : super(key: key);

  @override
  State<LaporanPengguna> createState() => _LaporanPenggunaState();
}

class _LaporanPenggunaState extends State<LaporanPengguna> {

  bool isClicked = false;
  bool toogleAdmin = false;

  final TextEditingController _messageController = TextEditingController(); // Tambahkan controller untuk TextField

  final List<ChatMessage> _chatMessages = [
    ChatMessage(
      name: 'Nama Pengguna',
      message: 'Penggunaan Marketplace ABC memberikan pengalaman yang memadai, namun ada beberapa area yang perlu ditingkatkan. Navigasi dapat diperbaiki untuk membuat halaman beranda lebih terorganisir dan mudah dinavigasi, serta perlu memperhatikan deskripsi produk yang lebih lengkap dan gambar produk yang jelas. Pengalaman pengguna dapat ditingkatkan dengan memastikan ketersediaan produk yang tepat dan pengiriman tepat waktu. Ulasan produk perlu dipantau agar lebih relevan dan layanan pelanggan dapat ditingkatkan dengan respons yang lebih cepat dan lebih personal.',
      date: '10:00',
      isCurrentUser: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
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
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return ListChart(
                                onTap: () {
                                  //jika chat ditekan maka ubah isClicked menjadi true
                                  setState(() {
                                    isClicked = true;
                                  });
                                },
                                imagePelanggan: 'assets/images/logo_kangsayur.png',
                                namePelanggan: 'Nama Pengguna',
                                pesanPelanggan: 'Halo, saya memiliki keluhan terkait pesanan saya dan toko.',
                                waktuPesan: '10:00',
                              );
                            },
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20,),
            //jika belum ada chat yang dipilih maka tampilkan widget ini
            if (!isClicked)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Color(0xffE5E5E5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo_kangsayur.png',
                        width: 300,
                        height: 300,
                      ),
                      const SizedBox(height: 20,),
                      Text(
                        'Pilih laporan untuk tindak lanjut',
                        style: textTheme.headline6!.copyWith(
                          color: ColorValue.neutralColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            //jika sudah ada chat yang dipilih maka tampilkan widget ini
            if (isClicked)
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(10),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _chatMessages.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onLongPress: (){
                              //menampilkan show dialog
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Hapus Pesan',
                                      style: textTheme.headline6!.copyWith(
                                        color: ColorValue.neutralColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    content: Text(
                                      'Apakah anda yakin ingin menghapus pesan ini?',
                                      style: textTheme.bodyText2!.copyWith(
                                        color: ColorValue.neutralColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Batal',
                                          style: textTheme.bodyText2!.copyWith(
                                            color: ColorValue.neutralColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _chatMessages.removeAt(index);
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Hapus',
                                          style: textTheme.bodyText2!.copyWith(
                                            color: ColorValue.primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: ChatBubble(
                              name: _chatMessages[index].name,
                              message: _chatMessages[index].message,
                              date: '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                              isCurrentUser: _chatMessages[index].isCurrentUser,
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: (){},
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(MediaQuery.sizeOf(context).width / 6, 70),
                                    primary: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Laporan Tidak Valid',
                                    style: textTheme.bodyText2!.copyWith(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: (){},
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(MediaQuery.sizeOf(context).width / 6, 70),
                                    primary: ColorValue.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Tindak Lanjut',
                                    style: textTheme.bodyText2!.copyWith(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xffE5E5E5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: const InputDecoration(
                                hintText: 'Ketik pesan ke pelapor...',
                                hintStyle: TextStyle(
                                  color: ColorValue.neutralColor,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (_messageController.text.isNotEmpty) {
                                setState(() {
                                  _chatMessages.add(
                                    ChatMessage(
                                      name: 'admin',
                                      message: _messageController.text,
                                      date: '10:01',
                                      isCurrentUser: true,
                                    ),
                                  );
                                  _messageController.clear();
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.send,
                              color: ColorValue.primaryColor,
                            ),
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