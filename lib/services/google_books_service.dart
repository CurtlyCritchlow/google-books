import 'package:google_books/services/service_models/google_books_favorites_service_model.dart';
import 'package:google_books/services/service_models/google_books_service_model.dart';
import 'package:google_books/utils/constants.dart';
import 'package:google_books/widgets/snackbars.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GoogleBooksService {
  final String googleBookUrl = 'https://www.googleapis.com/books/v1/volumes?';
  final favouritesRef =
      FirebaseFirestore.instance.collection('favourites').withConverter(
            fromFirestore: (snapshot, _) =>
                GoogleBooksFavouritesServiceModel.fromJson(snapshot.data()!),
            toFirestore: (googleBooksFavoritesModel, _) =>
                googleBooksFavoritesModel.toJson(),
          );

  Future<void> addGoogleBooksToFavourites({
    required GoogleBooksFavouritesServiceModel
        googleBooksFavouritesServiceModel,
    required BuildContext context,
  }) async {
    var googleBooksFavouritesDocument =
        favouritesRef.doc(googleBooksFavouritesServiceModel.id);

    googleBooksFavouritesDocument
        .set(googleBooksFavouritesServiceModel)
        .then((value) {
      SnackBars.notificationSnackBar(
          content: 'Book Added to favourites', context: context);
    }).catchError((error) {
      SnackBars.errorSnackBar(content: error.toString(), context: context);
    });
  }

  Future<void> removeGoogleBooksFromFavourites({
    required String id,
    required BuildContext context,
  }) async {
    var googleBooksFavouritesDocument = favouritesRef.doc(id);

    googleBooksFavouritesDocument.delete().then((value) {
      SnackBars.notificationSnackBar(
          content: 'Book removed from favourites', context: context);
    }).catchError((error) {
      SnackBars.errorSnackBar(content: error.toString(), context: context);
    });
  }

  Stream<List<GoogleBooksFavouritesServiceModel?>>
      getFavouriteGoogleBooksWhereFieldEqual(
          {required String field, required String condition}) {
    return favouritesRef
        .where(field, isEqualTo: condition)
        .orderBy('title')
        .snapshots()
        .map((list) => list.docs.map((e) => e.data()).toList());
  }

  Future<List<GoogleBooksServiceModel>?> getBooksWhereSearchMatch({
    required String search,
    required BuildContext context,
  }) async {
    List<GoogleBooksServiceModel> books = [];
    final uri = Uri.parse(googleBookUrl + 'q=$search:keyes&key=$kAPIKey');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for (var book in data['items']) {
        books.add(GoogleBooksServiceModel.fromJson(book));
      }
      return books;
    } else if (response.statusCode == 429) {
      SnackBars.errorSnackBar(
          content: 'rate limit exceeded for today.', context: context);
    } else if (response.statusCode == 400) {
      SnackBars.errorSnackBar(content: 'Bad Request', context: context);
    } else if (response.statusCode == 403) {
      SnackBars.errorSnackBar(content: 'Forbidden', context: context);
    } else if (response.statusCode == 404) {
      SnackBars.errorSnackBar(content: 'Not Found', context: context);
    } else if (response.statusCode == 500) {
      SnackBars.errorSnackBar(
          content: 'Internal Server Error', context: context);
    } else {
      SnackBars.errorSnackBar(
          content: response.statusCode.toString(), context: context);
    }
  }

  Future<GoogleBooksServiceModel?> getFavouriteBook({
    required String selfLink,
    required BuildContext context,
  }) async {
    final uri = Uri.parse(selfLink);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return GoogleBooksServiceModel.fromJson(data);
    } else if (response.statusCode == 429) {
      SnackBars.errorSnackBar(
          content: 'rate limit exceeded for today.', context: context);
    } else if (response.statusCode == 400) {
      SnackBars.errorSnackBar(content: 'Bad Request', context: context);
    } else if (response.statusCode == 403) {
      SnackBars.errorSnackBar(content: 'Forbidden', context: context);
    } else if (response.statusCode == 404) {
      SnackBars.errorSnackBar(content: 'Not Found', context: context);
    } else if (response.statusCode == 500) {
      SnackBars.errorSnackBar(
          content: 'Internal Server Error', context: context);
    } else {
      SnackBars.errorSnackBar(
          content: response.statusCode.toString(), context: context);
    }
  }
}
