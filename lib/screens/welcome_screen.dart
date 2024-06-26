import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/utils/app_colors.dart';
import '../resources/utils/constants.dart';
import '../resources/widgets/BtnNullHeightWidth.dart';
import '../resources/widgets/text_widget.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WelcomeState();
  }
}

class WelcomeState extends State<WelcomeScreen> {
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Column(
                      children: [
                        BtnNullHeightWidth(
                          title: 'Login',
                          bgcolour: AppColors.greyBtnColor,
                          textcolour: AppColors.black,
                          onPress: () {
                            Navigator.pushNamed(context, Constants.loginScreen);
                          },
                          width: MediaQuery.of(context).size.width,
                          height: 48,
                        ),
                        Constants.height10,
                        BtnNullHeightWidth(
                          title: 'Create Account',
                          bgcolour: AppColors.greyBtnColor,
                          textcolour: AppColors.black,
                          onPress: () {
                            Navigator.pushNamed(context, Constants.chooseOptions);
                          },
                          width: MediaQuery.of(context).size.width,
                          height: 48,
                        ),
                      ],
                    ),
                  ),
                  Constants.height15,
                  Constants.height15,
                  Constants.height15,
                  Constants.height15,
                  Container(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 200,
                        ),
                        TextWidget(
                          input: 'FIXRR',
                          fontsize: 108,
                          fontWeight: FontWeight.w700,
                          textcolor: AppColors.textBlue,
                        ),
                        TextWidget(
                          input: 'Time to,what really matters',
                          fontsize: 20,
                          fontWeight: FontWeight.w700,
                          textcolor: AppColors.textBlue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
