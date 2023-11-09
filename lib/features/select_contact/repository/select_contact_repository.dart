// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectaa/common/utiles/utiles.dart';
import 'package:connectaa/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectContactsRepositoryProvider = Provider(
  (ref) => SelectContactRepository(firestore: FirebaseFirestore.instance),
);

class SelectContactRepository {
  final FirebaseFirestore firestore;

  SelectContactRepository({required this.firestore});

  Future<List<Contact>> getContact() async {
    List<Contact> contacts = [];

    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectContact(Contact selectedcontact, BuildContext context) async {
    String selectedPhoneNumber =
        selectedcontact.phones[0].number.replaceAll(" " , "" );

        selectedPhoneNumber = selectedPhoneNumber.replaceAll("-", "");
    if (selectedPhoneNumber.length == 10) {
      selectedPhoneNumber = "+977$selectedPhoneNumber";
    }
    try {
      var userCollection = await firestore.collection('users').get();
      bool isFound = false;
      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        if (userData.phoneNumber == selectedPhoneNumber) {
          isFound = true;
          showSnackBar(context: context, message: "User found");
        }
      }
      if (isFound == false) {
        showSnackBar(context: context, message: "This Number is doesn't exist");
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
  }
}
