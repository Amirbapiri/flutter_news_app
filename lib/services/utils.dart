import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class Utils {
  BuildContext context;

  Utils(this.context);

  bool get getCurrentTheme =>
      Provider.of<ThemeProvider>(context).getIsDarkTheme;

  Color get getColorForCurrentTheme =>
      getCurrentTheme ? Colors.white : Colors.black;

  static TextStyle get getMainTextStyle => GoogleFonts.lato(
        fontSize: 17.0,
        fontWeight: FontWeight.w600,
      );

  Color get baseShimmerColor =>
      getCurrentTheme ? Colors.grey.shade500 : Colors.grey.shade200;

  Color get highlightShimmerColor =>
      getCurrentTheme ? Colors.grey.shade700 : Colors.grey.shade400;

  Color get widgetShimmerColor =>
      getCurrentTheme ? Colors.grey.shade600 : Colors.grey.shade100;
}
