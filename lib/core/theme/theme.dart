import 'package:flutter/material.dart';
import 'package:hookadoc_server/core/theme/palette.dart';

class CustomTheme {
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: ColorConstants.backgroundColor,
    iconTheme: const IconThemeData().copyWith(
      color: ColorConstants.liteWhiteColor,
    ),
  );
}
