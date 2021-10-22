import 'package:google_books/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_books/utils/utils.dart';

class AuthenticationHeader extends StatelessWidget {
  final String title;
  const AuthenticationHeader({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: ResponsiveWidget.isMobileScreen(context) ? 0.9 : 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              style: ResponsiveWidget.isMobileScreen(context)
                  ? TextStyles.titleSm.bold
                  : TextStyles.title.bold,
              softWrap: true,
            ),
          ),
          Flexible(
            child: Image.asset(
              'assets/images/google_books_logo_transparent.png',
            ),
          ),
        ],
      ),
    );
  }
}
