import 'package:flutter/material.dart';
import 'package:google_books/services/service_models/google_books_service_model.dart';

import 'base_command.dart';

class GoogleBooksCommand extends BaseCommand {
  final BuildContext c;
  GoogleBooksCommand(this.c) : super(c);

  Future<List<GoogleBooksServiceModel>?> run({required String search}) {
    return googleBooksService.getBooksWhereSearchMatch(
        search: search, context: c);
  }
}
