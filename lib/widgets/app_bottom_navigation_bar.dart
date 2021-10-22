import 'package:flutter/material.dart';
import 'package:google_books/screens/google_books_screens/book_list_screen.dart';
import 'package:google_books/screens/google_books_screens/google_book_favourites_list_screen.dart';
import 'package:google_books/screens/settings_screen.dart';
import 'package:google_books/utils/page_routes.dart';

class AppButtomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  const AppButtomNavigationBar({
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (int index) {
        if (index == 0) {
          Navigator.of(context)
              .push(PageRoutes.fadeThrough(() => const BookListScreen()));
        } else if (index == 1) {
          Navigator.of(context).push(PageRoutes.fadeThrough(
              () => const GoogleBooksFavouriteListScreen()));
        } else {
          Navigator.of(context)
              .push(PageRoutes.fadeThrough(() => const SettingsScreen()));
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite), label: 'Favourites'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}
