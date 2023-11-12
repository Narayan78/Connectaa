import 'package:connectaa/common/common_widgets/error.dart';
import 'package:connectaa/features/chat/screens/mobile_chat_screen.dart';
import 'package:connectaa/features/auth/screens/login_screen.dart';
import 'package:connectaa/features/auth/screens/otp_screen.dart';
import 'package:connectaa/features/auth/screens/user_info.dart';
import 'package:connectaa/features/select_contact/screens/mobile_screen.dart';
import 'package:connectaa/features/select_contact/screens/select_contact_screen.dart';
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
        builder: (context) => OTPScreen(verificationID: verificationID),
      );

    case UserInfoScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserInfoScreen(),
      );

    case MobileScreenLayout.routeName:
      return MaterialPageRoute(
        builder: (context) => const MobileScreenLayout(),
      );

    case SelectContactScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SelectContactScreen(),
      );

    case MobileChatScreen.routeName:
    final arguments = settings.arguments as Map<String , dynamic>;
    final userName = arguments['name'];
    final userUid = arguments['uid'];
      return MaterialPageRoute(
        builder: (context) =>  MobileChatScreen(name: userName , uid: userUid),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: "This page doesnot exist"),
        ),
      );
  }
}
