// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day2/common/widgets/snackbar.dart';
import 'package:day2/features/auth/screen/pin_code_screen.dart';
import 'package:day2/features/auth/screen/user_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AuthRepositoryProvider = Provider(
  (ref) => AuthRepository(
      auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({required this.auth, required this.firestore});

  void loginWithPhoneNumber(BuildContext context, String phoneNumber) async {
    print(phoneNumber);
   try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: ((String verificationId, int? resendToken) async {
          Navigator.pushNamed(
            context,
            PinCodeVerificationScreen.routeName,
            arguments: verificationId,
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar( context,  e.message!);
    }
  }

  //function to vefify the otp
  void verifyOTP(
      BuildContext context, String otp, String verificationId) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(
        context,
       UserInformation.routeName,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar( context, e.message.toString());
    }
  }
}
