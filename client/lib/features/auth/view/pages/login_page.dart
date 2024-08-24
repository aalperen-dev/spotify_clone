import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:spotify/core/theme/app_palette.dart';
import 'package:spotify/features/auth/repositories/auth_remote_repository.dart';
import 'package:spotify/features/auth/view/pages/signup_page.dart';
import 'package:spotify/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:spotify/features/auth/view/widgets/custom_textformfield.dart';

import '../../../../core/widgets/app_loader.dart';
import '../../viewmodel/auth_viewmodel.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
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
    final isLoading = ref.watch(authViewModelProvider)?.isLoading == true;

    ref.listen(
      authViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            // TODO: navigate to home page
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => const LoginPage(),
            //   ),
            // );
          },
          error: (error, stackTrace) {
            ScaffoldMessenger.of(context)
              ..hideCurrentMaterialBanner()
              ..showSnackBar(
                SnackBar(
                  content: Text(error.toString()),
                ),
              );
          },
          loading: () {},
        );
      },
    );

    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const AppLoader()
          : Padding(
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
                          onPressed: () async {
                            final res = await AuthRemoteRepository().login(
                              email: emailController.text,
                              password: passwordController.text,
                            );

                            final val = switch (res) {
                              Left(value: final l) => l,
                              Right(value: final r) => r,
                            };
                          },
                        ),
                      ),
                      //
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignupPage(),
                            ),
                          );
                        },
                        child: RichText(
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
