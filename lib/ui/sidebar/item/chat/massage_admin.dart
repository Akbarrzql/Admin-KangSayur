import 'dart:async';
import 'dart:convert';
import 'package:admin_kangsayur/ui/sidebar/item/chat/repository/room_chat_repository.dart';
import 'package:admin_kangsayur/ui/sidebar/item/chat/repository/send_massage_repository.dart';
import 'package:admin_kangsayur/ui/sidebar/item/chat/state/room_chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../common/color_value.dart';
import 'bloc/room_chat_bloc.dart';
import 'event/room_chat_event.dart';
import 'model/list_chat_seller_model.dart';
import 'model/room_chat_model.dart';

class MassageAdminDart extends StatefulWidget {
  const MassageAdminDart({super.key, required this.data});

  final ListElement data;

  @override
  State<MassageAdminDart> createState() => _MassageAdminDartState();
}

class _MassageAdminDartState extends State<MassageAdminDart> {
  final TextEditingController _messageController =
      TextEditingController(); // Tambahkan controller untuk TextField

  final List<ChatMessage> _chatMessages = [];
  bool isLoading = false;

  //inisisasi pusher dan stream controller
  late PusherClient pusher;
  StreamController<dynamic> dataStreamController = StreamController<dynamic>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initPusher();
    //inisialisasi pusher dijalanakan di initstate untuk pertama kali
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  //fungsi untuk inisialisasi pusher dan subscribe ke channel
  Future<void> _initPusher() async {
    try {
      pusher = PusherClient(
        'a1b4c333a2e77bd3dc40',
        PusherOptions(
          cluster: 'ap1',
          encrypted: true,
        ),
      );

      pusher.onConnectionStateChange((state) {
        print('Connection state changed: $state');
      });

      pusher.onConnectionError((error) {
        print('Error connecting to Pusher: $error');
      });

      await pusher.connect();

      // Subscribe to a channel
      Channel channel =
          pusher.subscribe('conversation.${widget.data.conversationId}');

      //untuk subscribe ke channel private
      // Channel channel = pusher.subscribePrivate('private-delivery');

      //unsbuscribe channel
      // pusher.unsubscribe('delivery');

      //disconnect
      // pusher.disconnect();

      // Bind to an event
      channel.bind('getMessagesList', (event) {
        Map<String, dynamic> eventData = jsonDecode(event!.data.toString());

        RoomChatModelModel updatedRoomChatModel =
            RoomChatModelModel.fromJson(eventData);
        dataStreamController.add(updatedRoomChatModel);
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    } catch (e) {
      print('Error initializing Pusher: $e');
    }
  }

  @override
  void dispose() {
    // pusher.unsubscribe('conversation.${widget.data.conversationId}');
    // pusher.disconnect();
    dataStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => RoomChatPageBloc(
          roomChatPageRepository: RoomChatRepository(),
          sendMassagePageRepository: SendMassageRepository())
        ..add(GetRoomChat(widget.data.conversationId.toString())),
      child: BlocBuilder<RoomChatPageBloc, RoomChatState>(
        builder: (context, state) {
          if (state is RoomChatLoaded) {
            final roomChatModel = state.roomChatModelModel;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: ColorValue.neutralColor,
                  ),
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(
                          'https://kangsayur.nitipaja.online${widget.data.photo}'),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.data.name.toString(),
                      style: textTheme.headline6!.copyWith(
                        color: ColorValue.neutralColor,
                      ),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: dataStreamController.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final updatedRoomChatModel =
                              snapshot.data as RoomChatModelModel;
                          return ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            itemCount: updatedRoomChatModel.messages.length,
                            itemBuilder: (context, index) {
                              final interlocutors = widget.data;
                              final message =
                                  updatedRoomChatModel.messages[index];
                              return GestureDetector(
                                onLongPress: () {},
                                child: ChatBubble(
                                  imageUser:
                                      'https://kangsayur.nitipaja.online${message.photo}',
                                  imageSeller:
                                      'https://kangsayur.nitipaja.online${message.photo}',
                                  name: message.name,
                                  nameSeller: "${interlocutors.name} (Admin)",
                                  message: message.message,
                                  date: DateFormat('HH:mm').format(
                                      DateTime.parse(
                                          message.createdAt.toString())),
                                  role: message.role.toString(),
                                ),
                              );
                            },
                          );
                        } else {
                          return ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            itemCount: roomChatModel.messages.length,
                            itemBuilder: (context, index) {
                              final interlocutors = widget.data;
                              final message = roomChatModel.messages[index];
                              return GestureDetector(
                                onLongPress: () {},
                                child: ChatBubble(
                                  imageUser:
                                      'https://kangsayur.nitipaja.online${message.photo}',
                                  imageSeller:
                                      'https://kangsayur.nitipaja.online${message.photo}',
                                  name: message.name,
                                  nameSeller: "${interlocutors.name} (Admin)",
                                  message: message.message,
                                  date: DateFormat('HH:mm').format(
                                      DateTime.parse(
                                          message.createdAt.toString())),
                                  role: message.role.toString(),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  if (isLoading)
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
                                hintText: 'Ketik pesan...',
                                hintStyle: TextStyle(
                                  color: ColorValue.neutralColor,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              if (_messageController.text.isNotEmpty) {
                                setState(() {
                                  isLoading = true;
                                });
                                setState(() {
                                  _chatMessages.add(
                                    ChatMessage(
                                      name: 'admin',
                                      message: _messageController.text,
                                      date: DateFormat('HH:mm').format(DateTime.now()),
                                      role: 'admin',
                                      isCurrentUser: true,
                                    ),
                                  );
                                  // context.read<RoomChatPageBloc>().add(SendMassage(widget.data.conversationId.toString(), _messageController.text));
                                });
                                await ChatFunc().sendMessage(
                                    widget.data.conversationId.toString(),
                                    _messageController.text);
                                setState(() {
                                  isLoading = false;
                                });
                                _messageController.clear(); // Clear text field

                                // // Tunggu sebentar agar pesan dapat dikirim
                                // await Future.delayed(Duration(milliseconds: 500));
                                //
                                // // Kembali ke halaman yang sama
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => DetailChatPage(data: widget.data),
                                //   ),
                                // );
                              }
                            },
                            icon: Icon(
                              Icons.send,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
                                hintText: 'Ketik pesan...',
                                hintStyle: TextStyle(
                                  color: ColorValue.neutralColor,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              // Tambahkan kondisi jika _messageController.text tidak kosong
                              if (_messageController.text.isNotEmpty) {
                                setState(() {
                                  isLoading = true;
                                });
                                setState(() {
                                  _chatMessages.add(
                                    ChatMessage(
                                      name: 'admin',
                                      message: _messageController.text,
                                      date: DateFormat('HH:mm').format(DateTime.now()),
                                      role: 'admin',
                                      isCurrentUser: true,
                                    ),
                                  );
                                  // context.read<RoomChatPageBloc>().add(SendMassage(widget.data.conversationId.toString(), _messageController.text));
                                });
                                await ChatFunc().sendMessage(widget.data.conversationId.toString(), _messageController.text);
                                setState(() {
                                  isLoading = false;
                                });
                                _messageController.clear(); // Clear text field

                                // // Tunggu sebentar agar pesan dapat dikirim
                                // await Future.delayed(Duration(milliseconds: 500));
                                //
                                // // Kembali ke halaman yang sama
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => DetailChatPage(data: widget.data),
                                //   ),
                                // );
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
            );
          } else {
            return const Scaffold(
              body: SizedBox(),
            );
          }
        },
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String imageUser;
  final String imageSeller;
  final String name;
  final String nameSeller;
  final String message;
  final String date;
  final String role;

  const ChatBubble({
    required this.imageUser,
    required this.imageSeller,
    required this.name,
    required this.nameSeller,
    required this.message,
    required this.date,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          role == 'admin' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              role == 'admin' ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (role == "seller")
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(imageUser),
              ),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: role == "admin"
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      name, // Tampilkan nama pengirim
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: role == "admin"
                          ? const Color(0xFFDDEDE7)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: role == "admin"
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          message, // Tampilkan pesan
                          style: TextStyle(
                            color: role == "admin"
                                ? ColorValue.neutralColor
                                : ColorValue.neutralColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          date, // Tampilkan waktu pengiriman
                          style: TextStyle(
                            fontSize: 12,
                            color: role == "admin"
                                ? ColorValue.hintColor
                                : ColorValue.hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (role == "admin")
              CircleAvatar(
                // Foto profil Toko
                radius: 16,
                backgroundImage: NetworkImage(imageSeller),
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
  final String role;
  final bool isCurrentUser;

  ChatMessage({
    required this.name,
    required this.message,
    required this.date,
    required this.role,
    required this.isCurrentUser,
  });
}

class ChatFunc {
  final String _url = 'https://kangsayur.nitipaja.online/api/';

  Future<bool> sendMessage(String conversationId, String message) async {
    print("conversationId : $conversationId");
    print("message : $message");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    print(token);
    try {
      var response =
          await http.post(Uri.parse(_url + 'admin/chat/send'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }, body: {
        'conversationId': conversationId,
        'message': message,
      });
      print(response.body);
      print(response.statusCode);
      return true;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }
}
