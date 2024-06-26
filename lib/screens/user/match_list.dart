import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../models/view_fixrr_model.dart';
import '../../resources/utils/app_colors.dart';
import '../../resources/widgets/text_widget.dart';

class MatchList extends StatefulWidget {

  final int jobId;

MatchList({super.key, required this.jobId});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MatchState();
  }
}

class MatchState extends State<MatchList> {
  List<ViewFixrrModel> fixers = [];
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
        child: ListView.builder(
            itemCount: fixers.length,
            addRepaintBoundaries: true,
            scrollDirection: Axis.vertical,
            shrinkWrap: false,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              ViewFixrrModel object = fixers[index];
              return Card(
                child: Column(
                  children: [
                    TextWidget(
                      input: object.fixerName,
                      fontsize: 20,
                      fontWeight: FontWeight.w300,
                      textcolor: AppColors.black,
                    ),
                    TextWidget(
                      input: object.fixerEmail,
                      fontsize: 20,
                      fontWeight: FontWeight.w300,
                      textcolor: AppColors.black,
                    ),

                  ],
                ),
              );
            }),
      ),
    ));
  }
}
