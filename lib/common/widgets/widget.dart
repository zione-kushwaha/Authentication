import 'dart:io';

import 'package:day2/common/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Widget bottomWidget({required String text, required Function() onPressed}) {
   return Container(
    height: 50,
    width: double.infinity,
    
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.withOpacity(0.5)),
      onPressed: onPressed, child: Text(text,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)));
}

//function to pick image from gallery
Future<File?> pickImageFromGallery( BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showCustomSnackBar( context,  e.toString());
  }
  return image;
}