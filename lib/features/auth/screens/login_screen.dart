import 'package:connectaa/colors.dart';
import 'package:connectaa/common/common_widgets/custom_button.dart';
import 'package:connectaa/features/auth/controller/auth_controller.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login_screen';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneNoController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    super.dispose();
    phoneNoController.dispose();
  }

  void countryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country countryChoose) {
        setState(() {
          country = countryChoose;
        });
      },
    );
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneNoController.text.trim();

    if (country != null && phoneNumber.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .signInWithPhone(context, "+${country!.phoneCode}$phoneNumber");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          "Enter your Phone Number ",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text("Connectaa needs to verify your phone number."),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: countryPicker,
                  child: const Text("Pick Your country")),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  if (country != null) Text("+${country!.phoneCode}"),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: size.width * 0.70,
                    child: TextField(
                      controller: phoneNoController,
                      keyboardType: TextInputType.phone,
                      decoration:
                          const InputDecoration(hintText: "Phone number"),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.4,
              ),
              SizedBox(
                  width: 150,
                  child: CustomButton(onPressed: sendPhoneNumber, text: "Next"))
            ],
          ),
        ),
      ),
    );
  }
}
