import 'dart:async';

import 'package:day2/common/widgets/widget.dart';
import 'package:day2/features/auth/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class PinCodeVerificationScreen extends ConsumerStatefulWidget {
  static const routeName = '/pin-code-verification-screen';
  const PinCodeVerificationScreen({
    super.key,
    required this.verificationId,
  });

  final String verificationId;

  @override
  ConsumerState<PinCodeVerificationScreen> createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends ConsumerState<PinCodeVerificationScreen> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: const  Text(
                  'Phone Number Verification',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
      ),
      body: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
             
             
             SizedBox(height: 40,),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0,vertical: 0),
                child: Text(
                  'Enter the code sent to your number',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,)
                ),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 30,
                  ),
                  child: PinCodeTextField(
                    autoFocus: true,
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    obscureText: true,
                    obscuringCharacter: '*',
                    obscuringWidget: const FlutterLogo(
                      size: 24,
                    ),
                  
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.length < 3) {
                        return "I'm from validator";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      debugPrint("Completed");
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      debugPrint(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*Please fill up all the cells properly" : "",
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
             
             
              
              SizedBox(
                child: Image.asset(
                  'assets/otp.png',
                  height: 150.0,
                  width: 150.0,
                )
              ),
              const SizedBox(
                height: 40,
              ),
             SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
               child: bottomWidget(text: 'VERIFY', onPressed: () {
                        formKey.currentState!.validate();
                        // conditions for validating
                        if (currentText.length != 6) {
                          errorController!.add(ErrorAnimationType
                              .shake); // Triggering error shake animation
                          setState(() => hasError = true);
                        } else {
                          setState(
                            () {
                              hasError = false;
                              ref.read(AuthControllerProvider).verifyOTP(context: context, verificationId: widget.verificationId, otp: currentText);
                              snackBar("OTP Verified!!");
                            },
                          );
                        }
                      },),
             ),
              const SizedBox(
                height: 16,
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}