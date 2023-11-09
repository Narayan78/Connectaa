// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectaa/common/repository/common_firebase_repository.dart';
import 'package:connectaa/common/utiles/utiles.dart';
import 'package:connectaa/features/auth/screens/otp_screen.dart';
import 'package:connectaa/features/auth/screens/user_info.dart';
import 'package:connectaa/features/select_contact/screens/mobile_screen.dart';
import 'package:connectaa/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
      auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({required this.auth, required this.firestore});

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }

    return user;
  }

  void signInWithPhoneNUmber(BuildContext context, String phoneNumner) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumner,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            throw Exception(e.message);
          },
          codeSent: (String verificationID, int? resentToken) async {
            Navigator.pushNamed(context, OTPScreen.routeName,
                arguments: verificationID);
          },
          codeAutoRetrievalTimeout: (String verificationID) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
  }

  void verifyOTP({
    required BuildContext context,
    required userOTP,
    required verificationID,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: userOTP);
      await auth.signInWithCredential(credential);

      Navigator.pushNamedAndRemoveUntil(
          context, UserInfoScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
  }

  void saveUserDataToFirebase({
    required File? profilePic,
    required String name,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl = "assets/user_icon.png";
      if (profilePic != null) {
        photoUrl =
            await ref.read(commonFirebaseStorageRepository).putFileToFirebase(
                  ref: "profilePic/$uid",
                  file: profilePic,
                );
      }
      var user = UserModel(
          name: name,
          uid: uid,
          profilePic: photoUrl,
          isOnline: true,
          phoneNumber: auth.currentUser!.phoneNumber!,
          groupId: []);

      await firestore.collection('users').doc(uid).set(user.toMap());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MobileScreenLayout()),
          (route) => false);
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
  }
}
