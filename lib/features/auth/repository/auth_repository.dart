import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectaa/common/utiles/utiles.dart';
import 'package:connectaa/features/auth/screens/otp_screen.dart';
import 'package:connectaa/features/auth/screens/user_info.dart';
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
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, UserInfoScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
  }
}
