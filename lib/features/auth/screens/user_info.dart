import 'dart:io';
import 'package:connectaa/colors.dart';
import 'package:connectaa/common/common_widgets/custom_button.dart';
import 'package:connectaa/common/utiles/utiles.dart';
import 'package:connectaa/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-info';

  const UserInfoScreen({super.key});

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void selectImage() async {
      final selected = await imagePickerFromGallery(context);
      setState(() {
        image = selected;
      });
    }

    void storeUserData() async {
      String name = nameController.text.trim();
      if (name.isNotEmpty) {
        ref
            .read(authControllerProvider)
            .saveUserDataToFirebase(context, name, image);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  selectImage();
                },
                child: Stack(
                  children: [
                    image == null
                        ? const CircleAvatar(
                            backgroundImage: AssetImage("assets/user_icon.png"),
                            backgroundColor: Colors.white,
                            radius: 50,
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(image!),
                            backgroundColor: Colors.white,
                            radius: 50,
                          ),
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 15,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Add Profile Photo",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Enter your name ",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          color: greyColor),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          child: CustomButton(
                              onPressed: storeUserData, text: 'Done'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
