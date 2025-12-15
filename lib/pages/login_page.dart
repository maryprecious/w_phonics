import 'package:flutter/material.dart';
import 'package:w_phonics/pages/home_page.dart';
import 'package:w_phonics/repository/auth_repository.dart';
import 'package:w_phonics/widgets/password_textfield.dart';
import 'package:w_phonics/widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24),
            child: Column(
              spacing: 10.0,
              children: [
                Image.asset(
                  "assets/images/mouse_nobg.png",
                  width: 250,
                  height: 250,
                ),
                Text(
                  "Welcome back! Let's return to your phonics learning journey",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomTextField(label: "email",
                textColor: Colors.white,
                 controller: emailController),

                PassswordTextfield(controller: passwordController),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),

                CustomButton(
                  onPressed: () {
                    _loginUser();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loginUser() async {
    try {
      await AuthRepository().signIn(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed});
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width * 0.7),
          ),
          onPressed: onPressed,

          child: Text("Sign In"),
        ),
      ),
    );
  }
}
