import 'package:connectaa/common/common_widgets/error.dart';
import 'package:connectaa/features/auth/screens/finalPage.dart';
import 'package:connectaa/features/auth/screens/login_screen.dart';
import 'package:connectaa/features/auth/screens/otp_screen.dart';
import 'package:connectaa/features/auth/screens/user_info.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );

    case OTPScreen.routeName:
    final verificationID = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) =>  OTPScreen(verificationID: verificationID),
      );
    
    case UserInfoScreen.routeName:
       return MaterialPageRoute(
        builder: (context) => const UserInfoScreen(),
      );

      case HomePage.routeName:
       return MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
     

    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: "This page doesnot exist"),
        ),
      );
  }
}
