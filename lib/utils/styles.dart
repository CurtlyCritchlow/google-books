import 'package:flutter/material.dart';

class Fonts {
  static String get body => 'Poppins';
  static String get title => 'Roboto';
}

class Colours {
  static Color primaryColor(BuildContext context) =>
      Theme.of(context).primaryColor;

  static Color secondaryColorScheme(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;
}

class FontSizes {
  static double scale = 1;

  static double get body => 24 * scale;
  static double get bodySm => 14 * scale;
  static double get title => 30 * scale;
  static double get titleSm => 20 * scale;
  static double get drawerTitle => 15 * scale;
  static double get dashboardTitle => 22 * scale;
  static double get cardTitle => 22 * scale;
  static double get cardContent => 20 * scale;
}

class TextStyles {
  static TextStyle get bodyFont => TextStyle(fontFamily: Fonts.body);
  static TextStyle get titleFont => TextStyle(fontFamily: Fonts.title);

  static TextStyle get title => titleFont.copyWith(fontSize: FontSizes.title);
  static TextStyle get titleSm =>
      titleFont.copyWith(fontSize: FontSizes.titleSm);
  static TextStyle get titleLight =>
      title.copyWith(fontWeight: FontWeight.w300);

  static TextStyle get body =>
      bodyFont.copyWith(fontSize: FontSizes.body, fontWeight: FontWeight.w300);

  static TextStyle get bodySm => body.copyWith(fontSize: FontSizes.bodySm);
  static TextStyle get cardTextContent => body.copyWith(
        fontSize: FontSizes.cardContent,
      );
}

extension TestStyleHelpers on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.w900);
  TextStyle get white => copyWith(color: Colors.white);
}

class FormStyles {
  static InputDecoration textFieldDecoration({
    String helperText = '',
    required String labelText,
  }) =>
      InputDecoration(
        border: const OutlineInputBorder(),
        helperText: helperText,
        labelText: labelText,
      );
}
