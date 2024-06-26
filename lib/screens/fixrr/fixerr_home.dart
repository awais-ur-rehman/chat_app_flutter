import 'package:flutter/material.dart';

import '../../resources/utils/app_colors.dart';
import '../../resources/utils/constants.dart';
import '../../resources/widgets/BtnNullHeightWidth.dart';
import '../../resources/widgets/text_widget.dart';

class FixerHome extends StatefulWidget {
  const FixerHome({super.key});

  @override
  State<FixerHome> createState() => _FixerHomeState();
}

class _FixerHomeState extends State<FixerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.dashboard_outlined),
        title: const Text('Fixxr Dashboard'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.message)),
        ],
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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Constants.height15,
                  TextWidget(
                    input: 'FIXRR',
                    fontsize: 38,
                    fontWeight: FontWeight.w600,
                    textcolor: AppColors.textBlue,
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
