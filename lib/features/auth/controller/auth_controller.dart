import 'dart:io';
import 'package:connectaa/features/auth/repository/auth_repository.dart';
import 'package:connectaa/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = Provider((ref) {
  final AuthRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: AuthRepository, ref: ref);
});

final userDataProvider = FutureProvider(
  (ref) {
    final authController = ref.watch(authControllerProvider);
    return authController.getUserData();
  },
);

class AuthController {
  final ProviderRef ref;
  final AuthRepository authRepository;

  AuthController({required this.authRepository, required this.ref});

  // Controller Function to get Current user information
  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  void signInWithPhone(BuildContext context, String phone) async {
    authRepository.signInWithPhoneNUmber(context, phone);
  }

  void verifyOTPCode(
      BuildContext context, String verificationID, String userOTP) async {
    authRepository.verifyOTP(
        context: context, userOTP: userOTP, verificationID: verificationID);
  }

  void saveUserDataToFirebase(
    BuildContext context,
    String name,
    File? profilePic,
  ) {
    authRepository.saveUserDataToFirebase(
        profilePic: profilePic, name: name, ref: ref, context: context);
  }

  Stream<UserModel> userDataById(String userId) {
    return authRepository.userData(userId);
  }
}
