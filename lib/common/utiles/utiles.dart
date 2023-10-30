import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}



Future<File?> imagePickerFromGallery(BuildContext context) async {
 File? image;
 try{
   final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
   if(pickedImage != null){
    image = File(image!.path);
   }
   
 } catch (e){
   throw (context: context, message: e.toString());
 }
 print(image);

 return image;
 

}
