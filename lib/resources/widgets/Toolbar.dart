import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'app_text.dart';

class ToolbarBack extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;
  final List<Widget>? action;

  const ToolbarBack({Key? key, required this.title,required  this.appBar, this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (
        AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
            centerTitle: true,
          elevation: 0,

          title:Column(
            children: [
              AppText(
                title,
                size: 17,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ],
          ),
          actions: action ?? [],
          iconTheme: const IconThemeData(
            color: AppColors.black,

            //change your color here
          ),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
