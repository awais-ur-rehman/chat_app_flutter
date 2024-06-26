import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'chat_screen.dart';
import 'extension.dart';

class ListScreen extends StatefulWidget {
  final String role;
  final Map<String, dynamic> user;

  ListScreen({required this.role, required this.user});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<dynamic> _list = [];

  @override
  void initState() {
    super.initState();
    _fetchList();
  }

  Future<void> _fetchList() async {
    final targetRole = widget.role == 'user' ? 'fixer' : 'user';
    final url = Uri.parse('http://192.168.100.240:8000/api/auth/list/$targetRole');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        _list = json.decode(response.body);
      });
    } else {
      // Handle error
      final error = json.decode(response.body);
      print(error['error']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.role.toCapitalized()} List'),
      ),
      body: FutureBuilder(
        future: _fetchList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) {
                final item = _list[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text(item['email']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          role: widget.role,
                          userName: widget.user['name'],
                          chatPartnerName: item['name'],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
          else {
            return const Text('a');
          }
        },
      )
    );
  }
}
