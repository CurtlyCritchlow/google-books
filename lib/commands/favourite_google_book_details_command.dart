import 'package:google_books/commands/base_command.dart';

import 'package:flutter/material.dart';
import 'package:google_books/services/google_books_service.dart';
import 'package:google_books/services/service_models/google_books_service_model.dart';

/// Get log in user favourite books
class FavouriteGoogleBookDetailCommand extends BaseCommand {
  FavouriteGoogleBookDetailCommand(BuildContext c) : super(c);

  /// The method passes a selfLink string to the GoogleBooksService().
  /// getFavouriteGoogleBooksWhereFieldEqual method.
  Future<GoogleBooksServiceModel?> run(
      {required String selflink, required BuildContext context}) {
    return GoogleBooksService()
        .getFavouriteBook(selfLink: selflink, context: context);
  }
}
