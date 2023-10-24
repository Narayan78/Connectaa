import 'package:connectaa/features/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = Provider((ref) {
  final AuthRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: AuthRepository);
});

class AuthController {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});

  void signInWithPhone(BuildContext context, String phone) async {
    authRepository.signInWithPhoneNUmber(context, phone);
  }

    void verifyOTPCode(BuildContext context, String verificationID, String userOTP) async {
      authRepository.verifyOTP(context: context, userOTP: userOTP, verificationID: verificationID);
  }
}
