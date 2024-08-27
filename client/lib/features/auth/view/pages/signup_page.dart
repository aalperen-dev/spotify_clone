import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify/core/theme/app_palette.dart';
import 'package:spotify/core/widgets/app_loader.dart';
import 'package:spotify/features/auth/view/pages/login_page.dart';
import 'package:spotify/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:spotify/features/auth/view/widgets/custom_textformfield.dart';
import 'package:spotify/features/auth/viewmodel/auth_viewmodel.dart';

import '../../../../core/utilities/utilities.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
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
    final isLoading = ref.watch(authViewModelProvider.select(
      (value) => value?.isLoading == true,
    ));
    ref.listen(
      authViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            AppUtilities.showSnackBar(
                context: context, content: 'Account created! Please login.!');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          },
          error: (error, stackTrace) {
            AppUtilities.showSnackBar(
                context: context, content: error.toString());
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
                            if (formKey.currentState!.validate()) {
                              ref
                                  .read(authViewModelProvider.notifier)
                                  .signUpUser(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                            } else {
                              AppUtilities.showSnackBar(
                                context: context,
                                content: 'Missing fields!',
                              );
                            }
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
