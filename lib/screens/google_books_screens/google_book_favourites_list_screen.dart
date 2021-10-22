import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_books/services/service_models/google_books_service_model.dart';
import 'package:google_books/widgets/center_header.dart';
import 'package:provider/provider.dart';

import 'package:google_books/services/service_models/google_books_favorites_service_model.dart';
import 'package:google_books/utils/abstract.dart';
import 'package:google_books/utils/styles.dart';
import 'package:google_books/utils/utils.dart';
import 'package:google_books/widgets/app_bottom_navigation_bar.dart';
import 'package:google_books/widgets/google_book_card.dart';

class GoogleBooksFavouriteListScreen extends StatefulWidget {
  static String routeName = 'bookListScreen';
  const GoogleBooksFavouriteListScreen({
    Key? key,
  }) : super(key: key);

  @override
  _GoogleBooksFavotitesListScreenController createState() =>
      _GoogleBooksFavotitesListScreenController();
}

class _GoogleBooksFavotitesListScreenController
    extends State<GoogleBooksFavouriteListScreen> {
  @override
  Widget build(BuildContext context) =>
      _GoogleBooksFavotitesListScreenView(this);
  late TextEditingController textController;
  late List<GoogleBooksFavouritesServiceModel?> favouriteGoogleBooks;
  final GoogleBooksServiceModel? favouriteGoogleBook = null;
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    favouriteGoogleBooks =
        Provider.of<List<GoogleBooksFavouritesServiceModel?>>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}

class _GoogleBooksFavotitesListScreenView extends WidgetView<
    GoogleBooksFavouriteListScreen, _GoogleBooksFavotitesListScreenController> {
  // ignore: annotate_overrides, prefer_typing_uninitialized_variables, overridden_fields
  final state;
  const _GoogleBooksFavotitesListScreenView(this.state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Explore your favourite books on the go',
                    style: TextStyles.title.bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Expanded(
                child: state.favouriteGoogleBooks.isNotEmpty
                    ? ListView.builder(
                        itemCount: state.favouriteGoogleBooks.length,
                        itemBuilder: (context, index) {
                          return ResponsiveWidget(
                            mobileScreen: GoogleBookCardMobileView(
                                favouriteGoogleBook:
                                    state.favouriteGoogleBooks[index]),
                          );
                        })
                    : CenterHeader(
                        title: 'No Favourite book added as yet',
                        style: TextStyles.title),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: kIsWeb
          ? null
          : const AppButtomNavigationBar(
              selectedIndex: 1,
            ),
    );
  }
}
