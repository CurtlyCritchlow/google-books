import 'package:google_books/services/authentication_service.dart';
import 'package:google_books/services/google_books_service.dart';
import 'package:google_books/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// void init(BuildContext c) => _mainContext = c;

class BaseCommand {
  static BuildContext? _lastKnownRoot;

  /// Provide all commands access to the global context & navigator
  late BuildContext context;
  BaseCommand(BuildContext c) {
    context = (c == _lastKnownRoot) ? c : Provider.of(c, listen: false);
  }
  T getProvided<T>() => Provider.of<T>(context, listen: false);
  // Models
  // FavoriteBookModel get favoriteBookModel => getProvided();

  // Services
  AuthenticationService get authenticationService => getProvided();
  UserService get userService => getProvided();
  GoogleBooksService get googleBooksService => getProvided();
}
