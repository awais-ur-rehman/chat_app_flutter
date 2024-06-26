import 'dart:ffi';
import 'package:chat_app/screens/user/post_job.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../resources/utils/app_colors.dart';
import '../../resources/utils/constants.dart';
import '../../resources/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Constants.height15,
                  Container(
                    child: Row(
                      children: [
                        TextWidget(
                          input: 'FIXRR',
                          fontsize: 38,
                          fontWeight: FontWeight.w600,
                          textcolor: AppColors.textBlue,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: AppColors.primaryColor,
                    width: MediaQuery.sizeOf(context).width,
                    child: Column(
                      children: [
                        TextWidget(
                          input: 'How can we help today?',
                          fontsize: 22,
                          fontWeight: FontWeight.w800,
                          textcolor: AppColors.black,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 150,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PostJob(jobName: "Cleaning ",),
                              ),
                            );
                           // Navigator.pushNamed(context, Constants.jobPost,);
                          },
                          child: Card(
                            color: AppColors.primaryColor,
                            elevation: 25,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    color: AppColors.primaryColor, width: 1.0)),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/cleaning.png',
                                  height: 100,
                                ),
                                TextWidget(
                                  input: 'Cleaning',
                                  fontsize: 18,
                                  fontWeight: FontWeight.w600,
                                  textcolor: AppColors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const PostJob(jobName: "Gardening",),
                              ),
                            );
                          },
                          child: Card(
                            color: AppColors.primaryColor,
                            elevation: 25,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(
                                    color: AppColors.primaryColor, width: 1.0)),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/gardening.png',
                                  height: 100,
                                ),
                                TextWidget(
                                  input: 'Gardening',
                                  fontsize: 18,
                                  fontWeight: FontWeight.w600,
                                  textcolor: AppColors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 150,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const PostJob(jobName: "Painting",),
                              ),
                            );
                          },
                          child: Card(
                            color: AppColors.primaryColor,
                            elevation: 25,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(
                                    color: AppColors.primaryColor, width: 1.0)),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/painting.png',
                                  height: 100,
                                ),
                                TextWidget(
                                  input: 'Painting',
                                  fontsize: 18,
                                  fontWeight: FontWeight.w600,
                                  textcolor: AppColors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const PostJob(jobName: "Odd Jobs",),
                              ),
                            );
                          },
                          child: Card(
                            color: AppColors.primaryColor,
                            elevation: 25,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(
                                    color: AppColors.primaryColor, width: 1.0)),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/oddjobs.png',
                                  height: 100,
                                ),
                                TextWidget(
                                  input: 'Odd Jobs',
                                  fontsize: 18,
                                  fontWeight: FontWeight.w600,
                                  textcolor: AppColors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 150,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const PostJob(jobName: "Shopping",),
                              ),
                            );
                          },
                          child: Card(
                            color: AppColors.primaryColor,
                            elevation: 25,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(
                                    color: AppColors.primaryColor, width: 1.0)),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/shopping.png',
                                  height: 100,
                                ),
                                TextWidget(
                                  input: 'Shopping',
                                  fontsize: 18,
                                  fontWeight: FontWeight.w600,
                                  textcolor: AppColors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const PostJob(jobName: "Pet Sitter",),
                              ),
                            );
                          },
                          child: Card(
                            color: AppColors.primaryColor,
                            elevation: 25,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(
                                    color: AppColors.primaryColor, width: 1.0)),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/petsitter.png',
                                  height: 100,
                                ),
                                TextWidget(
                                  input: 'Pet Sitter',
                                  fontsize: 18,
                                  fontWeight: FontWeight.w600,
                                  textcolor: AppColors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Constants.height15,
                  Constants.height15,
                  Constants.height15,
                  Constants.height15,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
