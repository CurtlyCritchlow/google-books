import 'package:flutter/material.dart';

class CenterHeader extends StatelessWidget {
  final String title;
  final TextStyle style;
  final double top;
  final double bottom;

  const CenterHeader({
    required this.title,
    required this.style,
    this.top = 0.0,
    this.bottom = 24.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom, top: top),
      child: Center(
        child: Text(
          title,
          style: style,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
