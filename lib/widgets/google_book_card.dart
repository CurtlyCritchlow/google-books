import 'package:google_books/commands/favourite_google_book_details_command.dart';
import 'package:google_books/screens/google_books_screens/google_book_detail_screen.dart';
import 'package:google_books/services/service_models/google_books_favorites_service_model.dart';
import 'package:google_books/services/service_models/google_books_service_model.dart';
import 'package:google_books/utils/constants.dart';
import 'package:google_books/utils/page_routes.dart';
import 'package:google_books/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_books/widgets/center_header.dart';

import 'package:google_books/utils/utils.dart';

// class GoogleBookCardTabletView extends StatelessWidget {
//   final GoogleBooksServiceModel? googleBook;
//   final GoogleBooksFavouritesServiceModel? favouriteGoogelBook;
//   const GoogleBookCardTabletView(
//       {this.googleBook, this.favouriteGoogelBook, Key? key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         // Navigator.of(context).push(PageRoutes.fadeScale(
//         //     () => FarmerDetailScreen(farmerId: googleBook.id)));
//       },
//       child: FractionallySizedBox(
//         widthFactor: 0.8,
//         child: Card(
//           shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(20.0))),
//           elevation: 8,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: googleBook?.imageLink != null
//                         ? ClipRRect(
//                             child: Image.network(googleBook!.imageLink!),
//                             borderRadius: BorderRadius.circular(15),
//                           )
//                         : CenterHeader(
//                             title: 'No Image Available',
//                             style: TextStyles.title),
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         googleBook != null
//                             ? googleBook!.authors != null
//                                 ? 'by ' + googleBook!.authors!.join(", ")
//                                 : ''
//                             : '',
//                         style: const TextStyle(color: kAuthorColor),
//                       ),
//                       Text(
//                         googleBook.authors != null ? googleBook.title! : '',
//                         style: ResponsiveWidget.isMobileScreen(context)
//                             ? TextStyles.titleSm.bold
//                             : TextStyles.title.bold,
//                       ),
//                       googleBook.averageRating.toString() != 'null'
//                           ? ListTile(
//                               minLeadingWidth: 2,
//                               leading: const Icon(
//                                 Icons.star,
//                                 color: kReviewColor,
//                               ),
//                               title: Text(googleBook.averageRating.toString()),
//                             )
//                           : const SizedBox(),
//                       Wrap(
//                           spacing: 8.0,
//                           children: googleBook.categories != null
//                               ? googleBook.categories!
//                                   .map((e) => Chip(
//                                         label: Text(
//                                           e,
//                                           style: const TextStyle(
//                                               color: kCategoryTextColor),
//                                         ),
//                                         backgroundColor:
//                                             kCategoryBackgroundColor,
//                                       ))
//                                   .toList()
//                               : [])
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class GoogleBookCardMobileView extends StatelessWidget {
  final GoogleBooksServiceModel? googleBook;
  final GoogleBooksFavouritesServiceModel? favouriteGoogleBook;
  const GoogleBookCardMobileView({
    this.googleBook,
    this.favouriteGoogleBook,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        GoogleBooksServiceModel? favouriteBook;
        if (favouriteGoogleBook != null) {
          favouriteBook = await FavouriteGoogleBookDetailCommand(context)
              .run(selflink: favouriteGoogleBook!.selfLink, context: context);
        }
        Navigator.of(context).push(
          PageRoutes.fadeScale(
            () => GoogleBooksDetailScreen(
              googleBooksDetails: favouriteBook ?? googleBook!,
              isFavouriteGoogleBooks: favouriteBook != null ? true : false,
            ),
          ),
        );
      },
      child: FractionallySizedBox(
        widthFactor: ResponsiveWidget.isMobileScreen(context) ? 0.99 : 0.8,
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: googleBook != null
                        ? googleBook!.imageLink != null
                            ? ClipRRect(
                                child: Image.network(googleBook!.imageLink!),
                                borderRadius: BorderRadius.circular(15),
                              )
                            : CenterHeader(
                                title: 'No Image Available',
                                style: TextStyles.title)
                        : favouriteGoogleBook!.imageLink != null
                            ? ClipRRect(
                                child: Image.network(
                                    favouriteGoogleBook!.imageLink!),
                                borderRadius: BorderRadius.circular(15),
                              )
                            : CenterHeader(
                                title: 'No Image Available',
                                style: TextStyles.title),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        googleBook != null
                            ? googleBook!.authors != null
                                ? 'by ' + googleBook!.authors!.join(", ")
                                : ''
                            : favouriteGoogleBook!.authors != null
                                ? 'by ' +
                                    favouriteGoogleBook!.authors!.join(", ")
                                : '',
                        style: const TextStyle(color: kAuthorColor),
                      ),
                      Text(
                        googleBook != null
                            ? googleBook!.title != null
                                ? googleBook!.title!
                                : ''
                            : favouriteGoogleBook!.title != null
                                ? favouriteGoogleBook!.title!
                                : '',
                        style: ResponsiveWidget.isMobileScreen(context)
                            ? TextStyles.titleSm.bold
                            : TextStyles.title.bold,
                      ),
                      googleBook != null
                          ? googleBook!.averageRating.toString() != 'null'
                              ? ListTile(
                                  minLeadingWidth: 2,
                                  leading: const Icon(
                                    Icons.star,
                                    color: kReviewColor,
                                  ),
                                  title: Text(
                                      googleBook!.averageRating.toString()),
                                )
                              : const SizedBox()
                          : favouriteGoogleBook!.averageRating.toString() !=
                                  'null'
                              ? ListTile(
                                  minLeadingWidth: 2,
                                  leading: const Icon(
                                    Icons.star,
                                    color: kReviewColor,
                                  ),
                                  title: Text(favouriteGoogleBook!.averageRating
                                      .toString()),
                                )
                              : const SizedBox(),
                      Wrap(
                          spacing: 8.0,
                          children: googleBook != null
                              ? googleBook!.categories != null
                                  ? googleBook!.categories!
                                      .map((e) => Chip(
                                            label: Text(
                                              e,
                                              style: const TextStyle(
                                                  color: kCategoryTextColor),
                                            ),
                                            backgroundColor:
                                                kCategoryBackgroundColor,
                                          ))
                                      .toList()
                                  : []
                              : favouriteGoogleBook!.categories != null
                                  ? favouriteGoogleBook!.categories!
                                      .map((e) => Chip(
                                            label: Text(
                                              e,
                                              style: const TextStyle(
                                                  color: kCategoryTextColor),
                                            ),
                                            backgroundColor:
                                                kCategoryBackgroundColor,
                                          ))
                                      .toList()
                                  : []),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
