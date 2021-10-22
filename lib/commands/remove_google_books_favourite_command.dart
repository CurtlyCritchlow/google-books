import 'package:flutter/material.dart';
import 'package:google_books/services/service_models/google_books_favorites_service_model.dart';

import 'base_command.dart';

class RemoveGoogleBookFavouritesCommand extends BaseCommand {
  final BuildContext c;
  RemoveGoogleBookFavouritesCommand(this.c) : super(c);

  Future<void> run({required String id, required BuildContext context}) async {
    await googleBooksService.removeGoogleBooksFromFavourites(
      id: id,
      context: context,
    );
  }
}
