import 'package:day2/features/auth/screen/pin_code_screen.dart';
import 'package:day2/features/auth/screen/user_information.dart';
import 'package:day2/landing/screen/landing_page.dart';
import 'package:day2/router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark, // Ensure components use dark theme
        ),),
      theme: ThemeData(
         
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PinCodeVerificationScreen(verificationId: 'verificationId'),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}


