class GoogleBooksServiceModel {
  late String id;
  late String selfLink;
  late String? title;
  late List<String>? authors;
  late String? publisher;
  late String? publishedDate;
  late String? description;
  late int? pageCount;
  late List<String>? categories;
  late String? maturityRating;
  late String? imageLink;
  late num? averageRating;
  late String? saleability;
  late String? buyLink;
  GoogleBooksServiceModel.empty();
  GoogleBooksServiceModel({
    required this.id,
    required this.selfLink,
    required this.title,
    required this.authors,
    required this.publisher,
    required this.publishedDate,
    required this.description,
    required this.pageCount,
    required this.categories,
    required this.maturityRating,
    required this.imageLink,
    required this.averageRating,
    required this.saleability,
    required this.buyLink,
  });

  GoogleBooksServiceModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          selfLink: json['selfLink'] as String,
          title: json['volumeInfo']['title'] != null
              ? json['volumeInfo']['title'] as String?
              : null,
          authors: (json['volumeInfo']['authors'] as List<dynamic>?)?.cast(),
          publisher: json['volumeInfo']['publisher'] as String?,
          publishedDate: json['volumeInfo']['publishedDate'] as String?,
          description: json['volumeInfo']['description'] as String?,
          pageCount: json['volumeInfo']['pageCount'] as int?,
          categories:
              (json['volumeInfo']['categories'] as List<dynamic>?)?.cast(),
          maturityRating: json['volumeInfo']['maturityRating'] as String?,
          imageLink: json['volumeInfo']['imageLinks'] != null
              ? json['volumeInfo']['imageLinks']['thumbnail'] as String?
              : null,
          averageRating: json['volumeInfo']['averageRating'] as num?,
          saleability: (json['saleInfo'] as dynamic)['saleability'] as String?,
          buyLink: json['saleInfo']['buyLink'] as String?,
        );
}
