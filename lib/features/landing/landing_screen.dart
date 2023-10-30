import 'package:connectaa/colors.dart';
import 'package:connectaa/common/common_widgets/custom_button.dart';
import 'package:connectaa/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.09,
            ),
            const Text(
              "Welcome to Connectaa",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: size.height * 0.09,
            ),
            Image.asset(
              "assets/bg.png",
              height: 270,
              width: 270,
              color: tabColor,
            ),
            SizedBox(
              height: size.height * 0.09,
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Read our privacy and policy. Tap "Agree and Continue" to accept and continue',
                style: TextStyle(color: greyColor),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: size.width * 0.75,
              child: CustomButton(
                  onPressed: () => navigateToLoginScreen(context),
                  text: "AGREE AND CONTINUE"),
            ),
          ],
        ),
      ),
    );
  }
}
