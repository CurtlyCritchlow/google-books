import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_books/commands/google_books_command.dart';
import 'package:google_books/services/service_models/google_books_service_model.dart';
import 'package:google_books/utils/abstract.dart';
import 'package:google_books/utils/styles.dart';
import 'package:google_books/utils/utils.dart';
import 'package:google_books/widgets/app_bottom_navigation_bar.dart';
import 'package:google_books/widgets/google_book_card.dart';
import 'package:google_books/widgets/snackbars.dart';

class BookListScreen extends StatefulWidget {
  static String routeName = 'bookListScreen';
  const BookListScreen({
    Key? key,
  }) : super(key: key);

  @override
  _BookListScreenController createState() => _BookListScreenController();
}

class _BookListScreenController extends State<BookListScreen> {
  @override
  Widget build(BuildContext context) => _BookListScreenView(this);
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();

    super.dispose();
  }

  List<GoogleBooksServiceModel>? googleBooksSearchResult = [];

  /// Generate a list of google books service model.
  ///
  /// This method calls setstate and GoogleBooksCommand().
  /// It assign the returned value to googleBooksSearchResult.
  void getGoogleBooksSearchResult() async {
    await Utils.isInternetAvailable()
        ? null
        : SnackBars.errorSnackBar(
            content: 'Connect to the internet', context: context);
    googleBooksSearchResult =
        await GoogleBooksCommand(context).run(search: textController.text);
    FocusScope.of(context).unfocus();
    setState(() {});
  }
}

class _BookListScreenView
    extends WidgetView<BookListScreen, _BookListScreenController> {
  // ignore: annotate_overrides, prefer_typing_uninitialized_variables, overridden_fields
  final state;
  const _BookListScreenView(this.state) : super(state);

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
                    'Explore thousands of books on the go',
                    style: TextStyles.title.bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: state.textController,
                    onEditingComplete: state.getGoogleBooksSearchResult,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: 'Search for books...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Famous Books',
                    style: TextStyles.titleSm.bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Expanded(
                child: state.googleBooksSearchResult != null
                    ? ListView.builder(
                        itemCount: state.googleBooksSearchResult!.length,
                        itemBuilder: (context, index) {
                          return ResponsiveWidget(
                            mobileScreen: GoogleBookCardMobileView(
                                googleBook:
                                    state.googleBooksSearchResult![index]),
                          );
                        })
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: kIsWeb
          ? null
          : const AppButtomNavigationBar(
              selectedIndex: 0,
            ),
    );
  }
}
