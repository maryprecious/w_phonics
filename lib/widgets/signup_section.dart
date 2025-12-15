import 'package:flutter/material.dart';
import 'package:w_phonics/widgets/custom_textfield.dart';
import 'package:w_phonics/widgets/password_textfield.dart';

class SignupSection extends StatelessWidget {
  const SignupSection({
    super.key,
    required this.emailController,
    required this.passwordController,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Welcome to W phonics!",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            spacing: 16,
            children: [
              CustomTextField(label: "Email",
              textColor: Colors.white,
              
               controller: emailController,
               ),
              PassswordTextfield(controller: passwordController),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: AgreementWIdget(),
        ),
      ],
    );
  }
}

class AgreementWIdget extends StatelessWidget {
  const AgreementWIdget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: false,
              onChanged: (value) {},
              side: BorderSide(color: Colors.white),
            ),
            Text("SELECT ALL", style: TextStyle(color: Colors.white)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: false,
                    side: BorderSide(color: Colors.white),
                    onChanged: (value) {},
                  ),
                  Expanded(
                    child: Text(
                      "* I agree to the privacy policy and terms",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                    side: BorderSide(color: Colors.white),
                  ),
                  Expanded(
                    child: Text(
                      "I want to receive email update from Jolly Learning",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
