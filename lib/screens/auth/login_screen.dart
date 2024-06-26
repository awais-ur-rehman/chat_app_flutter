import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../resources/utils/app_colors.dart';
import '../../resources/utils/constants.dart';
import '../../resources/widgets/BtnNullHeightWidth.dart';
import '../../resources/widgets/email_input.dart';
import '../user/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<LoginScreen> {
  late String email, password;
  bool isLoading = false;
  bool showPassword = true;

  final GlobalKey<FormState> _SignKey = new GlobalKey<FormState>();

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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                    Constants.height15,
                    Constants.height15,
                    Constants.height15,
                    form(context),

                  ],
                ),
              ),
            ),
          ),
        ),



      ),
    );
  }

  Widget form(BuildContext context) {
    return Form(
      key: _SignKey,
      child: Column(
        children: [
          EmailInputWidget(
              title: "Email",
              isRequired: true,
              keyboardType: TextInputType.emailAddress,
              value: (val) {
                email = val!;
              },
              width: MediaQuery.sizeOf(context).width,
              validate: true,
              isPassword: false,
              hintcolour: AppColors.greyColor),
          Constants.height10,
          TextFormField(
            decoration: InputDecoration(
                fillColor: AppColors.primaryColor,
                filled: true,
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.lock),
                  color: AppColors.black,
                ),
                suffixIcon: (showPassword)
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = false;
                          });
                        },
                        icon: const Icon(Icons.visibility_off),
                        color: AppColors.black,
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = true;
                          });
                        },
                        icon: const Icon(Icons.visibility),
                        color: AppColors.black,
                      ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: AppColors.black,
                    )),
                hintText: "Password",
                alignLabelWithHint: true,
                labelText: "Password",
                hintStyle: const TextStyle(
                  color: AppColors.greyColor,
                )),
            obscureText: showPassword,
            validator: (password) {
              if (password!.isEmpty || password.length < 8) {
                return 'The Password you enter is incorrect';
              }
            },
            onSaved: (value) {
              password = value!;
            },
            onChanged: (value) {
              setState(() {});
            },
          ),
          Constants.height10,
          Constants.height10,
          (isLoading)?
          const Center(
            child: CircularProgressIndicator(),
          ):
          BtnNullHeightWidth(
            title: 'Login',
            bgcolour: AppColors.greyBtnColor,
            textcolour: AppColors.black,
            onPress: () {
              final form = _SignKey.currentState;
              form!.save();

              if(form.validate()){

                try{
                  login();
                }catch (e){

                  confirmationPopup(context, "An error Occurred.Try again later!");
                }
              }

            },
            width: MediaQuery.of(context).size.width,
            height: 48,
          ),
          Constants.height10,
        ],
      ),
    );
  }

  Future<dynamic> login() async {
    setState(() {
      isLoading = true; // Show loader
    });

    var url = Uri.parse('${Constants.baseUrl}users/signIn');
    var response = await http.post(
      url,
      body: {"email": email, "password": password},
    ).timeout(const Duration(seconds: 10), onTimeout: () {

      setState(() {
        isLoading = false; // Hide loader
      });
      return confirmationPopup(context, "Check your Internet Connection!");
    });

    if (response.statusCode == 200) {
      print(response.body);
      dynamic body = jsonDecode(response.body);
      dynamic status = body['status'];

      if (status == "success") {

        dynamic user = body['user'];
        dynamic role = user['user_type'];
        Constants.userID=user['id'].toString();

        if (role == 'User') {
          setState(() {

            isLoading=false;
          });
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen(),
            ),
            (route) => false,
          );
        } else {
          setState(() {

            isLoading=false;
          });
          //route to fixerr screen




        }
      } else {
        setState(() {
          isLoading = false; // Hide loader
        });
        print(response.body);
        dynamic body = jsonDecode(response.body);
        String error = body['message'];


        confirmationPopup(context, error);
      }
    } else {
      setState(() {
        isLoading = false; // Hide loader
      });
      print(response.statusCode);
      dynamic body = jsonDecode(response.body);
      String error = body['message'];

      confirmationPopup(context, error);
    }


  }

  confirmationPopup(BuildContext dialogContext, String? error) {
    var alertStyle = const AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      titleStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
      descStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
      animationDuration: Duration(milliseconds: 400),
    );

    Alert(context: dialogContext, style: alertStyle, title: error, buttons: [
      DialogButton(
        child: Text(
          "Try Again",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () {
          Navigator.pop(dialogContext);
        },
        color: AppColors.redColor,
      )
    ]).show();
  }
}
