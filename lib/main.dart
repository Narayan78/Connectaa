import 'package:connectaa/colors.dart';
import 'package:connectaa/common/common_widgets/error.dart';
import 'package:connectaa/features/auth/controller/auth_controller.dart';
import 'package:connectaa/features/landing/landing_screen.dart';
import 'package:connectaa/features/select_contact/screens/mobile_screen.dart';
import 'package:connectaa/firebase_options.dart';
import 'package:connectaa/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: const AppBarTheme(
            color: appBarColor,
          )),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataProvider).when(data: (user){
        if(user == null){
          return const LandingScreen();
        }
         return const MobileScreenLayout();
      }, error: (error , trace){
        return ErrorScreen(error: error.toString());
      }, loading: ()  {
        return const Center(child:  CircularProgressIndicator());
      }),
    );
  }
}
