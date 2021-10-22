import 'package:google_books/utils/mixins.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServiceModel with Validation {
  late String email;
  late String? userName;
  late DateTime dateCreated;
  DateTime? dateUpdated;

  UserServiceModel.form();

  UserServiceModel({
    required this.email,
    required this.userName,
    required this.dateCreated,
    this.dateUpdated,
  });

  UserServiceModel.fromJson(Map<String, Object?> json)
      : this(
          email: json['email']! as String,
          userName: json['nickname']! as String?,
          dateCreated: (json['dateCreated'] as Timestamp).toDate(),
          dateUpdated: json['dateUpdated'] == null
              ? json['dateUpdated'] as DateTime?
              : (json['dateUpdated'] as Timestamp).toDate(),
        );

  Map<String, Object?> toJson() {
    return {
      'email': email,
      'nickname': userName,
      'dateCreated': dateCreated,
      'dateUpdated': dateUpdated,
    };
  }

  // VALIDATION METHODS

  // SAVE METHODS
  void saveEmail(String? value) => email = value!;
  void saveUserName(String? value) => userName = value!;
  void saveDateCreated(DateTime value) => dateCreated = value;
  void saveUpdated(DateTime value) => dateUpdated = value;
}
