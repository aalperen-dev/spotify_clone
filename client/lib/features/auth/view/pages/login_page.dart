import 'package:flutter/material.dart';
import 'package:spotify/core/theme/app_palette.dart';
import 'package:spotify/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:spotify/features/auth/view/widgets/custom_textformfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
    formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign In.',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //
                const SizedBox(height: 30),
                //
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: CustomTextFormField(
                    hintText: 'E - mail',
                    controller: emailController,
                  ),
                ),
                CustomTextFormField(
                  hintText: 'Password',
                  controller: passwordController,
                  isObscureText: true,
                ),
                //
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: AuthGradientButton(
                    buttonText: 'Sign in!',
                    onPressed: () {},
                  ),
                ),
                //
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.titleMedium,
                    text: 'Don\'t have an account? ',
                    children: const [
                      TextSpan(
                        text: 'Sign up!',
                        style: TextStyle(
                          color: Pallete.gradient2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
