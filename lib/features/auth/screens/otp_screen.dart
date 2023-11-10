import 'package:connectaa/colors.dart';
import 'package:connectaa/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OTPScreen extends ConsumerWidget {
  static const String routeName = '/otp-screen';
  final String verificationID;
  const OTPScreen({super.key, required this.verificationID});

  void verifyOTP(BuildContext context, String userOTP, WidgetRef ref) {
    ref
        .read(authControllerProvider)
        .verifyOTPCode(context, verificationID, userOTP);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          "Verify your Phone Number",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text("Enter an OTP Code"),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: size.width * 0.5,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "- - - - - -"),
                onChanged: (val) {
                  if (val.length == 6) {
                    verifyOTP(context, val.trim(), ref);
                  }
                },
              ),
            )
          ],
        )),
      ),
    );
  }
}
