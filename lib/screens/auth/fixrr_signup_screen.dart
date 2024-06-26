import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';
import '../../resources/utils/app_colors.dart';
import '../../resources/utils/constants.dart';
import '../../resources/widgets/BtnNullHeightWidth.dart';
import '../../resources/widgets/NameInputWidget.dart';
import '../../resources/widgets/email_input.dart';
import '../../resources/widgets/text_widget.dart';

class FixrSignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FixrSignUpState();
  }
}

class FixrSignUpState extends State<FixrSignUpScreen> {
  late String name, email, password, confirmPassword, aboutDescription;
  bool showPassword = true;
  RangeValues _maxDistance = const RangeValues(0, 0);
 String distanceCal="0";
  final GlobalKey<FormState> _fixrSignUpKey = GlobalKey<FormState>();
  List<XFile>? _imageList;
  XFile? _profileImage;
  String? _profileImageBase64;
  bool isLoading = false;
// Variable to store the base64 string of the profile image

  late dynamic selectedServices; // List to store picked images
  Map<String, bool> services = {
    "Cleaning": false,
    "Gardening": false,
    "Painting": false,
    "Odd Jobs": false,
    "Shopping": false,
    "Pet Sitter": false,
  };

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final List<XFile>? pickedList = await picker.pickMultiImage(
      maxHeight: 400, // Set max image height (optional)
      maxWidth: 400, // Set max image width (optional)
    );
    setState(() {
      if (pickedList != null) {
        _imageList = pickedList;
      }
    });
  }
  Future<void> pickProfileImage() async {
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 400,
      maxWidth: 400,
    );
    if (pickedImage != null) {
      final bytes = await File(pickedImage.path).readAsBytes();
      setState(() {
        _profileImage = pickedImage;
        _profileImageBase64 = base64Encode(bytes);
      });
    }
  }
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
                    Constants.height15,
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

                    GestureDetector(
                      onTap: pickProfileImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.greyColor,
                        backgroundImage: _profileImage != null
                            ? FileImage(File(_profileImage!.path))
                            : null,
                        child: _profileImage == null
                            ? const Icon(
                          Icons.add_a_photo,
                          size: 50,
                          color: AppColors.primaryColor,
                        )
                            : null,
                      ),
                    ),
                    Constants.height15,

                    const Text(
                      'Tap to pick a profile image',
                      style: TextStyle(
                        color: AppColors.textBlue,
                        fontSize: 16,
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
      key: _fixrSignUpKey,
      child: Column(
        children: [
          NameInputWidget(
              title: "Name",
              maxLines: 1,
              isRequired: true,
              error: "Enter Name",
              keyboardType: TextInputType.name,
              value: (val) {
                name = val!;
              },
              icon: Icons.person,
              width: MediaQuery.sizeOf(context).width,
              validate: true,
              isPassword: false,
              hintColor: AppColors.greyColor),
          Constants.height10,
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
                hintText: "Confirm Password",
                alignLabelWithHint: true,
                labelText: "Confirm Password",
                hintStyle: const TextStyle(
                  color: AppColors.greyColor,
                )),
            obscureText: showPassword,
            validator: (pass) {
              if (pass!.isEmpty || pass.length < 8 || pass != password) {
                return 'Password Does not match';
              }
            },
            onSaved: (value) {
              confirmPassword = value!;
            },
            onChanged: (value) {
              setState(() {});
            },
          ),
          Constants.height10,
          Constants.height15,
          TextFormField(
            style: const TextStyle(color: AppColors.textBlue),
            decoration: InputDecoration(
                fillColor: AppColors.primaryColor,
                filled: true,
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: AppColors.black,
                    )),
                hintText: "About Me",
                labelText: "About Me",
                labelStyle: TextStyle(color: AppColors.textBlue),
                hintStyle: TextStyle(color: AppColors.textBlue)),
            maxLines: 5,
            maxLength: 500,
            obscureText: false,
            validator: (val) {
              if (val!.isEmpty) {
                return 'Description is empty';
              }
            },
            onSaved: (value) {
              aboutDescription = value!;
            },
            onChanged: (value) {
              setState(() {});
            },
          ),
          Constants.height10,
          Container(
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColors.primaryColor,
              border: Border.all(
                width: 1,
                color: AppColors.primaryColor,
              ),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10.0,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        input: 'Maximum Distance',
                        fontsize: 20,
                        fontWeight: FontWeight.w600,
                        textcolor: AppColors.textBlue,
                      ),
                      TextWidget(
                        input: '10 km',
                        fontsize: 12,
                        fontWeight: FontWeight.w400,
                        textcolor: AppColors.black,
                      ),
                    ],
                  ),
                  RangeSlider(
                    values: _maxDistance,
                    max: 10,
                    divisions: 5,
                    activeColor: AppColors.textBlue,
                    inactiveColor: AppColors.greyColor,
                    labels: RangeLabels(
                      _maxDistance.start.round().toString(),
                      _maxDistance.end.round().toString(),
                    ),

                    onChanged: (RangeValues values) {
                      setState(() {
                        _maxDistance = values;
                        distanceCal=_maxDistance.end.round().toString();
                        print(distanceCal);

                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Constants.height10,
          Container(
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColors.primaryColor,
              border: Border.all(
                width: 1,
                color: AppColors.primaryColor,
              ),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10.0,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Upload Portfolio Images',
                  style: TextStyle(color: AppColors.textBlue, fontSize: 22),
                ),
                _imageList != null
                    ? GridView.builder(
                        shrinkWrap: true,
                        itemCount: _imageList!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 3 images per row
                        ),
                        itemBuilder: (context, index) {
                          return Image.file(File(_imageList![index].path));
                        },
                      )
                    : const Text(
                        'No images selected yet',
                        style:
                            TextStyle(color: AppColors.textBlue, fontSize: 12),
                      ),
                Constants.height10,
                ElevatedButton(
                  onPressed: () => pickImages(),
                  child: const Text('Upload Images'),
                ),
              ],
            ),
          ),
          Constants.height10,
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColors.primaryColor,
              border: Border.all(
                width: 1,
                color: AppColors.primaryColor,
              ),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10.0,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Select Services You Provide',
                  style: TextStyle(color: AppColors.textBlue, fontSize: 25),
                ),
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: services.keys.map((String key) {
                    return CheckboxListTile(
                      title: Text(
                        key,
                        style: const TextStyle(
                            color: AppColors.textBlue, fontSize: 18),
                      ),
                      value: services[key],
                      onChanged: (bool? value) {
                        setState(() {
                          services[key] = value!;
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Constants.height10,
          (isLoading)?
          const Center(
            child: CircularProgressIndicator(),
          ):
          BtnNullHeightWidth(
            title: 'Register',
            bgcolour: AppColors.greyBtnColor,
            textcolour: AppColors.black,
            onPress: () {
              final form = _fixrSignUpKey.currentState;
              form!.save();

              if (form.validate()) {

                setState(() {
                selectedServices = services.entries
                      .where((entry) => entry.value)
                      .map((entry) => entry.key)
                      .toList();

                });

                dynamic testarray=jsonEncode(selectedServices);

                print('Selected Services: $testarray');


                try {
                  fixerSignUp();
                } catch (e) {
                  confirmationPopup(
                      context, "An error Occurred.Try again later!");
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

  Future<dynamic> fixerSignUp() async {
    setState(() {
      isLoading = true; // Show loader
    });
    var url = Uri.parse('${Constants.baseUrl}users/store');
    List<String> base64Images = [];
    if (_imageList != null) {
      for (var image in _imageList!) {
        File imageFile = File(image.path);
        List<int> imageBytes = await imageFile.readAsBytes();
        String base64Image = base64Encode(imageBytes);
        base64Images.add(base64Image);
      }
    }
    print(name);
    print(email);
    print(password);
    print(aboutDescription);
    print(distanceCal);
    print(jsonEncode(selectedServices));
    print(jsonEncode(base64Images));
    print("Profile Image base 64?>$_profileImageBase64");

    var response = await http.post(
      url,
      body: {
        "name":name,
        "email":email,
        "password":password,
        "about_me":aboutDescription,
        "user_type":"Fixerr",
        "max_distance":distanceCal,
        "services_prodvides":jsonEncode(selectedServices),
        "portfolio_img":jsonEncode(base64Images),
       "porfile_img":_profileImageBase64,
        "lat":"32.15290269186808",
        "lon":"74.19000735191902",
      },
    ).timeout(const Duration(seconds: 10), onTimeout: () {
      setState(() {
        isLoading = false; // Show loader
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

        Navigator.pop(context);
      } else {
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
      String error = body['message'].toString();

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
