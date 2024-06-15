import 'dart:io';

import 'package:flutter/material.dart';
import '../../../common/widgets/widget.dart';

class UserInformation extends StatefulWidget {
 const  UserInformation({super.key});
static const routeName = '/user-information';

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  File? _image;
  void pickImage()async{
    
    _image = await pickImageFromGallery(context);
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text('User Information'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
           Stack(
             children: [
               CircleAvatar(
                 radius: 60,
                 backgroundColor: Colors.blue.withOpacity(0.5),
                 child: _image==null? Icon(Icons.person,size: 120,):ClipRRect(
                   borderRadius: BorderRadius.circular(60),
                   child: Image.file(_image!,width: 120,height: 120,fit: BoxFit.cover,),
                 )
               ),
               Positioned(bottom: -5,
                    right: -5,
              child: IconButton(onPressed:pickImage , icon: const Icon(Icons.add_a_photo,color: Colors.white,size: 40,),),)
             ],
           ),
            const SizedBox(height: 20,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                children: [
                const Expanded(
                    child: TextField(
                    
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        hintText: 'Enter your full name',
                      ),
                    ),
                  ),
                 
                  IconButton(onPressed: (){
                     //Save the user information to the firebase database

                  }, icon:const Icon(Icons.check,color: Colors.white,))
                ],
              ),
            ),
          ],),
      ),
    );
  }
}