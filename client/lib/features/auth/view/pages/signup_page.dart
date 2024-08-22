import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:spotify/core/theme/app_palette.dart';
import 'package:spotify/features/auth/repositories/auth_remote_repository.dart';
import 'package:spotify/features/auth/view/pages/login_page.dart';
import 'package:spotify/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:spotify/features/auth/view/widgets/custom_textformfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    nameController.dispose();
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
                  'Sign Up.',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //
                const SizedBox(height: 30),
                //
                CustomTextFormField(
                  hintText: 'Name',
                  controller: nameController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: CustomTextFormField(
                    hintText: 'E-mail',
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
                    buttonText: 'Sign Up!',
                    onPressed: () async {
                      final res = await AuthRemoteRepository().signup(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      print(res);

                      final val = switch (res) {
                        Left(value: final l) => l,
                        Right(value: final r) => r.name,
                      };
                      print(val);
                    },
                  ),
                ),
                //
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.titleMedium,
                      text: 'Already have an account? ',
                      children: const [
                        TextSpan(
                          text: 'Sign in!',
                          style: TextStyle(
                            color: Pallete.gradient2,
                          ),
                        ),
                      ],
                    ),
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
