import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_books/screens/authentication_screens/signin_page.dart';
import 'package:google_books/screens/authentication_screens/signup_page.dart';
import 'package:google_books/screens/google_books_screens/book_list_screen.dart';
import 'package:google_books/screens/google_books_screens/google_book_favourites_list_screen.dart';
import 'package:google_books/screens/settings_screen.dart';
import 'package:google_books/services/authentication_service.dart';
import 'package:google_books/services/google_books_service.dart';
import 'package:google_books/services/service_models/google_books_favorites_service_model.dart';

import 'package:google_books/services/user_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MultiProvider(
      providers: [
        // Models

        // Services
        Provider(create: (c) => AuthenticationService()),
        Provider(create: (c) => UserService()),
        Provider(create: (c) => GoogleBooksService()),

        Provider<BuildContext>(create: (c) => c),
        StreamProvider<User?>.value(
          value: AuthenticationService().authUser(),
          initialData: null,
        ),
      ],
      child: Builder(builder: (context) {
        var authUser = context.watch<User?>();

        return StreamProvider<List<GoogleBooksFavouritesServiceModel?>>.value(
          value: GoogleBooksService().getFavouriteGoogleBooksWhereFieldEqual(
              field: 'userUid',
              condition: authUser != null ? authUser.uid : ''),
          initialData: const [],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Google Books',
            theme: theme.copyWith(
              colorScheme: theme.colorScheme.copyWith(
                primary: const Color(0xFFD30C7B),
                secondary: const Color(0xFFF8C630),
              ),
            ),
            home:
                authUser == null ? const SignInPage() : const BookListScreen(),
            routes: {
              SignUpPage.routeName: (context) => const SignUpPage(),
              BookListScreen.routeName: (context) => const BookListScreen(),
              GoogleBooksFavouriteListScreen.routeName: (context) =>
                  const GoogleBooksFavouriteListScreen(),
              SettingsScreen.routeName: (context) => const SettingsScreen(),
            },
          ),
        );
      }),
    );
  }
}
