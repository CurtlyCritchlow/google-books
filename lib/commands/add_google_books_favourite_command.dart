import 'package:flutter/material.dart';
import 'package:google_books/services/service_models/google_books_favorites_service_model.dart';

import 'base_command.dart';

class AddGoogleBookFavouritesCommand extends BaseCommand {
  final BuildContext c;
  AddGoogleBookFavouritesCommand(this.c) : super(c);

  Future<void> run(
      {required GoogleBooksFavouritesServiceModel
          googleBooksFavouritesServiceModel,
      required BuildContext context}) async {
    await googleBooksService.addGoogleBooksToFavourites(
        googleBooksFavouritesServiceModel: googleBooksFavouritesServiceModel,
        context: context);
  }
}
