import 'package:day2/common/widgets/widget.dart';
import 'package:day2/features/auth/screen/auth_screen.dart';

import 'package:flutter/material.dart';


class Landingpage extends StatelessWidget {
  const Landingpage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('welcome',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            
           Container(
              height: size.height * 0.5,
              width: size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90),
                  bottomRight: Radius.circular(90),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/landing.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            
          Column(
            children: [
              const Padding(
            padding: EdgeInsets.all(8.0),
            child:   Center(
                child: Text(
                  'By continuing, you agree to our Terms of Service and Privacy Policy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ),
          ),
         SizedBox(height: 20,),
            SizedBox(
              width: size.width * 0.85,
              child: bottomWidget(text: 'Agree & Continue', onPressed: (){
                Navigator.pushNamed(context, AuthScreen.routeName);
              }),
            )
            ],
          )
          ],
        ),
      )
    );
  }
}