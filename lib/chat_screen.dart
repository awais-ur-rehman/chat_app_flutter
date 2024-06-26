import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  final String role;
  final String userName;
  final String chatPartnerName;
  final String selectedLanguage;

  const ChatScreen({super.key,
    required this.role,
    required this.userName,
    required this.chatPartnerName,
    required this.selectedLanguage,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  late IO.Socket socket;
  final ScrollController _scrollController = ScrollController();
  final translator = GoogleTranslator();
  bool _isLoading = true;
  String selectedLanguage;

  _ChatScreenState() : selectedLanguage = '';

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.selectedLanguage;
    _connectSocket();
  }

  void _connectSocket() {
    socket =
        IO.io('https://fixxr-65433a1a292e.herokuapp.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.onConnect((_) {
      print('connected to socket server');
      _fetchMessages();
      _joinRoom();
    });

    socket.on('disconnect', (_) {
      print('disconnected from socket server');
      // Attempt to reconnect after a delay
      Future.delayed(const Duration(seconds: 5), () {
        socket.connect();
      });
    });

    socket.on('receiveMessage', (data) async {
      if (data['sender'] != widget.userName) {
        String translatedMessage =
            await _translateMessage(data['message'], selectedLanguage);
        setState(() {
          _messages.add({
            'sender': data['sender'],
            'receiver': data['receiver'],
            'message': translatedMessage,
          });
        });
        _scrollToBottom();
      }
    });
  }

  void _joinRoom() {
    socket.emit('joinRoom', {
      'userName': widget.userName,
      'chatPartnerName': widget.chatPartnerName,
    });
  }

  void _fetchMessages() {
    socket.emitWithAck('fetchMessages', {
      'user': widget.userName,
      'chatPartner': widget.chatPartnerName,
    }, ack: (messages) async {
      List<Map<String, dynamic>> translatedMessages = [];
      for (var message in messages) {
        if (message['sender'] != widget.userName) {
          String translatedMessage =
              await _translateMessage(message['message'], selectedLanguage);
          translatedMessages.add({
            'sender': message['sender'],
            'receiver': message['receiver'],
            'message': translatedMessage,
          });
        } else {
          translatedMessages.add({
            'sender': message['sender'],
            'receiver': message['receiver'],
            'message': message['message'],
          });
        }
      }
      setState(() {
        _messages.clear();
        _messages.addAll(translatedMessages);
        _isLoading = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    socket.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final message = _controller.text;
    final messageData = {
      'sender': widget.userName,
      'receiver': widget.chatPartnerName,
      'message': message,
    };

    socket.emit('sendMessage', messageData);
    setState(() {
      _messages.add(messageData);
    });
    _controller.clear();
    _scrollToBottom();
  }

  Future<String> _translateMessage(String text, String targetLanguage) async {
    var translation = await translator.translate(text, to: targetLanguage);
    return translation.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.chatPartnerName}'),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/chat_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message = _messages[index];
                          bool isSentByMe = message['sender'] == widget.userName;

                          return Align(
                            alignment: isSentByMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: isSentByMe
                                    ? Colors.green.withOpacity(0.9)
                                    : Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Text(
                                message['message'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.black,
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Enter message',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: _isLoading ? null : _sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
