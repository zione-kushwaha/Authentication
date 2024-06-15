//routing with switch case
import 'package:day2/features/auth/screen/pin_code_screen.dart';
import 'package:day2/features/auth/screen/user_information.dart';
import 'package:flutter/material.dart';
import 'package:day2/features/auth/screen/auth_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    
    case AuthScreen.routeName:
      return createRoute(const AuthScreen());

   case PinCodeVerificationScreen.routeName:
  final verificationID = settings.arguments as String;
  return createRoute(PinCodeVerificationScreen(verificationId: verificationID));

  case UserInformation.routeName:
  return createRoute(const UserInformation());


    default:
      return  MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('No route defined '),
          )
        ),
      );
  }
}

PageRouteBuilder createRoute(Widget destination) {
  return PageRouteBuilder(
  pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return destination;
  },
  transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child:  SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-1.0, 0.0),
        ).animate(secondaryAnimation),
        child: child,
      ),
    );
  },
);
}