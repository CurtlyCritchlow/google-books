import 'package:flutter/material.dart';
import 'package:google_books/services/service_models/user_service_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_books/widgets/snackbars.dart';

class UserService {
  final userRef = FirebaseFirestore.instance.collection('users').withConverter(
        fromFirestore: (snapshot, _) =>
            UserServiceModel.fromJson(snapshot.data()!),
        toFirestore: (userModel, _) => userModel.toJson(),
      );

  // UserService.test({
  //   this.userRef =
  // });

  Future<void> addUser({
    required String id,
    required UserServiceModel userServiceModel,
    required BuildContext context,
  }) async {
    userServiceModel.dateCreated = DateTime.now();
    return userRef
        .doc(id)
        .set(
          userServiceModel,
        )
        .then((value) => value)
        .catchError((error) {
      SnackBars.errorSnackBar(content: 'Failed to add user', context: context);
    });
  }

  // Check to see is user id is email address if not make user id email address
  // todo: create get 1 user method
  Stream<UserServiceModel> getUser(String email) {
    return userRef
        .where('email', isEqualTo: email)
        .snapshots()
        .map((user) => user.docs.map((e) => e.data()).first);
  }

  // Future<UserServiceModel> getUser(String id) async {
  //   late UserServiceModel data;

  //   userRef.doc(id).snapshots().listen((event) {
  //     print(event.data()!.email);
  //     data = event.data()!;
  //   });
  //   return data;
  // }

  // todo: create update user method
  Future<void> updateUser(String id, UserServiceModel userServiceModel) async {
    userServiceModel.dateUpdated = DateTime.now();
    return userRef
        .doc(id)
        .update(
          userServiceModel.toJson(),
        )
        .then((value) {
      print("User updated");
    }).catchError((error) {
      print('Failed to update user: $error');
    });
  }
}
