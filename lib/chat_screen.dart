import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  final String role;
  final String userName;
  final String chatPartnerName;

  const ChatScreen({super.key, required this.role, required this.userName, required this.chatPartnerName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  late IO.Socket socket;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _connectSocket();
  }

  void _connectSocket() {
    socket = IO.io('https://fixxr-65433a1a292e.herokuapp.com', <String, dynamic>{
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

    socket.on('receiveMessage', (data) {
      if (data['sender'] != widget.userName) {
        setState(() {
          _messages.add(Map<String, dynamic>.from(data));
        });
        _scrollToBottom();
      }
    });
  }

  void _joinRoom() {
    socket.emit('joinRoom', {
      'userName': widget.userName,
      'chatPartnerName': widget.chatPartnerName
    });
  }

  void _fetchMessages() {
    socket.emitWithAck('fetchMessages', {
      'user': widget.userName,
      'chatPartner': widget.chatPartnerName
    }, ack: (messages) {
      setState(() {
        _messages.clear();
        _messages.addAll(List<Map<String, dynamic>>.from(messages));
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

  void _sendMessage() {
    final message = {
      'sender': widget.userName,
      'receiver': widget.chatPartnerName,
      'message': _controller.text
    };
    socket.emit('sendMessage', message);
    setState(() {
      _messages.add(message);
    });
    _controller.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.chatPartnerName}'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                bool isSentByMe = message['sender'] == widget.userName;

                return Align(
                  alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: isSentByMe ? Colors.green.withOpacity(0.9) : Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      message['message'],
                      style: const TextStyle(color: Colors.white),
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
                    decoration: const InputDecoration(hintText: 'Enter message'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}