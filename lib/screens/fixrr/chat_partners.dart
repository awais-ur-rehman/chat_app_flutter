import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../chat_screen.dart';
import '../../resources/utils/app_colors.dart';
import '../../resources/utils/constants.dart';
import '../../resources/widgets/text_widget.dart';

class ChatPartners extends StatefulWidget {
  final String userName;

  const ChatPartners({super.key, required this.userName});

  @override
  State<ChatPartners> createState() => _ChatPartnersState();
}

class _ChatPartnersState extends State<ChatPartners> {
  late Future<List<String>> _futureChatPartners;

  @override
  void initState() {
    super.initState();
    _futureChatPartners = fetchChatPartners();
  }

  Future<List<String>> fetchChatPartners() async {
    var url = Uri.parse('https://fixxr-65433a1a292e.herokuapp.com/api/messaging/chatPartners');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userName': widget.userName}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> chatPartnersData = responseData['chatPartners'];
      return chatPartnersData.cast<String>();
    } else {
      throw Exception('Failed to load chat partners');
    }
  }

  void _showLanguageSelectionDialog(String partnerName) {
    String selectedLanguage = 'en';

    final Map<String, String> languages = {
      'en': 'English',
      'es': 'Spanish',
      'de': 'German',
      'nl': 'Dutch',
    };

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Primary Language'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return DropdownButton<String>(
                value: selectedLanguage,
                items: languages.keys.map((String key) {
                  return DropdownMenuItem<String>(
                    value: key,
                    child: Text(languages[key]!),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedLanguage = newValue!;
                  });
                },
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      role: Constants.userRole,
                      userName: widget.userName,
                      chatPartnerName: partnerName,
                      selectedLanguage: selectedLanguage,
                    ),
                  ),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Partners'),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: FutureBuilder<List<String>>(
            future: _futureChatPartners,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    addRepaintBoundaries: true,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: false,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      String chatPartner = snapshot.data![index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  TextWidget(
                                    input: 'User:',
                                    fontsize: 20,
                                    fontWeight: FontWeight.w300,
                                    textcolor: AppColors.black,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  TextWidget(
                                    input: chatPartner,
                                    fontsize: 20,
                                    fontWeight: FontWeight.w300,
                                    textcolor: AppColors.black,
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  _showLanguageSelectionDialog(chatPartner);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    TextWidget(
                                      input: 'Message',
                                      fontsize: 17,
                                      fontWeight: FontWeight.w300,
                                      textcolor: AppColors.secondaryColor,
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_outlined,
                                      color: AppColors.secondaryColor,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('No Chat Partners Found'),
                  );
                }
              } else {
                return const Center(
                  child: Text('Failed to load chat partners'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
