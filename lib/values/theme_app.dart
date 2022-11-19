import 'package:flutter/material.dart';
import 'package:mastergoal/values/colors_app.dart';
import 'package:mastergoal/values/textStyle_app.dart';

TextTheme get textTheme => TextTheme(
    subtitle1: subtitle1,
    bodyText2: bodyText2,
    bodyText1: bodyText1,
    headline4: headline4,
    headline3: headline3,
    caption: caption);

TextTheme get textThemeDark => TextTheme(
    subtitle1: subtitle1Dark,
    bodyText2: bodyText2Dark,
    bodyText1: bodyText1Dark,
    headline4: headline4Dark,
    headline3: headline3Dark,
    caption: captionDark);

IconThemeData get iconThemeData1 => IconThemeData(color: icon1Color);

IconThemeData get iconThemeData2 => iconThemeData1.copyWith(color: icon2Color);

IconThemeData get iconThemeDark => IconThemeData(color: iconDark);
