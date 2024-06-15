import 'package:day2/features/auth/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AuthControllerProvider = Provider((ref) => AuthController(authRepository: ref.watch(AuthRepositoryProvider)));

class AuthController{
 final AuthRepository authRepository;
  AuthController({required this.authRepository});


  //function to sign in with phone number
  void signInWithPhoneNumber({required String phoneNumber,required BuildContext context}) {
    authRepository.loginWithPhoneNumber(context, phoneNumber);
  }

  //function to verify otp
  void verifyOTP({required String otp,required String verificationId,required BuildContext context}) {
    authRepository.verifyOTP(context, otp, verificationId);
  }


}