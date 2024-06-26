import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

import '../../resources/utils/app_colors.dart';
import '../../resources/utils/constants.dart';
import '../../resources/widgets/BtnNullHeightWidth.dart';
import '../../resources/widgets/NameInputWidget.dart';
import '../../resources/widgets/text_widget.dart';
import 'match_list.dart';

class PostJob extends StatefulWidget {
  final String jobName;

  const PostJob({Key? key, required this.jobName}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return JobState();
  }
}

class JobState extends State<PostJob> {
  final GlobalKey<FormState> jobPostFormKey = new GlobalKey<FormState>();
  RangeValues _priceRange = const RangeValues(0, 0);
  RangeValues _maxDistance = const RangeValues(0, 0);
  late String postCode,
      streetName,
      date,
      what,
      price,
      duration,
      priceRange,
      endPriceRange,
      maxDistance,
      jobDescription;
  late String gears;
  // List of items in our dropdown
  final List<String> _jobdropdownItems = ['JOB', 'Hour'];
  final List<String> _whatDropdownItems = [
    'VVS',
    'Electrician',
    'Brick Layer',
    'Carpenter',
    'Other'
  ];
  final List<String> _gearOptiondropdownItems = ['Yes', 'No'];
  final List<String> _durationdropdownItems = [
    'week',
    'month',
    'year',
    'once'
  ];

  // This variable holds the selected item
  String _selectedJob = 'JOB';
  String _selectedDuration = 'week';
  String _selectedGearOption = 'Yes';
  String _selectedWhatOption = 'VVS';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // Initialize _selectedOption
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
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 18),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Constants.height15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
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
                            TextWidget(
                              input: widget.jobName,
                              fontsize: 25,
                              fontWeight: FontWeight.w600,
                              textcolor: AppColors.textBlue,
                            ),
                          ],
                        ),
                      ),
                      TextWidget(
                        input: 'FIXRR',
                        fontsize: 38,
                        fontWeight: FontWeight.w600,
                        textcolor: AppColors.textBlue,
                      ),
                    ],
                  ),
                  form(context),
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

  Widget form(BuildContext context) {
    return Form(
        key: jobPostFormKey,
        child: Column(children: [
          NameInputWidget(
              title: "Postal Code",
              isRequired: true,
              icon: Icons.post_add,
              error: "Enter Post Code",
              keyboardType: TextInputType.name,
              value: (val) {
                postCode = val!;
              },
              validate: true,
              isPassword: false,
              hintColor: AppColors.textBlue),
          Constants.height15,
          NameInputWidget(
              title: "Street Name",
              isRequired: true,
              error: "Enter Street Name",
              icon: Icons.streetview,
              keyboardType: TextInputType.name,
              value: (val) {
                streetName = val!;
              },
              validate: true,
              isPassword: false,
              hintColor: AppColors.greyColor),
          Constants.height15,
          NameInputWidget(
              title: "Date",
              isRequired: true,
              error: "Enter Date",
              icon: Icons.date_range,
              keyboardType: TextInputType.name,
              value: (val) {
                date = val!;
              },
              validate: true,
              isPassword: false,
              hintColor: AppColors.greyColor),
          Constants.height15,
          if (widget.jobName == "Odd Jobs")
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: AppColors.primaryColor,
                    border: Border.all(
                      width: 1,
                      color: AppColors.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
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
                      TextWidget(
                        input: 'What?',
                        fontsize: 25,
                        fontWeight: FontWeight.w600,
                        textcolor: AppColors.textBlue,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 130,
                  child: DropdownButtonFormField<String>(
                    value: _selectedWhatOption,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.primaryColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: AppColors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedWhatOption = newValue!;
                      });
                    },
                    items: _whatDropdownItems
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          Constants.height15,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                input: 'About the Job',
                fontsize: 35,
                fontWeight: FontWeight.w800,
                textcolor: AppColors.textBlue,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: AppColors.primaryColor,
                  border: Border.all(
                    width: 1,
                    color: AppColors.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
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
                    TextWidget(
                      input: 'Price Pr.',
                      fontsize: 25,
                      fontWeight: FontWeight.w600,
                      textcolor: AppColors.textBlue,
                    ),
                  ],
                ),
              ),
              Container(
                width: 130,
                child: DropdownButtonFormField<String>(
                  value: _selectedJob,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.primaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                        color: AppColors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedJob = newValue!;
                    });
                  },
                  items: _jobdropdownItems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Constants.height15,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: AppColors.primaryColor,
                  border: Border.all(
                    width: 1,
                    color: AppColors.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
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
                    TextWidget(
                      input: 'Duration',
                      fontsize: 25,
                      fontWeight: FontWeight.w600,
                      textcolor: AppColors.textBlue,
                    ),
                  ],
                ),
              ),
              Container(
                width: 130,
                child: DropdownButtonFormField<String>(
                  value: _selectedDuration,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.primaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                        color: AppColors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedDuration = newValue!;
                    });
                  },
                  items: _durationdropdownItems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Constants.height15,
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
                        input: 'Price Range',
                        fontsize: 20,
                        fontWeight: FontWeight.w600,
                        textcolor: AppColors.textBlue,
                      ),
                      TextWidget(
                        input: '100-500 DKK/hr',
                        fontsize: 15,
                        fontWeight: FontWeight.w400,
                        textcolor: AppColors.black,
                      ),
                    ],
                  ),
                  RangeSlider(
                    values: _priceRange,
                    max: 500,
                    divisions: 5,
                    activeColor: AppColors.textBlue,
                    inactiveColor: AppColors.greyColor,
                    labels: RangeLabels(
                      _priceRange.start.round().toString(),
                      _priceRange.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _priceRange = values;
                        priceRange = _priceRange.start.round().toString();
                        endPriceRange = _priceRange.end.round().toString();
                        print(priceRange);
                        print(endPriceRange);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Constants.height15,
          /*  Container(
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
                    input: '10km',
                    fontsize: 18,
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
                  });
                },
              ),
            ],
          ),
        ),
      ),*/
          Constants.height15,
          TextFormField(
            style: const TextStyle(color: AppColors.textBlue),
            decoration: InputDecoration(
                fillColor: AppColors.primaryColor,
                filled: true,
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: new BorderSide(
                      color: AppColors.black,
                    )),
                hintText: "Job Description",
                labelText: "Description",
                labelStyle: TextStyle(color: AppColors.textBlue),
                hintStyle: TextStyle(color: AppColors.textBlue)),
            maxLines: 5,
            obscureText: false,
            validator: (password) {
              if (password!.isEmpty) {
                return 'Message is empty';
              }
            },
            onSaved: (value) {
              jobDescription = value!;
            },
            onChanged: (value) {
              setState(() {});
            },
          ),
          Constants.height15,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: AppColors.primaryColor,
                  border: Border.all(
                    width: 1,
                    color: AppColors.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
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
                      TextWidget(
                        input:
                            'Should the fixrr bring the gear & tools needed?',
                        fontsize: 18,
                        fontWeight: FontWeight.w500,
                        textcolor: AppColors.textBlue,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 130,
                child: DropdownButtonFormField<String>(
                  value: _selectedGearOption,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.primaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                        color: AppColors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGearOption = newValue!;
                    });
                  },
                  items: _gearOptiondropdownItems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Constants.height15,
          BtnNullHeightWidth(
            title: 'Apply',
            bgcolour: AppColors.textBlue,
            textcolour: AppColors.primaryColor,
            onPress: () {
              final form = jobPostFormKey.currentState;
              form!.save();
              if (form.validate()) {
                postJobFunction();

              }
            },
            width: MediaQuery.of(context).size.width,
            height: 48,
          ),
        ]));
  }

  Future<dynamic> postJobFunction() async {
    print(postCode);
    print(widget.jobName);
    print(streetName);
    print(date);
    print(_selectedJob);
    print(_selectedDuration);
    print("$priceRange-$endPriceRange");
    print(jobDescription);
    print(Constants.userID);

    setState(() {
      isLoading = true; // Show loader
    });

    var url = Uri.parse('${Constants.baseUrl}jobs');
    var response = await http.post(
      url,
      body: {
        "postcode": postCode,
        "job_name": widget.jobName,
        "street_name": streetName,
        "date": date,
        "price_per": _selectedJob,
        "duration": _selectedDuration,
        "price_range": "$priceRange-$endPriceRange",
        "description":jobDescription,
        "gear_tool":_selectedGearOption,
        "lat":"32.15290269186808",
        "lon":"74.19000735191902",
        "user_id":Constants.userID,
       // "what":_selectedWhatOption.toString(),


      },
    ).timeout(const Duration(seconds: 10), onTimeout: () {
      return confirmationPopup(context, "Check your Internet Connection!");
    });

    if (response.statusCode == 200) {
      print(response.body);
      dynamic body = jsonDecode(response.body);
      dynamic status = body['status'];

      if (status == "success") {

        dynamic jobDetails=body["job"];

        print(jobDetails);
        dynamic jobName = jobDetails["job_name"];
        setState(() {
          isLoading = false; // Show loader
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
            MatchList(jobName:jobName,),
          ),
        );
       // Navigator.pushNamed(context, Constants.matchFinderScreen);

      } else {
        setState(() {
          isLoading = false; // Show loader
        });
        print(response.body);
        dynamic body = jsonDecode(response.body);
        String error = body['message'];

        confirmationPopup(context, error);
      }
    } else {
      setState(() {
        isLoading = false; // Show loader
      });
      print(response.statusCode);
      dynamic body = jsonDecode(response.body);
      String error = body['message'];

      confirmationPopup(context, error);
    }
    ;
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
