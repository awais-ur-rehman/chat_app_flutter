import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

class AppText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight? fontWeight;
  final Color? color;
  final bool justifyText;
  final bool alignText;
  final bool underline;
  final int? line;
  final Function()? onTap;

  const AppText(this.text, {
    Key? key,
    this.size = 16,
    this.color = Colors.black,
    this.justifyText = false,
    this.alignText = false,
    this.onTap,
    this.underline = false,
    this.line,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        maxLines: line,
        textAlign: justifyText
            ? TextAlign.justify
            : alignText
            ? TextAlign.center
            : null,
        style: GoogleFonts.urbanist(
          fontWeight: fontWeight,
          color: color,
          fontSize: size,
          decoration: underline ? TextDecoration.underline : null,
        ),
      ),
    );
  }
}

class AppHeadings extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight? fontWeight;
  final Color? color;
  final bool justifyText;
  final bool alignText;
  final bool underline;
  final int? line;
  final Function()? onTap;

  const AppHeadings(this.text, {
    Key? key,
    this.size = 16,
    this.color = Colors.black,
    this.justifyText = false,
    this.alignText = false,
    this.onTap,
    this.underline = false,
    this.line,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        maxLines: line,
        textAlign: justifyText
            ? TextAlign.justify
            : alignText
            ? TextAlign.center
            : null,
        style: GoogleFonts.poppins(
          fontWeight: fontWeight,
          color: color,
          fontSize: size,
          decoration: underline ? TextDecoration.underline : null,
        ),
      ),
    );
  }
}


class AppBarText extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final bool isSelected;

  const AppBarText(
      {Key? key, required this.text, this.onTap, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 2.0, right: 2.0),
        child: Container(
          height: 40,
          width: 60,
          decoration: BoxDecoration(
              border: Border.all(
                  color: isSelected ? AppColors.primaryColor : Colors.white,
                  width: 1)),
          child: Center(
              child: AppText(text,
                  color: Colors.white, size: 11, alignText: true)),
        ),
      ),
    );
  }
}

class AppTextWithInfoIcon extends StatelessWidget {
  final String text;
  final double size;
  final bool bold;
  final Color color;
  final Widget infoIcon;

  const AppTextWithInfoIcon(this.text, {
    Key? key,
    this.size = 18,
    this.bold = false,
    required this.color,
    required this.infoIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: text,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: color,
              fontSize: size,
            ),
          ),
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: infoIcon,
            ),
          ),
        ],
      ),
    );
  }
}

class RequiredText extends StatelessWidget {
  final String labelText;
  final String requiredSign;
  final double labelTextScale;
  final int labelMaxLines;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final Color labelColor;

//  final FontWeight fontWeight;
  final double fontSize;

  const RequiredText(this.labelText, {
    Key? key,
    this.requiredSign = ' *',
    this.labelColor = Colors.black54,
    // this.fontWeight,
    required this.fontSize,
    this.labelMaxLines = 1,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.clip,
    this.labelTextScale = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: RichText(
        text: TextSpan(
            text: labelText,
            style: TextStyle(
              color: labelColor,
              fontSize: fontSize,
            ),
            children: [
              TextSpan(
                  text: requiredSign,
                  style: TextStyle(
                      color: Colors.red,
                      //  fontWeight: fontWeight,
                      fontSize: fontSize))
            ]),
        textScaleFactor: labelTextScale,
        maxLines: labelMaxLines,
        overflow: overflow,
        textAlign: textAlign,
      ),
    );
  }
}
