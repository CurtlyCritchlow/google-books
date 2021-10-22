import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Utils {
  static Future<bool> isInternetAvailable() async {
    bool connectionResult = false;

    try {
      final result = await http.get(Uri.parse('https://www.google.com'));
      if (result.statusCode == 200) {
        connectionResult = true;
      } else {
        connectionResult = false;
      }
    } on SocketException catch (_) {
      connectionResult = false;
    }

    return connectionResult;
  }
}

enum LocationFilter { all, district, region }

enum FormType { create, update }

enum ColumnRowView { column, row }

class ResponsiveWidget extends StatelessWidget {
  final Widget? tabletScreen;
  final Widget mobileScreen;
  final Widget? largeScreen;

  const ResponsiveWidget(
      {required this.mobileScreen, this.tabletScreen, this.largeScreen});
// medium size is 800,large is 1200
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return mobileScreen;
      } else if (constraints.maxWidth >= 600 && constraints.maxWidth < 1200) {
        return tabletScreen ?? mobileScreen;
      } else {
        return largeScreen ?? mobileScreen;
      }
    });
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  static bool isTabletScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1200;
  }

  static bool isMobileScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTabletLandscape(BuildContext context) {
    return isTabletScreen(context) &&
        MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static bool isMobileLandscape(BuildContext context) {
    return isTabletScreen(context) &&
        MediaQuery.of(context).orientation == Orientation.landscape;
  }
}
