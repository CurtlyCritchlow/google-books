class GoogleBooksFavouritesServiceModel {
  late String id;
  late String selfLink;
  late String? title;
  late String? imageLink;
  late List<String>? authors;
  late num? averageRating;
  late List<String>? categories;
  late String userUid;

  GoogleBooksFavouritesServiceModel.empty();
  GoogleBooksFavouritesServiceModel({
    required this.id,
    required this.selfLink,
    required this.title,
    required this.imageLink,
    required this.authors,
    required this.averageRating,
    required this.categories,
    required this.userUid,
  });

  GoogleBooksFavouritesServiceModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          selfLink: json['selfLink'] as String,
          title: json['title'] != null ? json['title'] as String? : null,
          imageLink:
              json['imageLink'] != null ? json['imageLink'] as String? : null,
          authors: (json['authors'] as List<dynamic>?)?.cast(),
          averageRating: json['averageRating'] as num?,
          categories: (json['categories'] as List<dynamic>?)?.cast(),
          userUid: json['userUid'] as String,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'selfLink': selfLink,
      'title': title,
      'imageLink': imageLink,
      'authors': authors,
      'averageRating': averageRating,
      'categories': categories,
      'userUid': userUid,
    };
  }
}
