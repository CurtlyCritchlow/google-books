import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text('Search'),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Favourites'),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Settings'),
        )
      ],
    );
  }
}
