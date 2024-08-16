import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hookadoc_server/core/theme/palette.dart';

Widget kText(
  String text, {
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.normal,
  Color color = ColorConstants.whiteColor,
  String fontFamily = 'Open Sans',
  TextAlign textAlign = TextAlign.left,
  int? maxLines,
  TextOverflow textOverflow = TextOverflow.ellipsis,
}) {
  return Text(
    text,
    maxLines: maxLines,
    overflow: textOverflow,
    textAlign: textAlign,
    style: GoogleFonts.getFont(
      fontFamily,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget kHeight(double height) => SizedBox(
      height: height,
    );

Widget kWidth(double width) => SizedBox(
      width: width,
    );
