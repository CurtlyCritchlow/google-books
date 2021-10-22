import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_books/commands/add_google_books_favourite_command.dart';
import 'package:google_books/commands/remove_google_books_favourite_command.dart';
import 'package:google_books/screens/google_books_screens/google_book_favourites_list_screen.dart';
import 'package:google_books/services/service_models/google_books_favorites_service_model.dart';
import 'package:google_books/services/service_models/google_books_service_model.dart';
import 'package:google_books/utils/abstract.dart';
import 'package:google_books/utils/page_routes.dart';
import 'package:google_books/utils/styles.dart';
import 'package:google_books/utils/utils.dart';
import 'package:google_books/widgets/center_header.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoogleBooksDetailScreen extends StatefulWidget {
  static String routeName = 'GoogleBooksDetailScreen';
  final GoogleBooksServiceModel googleBooksDetails;
  final bool isFavouriteGoogleBooks;
  const GoogleBooksDetailScreen({
    required this.googleBooksDetails,
    this.isFavouriteGoogleBooks = false,
    Key? key,
  }) : super(key: key);

  @override
  _GoogleBooksDetailScreenController createState() =>
      _GoogleBooksDetailScreenController();
}

class _GoogleBooksDetailScreenController
    extends State<GoogleBooksDetailScreen> {
  @override
  Widget build(BuildContext context) => _GoogleBooksDetailScreenView(this);
  void addToFavorite() {
    AddGoogleBookFavouritesCommand(context).run(
      context: context,
      googleBooksFavouritesServiceModel: GoogleBooksFavouritesServiceModel(
          id: widget.googleBooksDetails.id,
          selfLink: widget.googleBooksDetails.selfLink,
          title: widget.googleBooksDetails.title,
          imageLink: widget.googleBooksDetails.imageLink,
          authors: widget.googleBooksDetails.authors,
          averageRating: widget.googleBooksDetails.averageRating,
          categories: widget.googleBooksDetails.categories,
          userUid: Provider.of<User?>(context, listen: false)!.uid),
    );
    setState(() {});
  }

  void removeFromFavorite() async {
    await RemoveGoogleBookFavouritesCommand(context).run(
      id: widget.googleBooksDetails.id,
      context: context,
    );
    Navigator.of(context).pop();
  }
}

class _GoogleBooksDetailScreenView extends WidgetView<GoogleBooksDetailScreen,
    _GoogleBooksDetailScreenController> {
  // ignore: annotate_overrides, overridden_fields, prefer_typing_uninitialized_variables
  final state;
  const _GoogleBooksDetailScreenView(this.state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          state.widget.googleBooksDetails.title ?? 'Book' ' Details',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: double.infinity,
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: state.widget.googleBooksDetails.imageLink != null
                            ? Image.network(
                                state.widget.googleBooksDetails.imageLink!,
                                width: ResponsiveWidget.isMobileScreen(context)
                                    ? 450.0
                                    : 450.0,
                                height: ResponsiveWidget.isMobileScreen(context)
                                    ? 250
                                    : 550.0,
                                fit: BoxFit.cover,
                              )
                            : CenterHeader(
                                title: 'No Image Available',
                                style: TextStyles.title),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: ResponsiveWidget(
                          mobileScreen: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              state.widget.isFavouriteGoogleBooks
                                  ? ElevatedButton.icon(
                                      onPressed: state.removeFromFavorite,
                                      icon: const Icon(Icons.delete),
                                      label:
                                          const Text('Delete from favourites'),
                                    )
                                  : ElevatedButton.icon(
                                      onPressed: state.addToFavorite,
                                      icon: const Icon(Icons.favorite),
                                      label: const Text('Add to favourites')),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Column(
                      children: [
                        Text(
                          state.widget.googleBooksDetails.description ?? '',
                          style: TextStyles.cardTextContent,
                        ),
                        BookStat(
                          category: 'Title',
                          value: state.widget.googleBooksDetails.title ??
                              'Not Available',
                        ),
                        BookStat(
                          category: 'Author',
                          value: state.widget.googleBooksDetails.authors
                                  ?.join(', ') ??
                              'Not Available',
                        ),
                        BookStat(
                          category: 'Publisher',
                          value: state.widget.googleBooksDetails.publisher ??
                              'Not Available',
                        ),
                        BookStat(
                          category: 'Published Date',
                          value:
                              state.widget.googleBooksDetails.publishedDate ??
                                  'Not Available',
                        ),
                        BookStat(
                          category: 'Page Count',
                          value: state.widget.googleBooksDetails.pageCount
                                      .toString() !=
                                  'null'
                              ? state.widget.googleBooksDetails.pageCount
                                  .toString()
                              : 'Not Available',
                        ),
                        BookStat(
                          category: 'Published Date',
                          value:
                              state.widget.googleBooksDetails.publishedDate ??
                                  'Not Available',
                        ),
                        BookStat(
                          category: 'Categories',
                          value: state.widget.googleBooksDetails.categories
                                  ?.join(', ') ??
                              'Not Available',
                        ),
                        BookStat(
                          category: 'Average Rating',
                          value: state.widget.googleBooksDetails.averageRating
                                      .toString() !=
                                  'null'
                              ? state.widget.googleBooksDetails.averageRating
                                  .toString()
                              : 'Not Available',
                        ),
                        BookStat(
                          category: 'Maturity Rating',
                          value: state.widget.googleBooksDetails.maturityRating
                                  ?.replaceAll('_', ' ') ??
                              'Not Available',
                        ),
                        BookStat(
                          category: 'Saleability',
                          value: state.widget.googleBooksDetails.saleability
                                  ?.replaceAll('_', ' ') ??
                              'Not Available',
                        ),
                        BookStat(
                          category: 'Buy Link',
                          value: state.widget.googleBooksDetails.buyLink ??
                              'Not Available',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BookStat extends StatelessWidget {
  final String category;
  final String value;
  const BookStat({required this.category, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ResponsiveWidget(
        mobileScreen: Column(
          children: [
            Text(
              category + ':',
              style: TextStyles.body,
              textAlign: TextAlign.center,
            ),
            Text(
              value,
              style: TextStyles.body.bold,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        tabletScreen: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                category + ':',
                style: TextStyles.body,
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 3,
              child: Text(
                value,
                style: TextStyles.body.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
///