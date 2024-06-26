import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../chat_screen.dart';
import '../../models/fixer_model.dart';
import '../../resources/utils/app_colors.dart';
import '../../resources/utils/constants.dart';
import '../../resources/widgets/text_widget.dart';

class MatchList extends StatefulWidget {
  final String jobName;

  const MatchList({super.key, required this.jobName});

  @override
  State<StatefulWidget> createState() {
    return MatchState();
  }
}

class MatchState extends State<MatchList> {
  List<Fixer> fixers = [];

  @override
  void initState() {
    super.initState();
    fetchFixers();
  }

  Future<void> fetchFixers() async {
    var url = Uri.parse('${Constants.baseUrl}fixer_search');
    final response = await http.post(
      url,
      body: {'job_name': widget.jobName},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> fixersData = responseData['fixers'];
      setState(() {
        fixers = fixersData.map((json) => Fixer.fromJson(json)).toList();
      });
    } else {
      // Handle error
    }
  }

  void _showLanguageSelectionDialog(Fixer fixer) {
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
                      userName: Constants.userName,
                      chatPartnerName: fixer.name,
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
            child: fixers.isEmpty
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : ListView.builder(
                itemCount: fixers.length,
                addRepaintBoundaries: true,
                scrollDirection: Axis.vertical,
                shrinkWrap: false,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Fixer object = fixers[index];
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
                                input: 'Name:',
                                fontsize: 20,
                                fontWeight: FontWeight.w300,
                                textcolor: AppColors.black,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              TextWidget(
                                input: object.name,
                                fontsize: 20,
                                fontWeight: FontWeight.w300,
                                textcolor: AppColors.black,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              TextWidget(
                                input: 'Email:',
                                fontsize: 20,
                                fontWeight: FontWeight.w300,
                                textcolor: AppColors.black,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              TextWidget(
                                input: object.email,
                                fontsize: 20,
                                fontWeight: FontWeight.w300,
                                textcolor: AppColors.black,
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              _showLanguageSelectionDialog(object);
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
                }),
          ),
        ));
  }
}
