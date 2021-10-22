import 'package:google_books/commands/base_command.dart';

import 'package:flutter/material.dart';
import 'package:google_books/services/google_books_service.dart';
import 'package:google_books/services/service_models/google_books_favorites_service_model.dart';

/// Get log in user favourite books
class FavouriteGoogleBooksCommand extends BaseCommand {
  FavouriteGoogleBooksCommand(BuildContext c) : super(c);

  /// The method passes a field and condition string to the GoogleBooksService().
  /// getFavouriteGoogleBooksWhereFieldEqual method.
  Stream<List<GoogleBooksFavouritesServiceModel?>> run(
      {required String field, required String condition}) {
    return GoogleBooksService().getFavouriteGoogleBooksWhereFieldEqual(
        field: field, condition: condition);
  }
}
