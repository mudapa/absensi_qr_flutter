import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth/auth_cubit.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // text editing controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Wrong Message Error Pop Up
  void showErrorMessage(String message) {
    // Change Message Text
    if (message ==
        '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
      message = 'Oops, akun tidak ada!';
    } else if (message ==
        '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
      message = 'Oops, password kamu salah periksa lagi ya!';
    } else if (message ==
        '[firebase_auth/unknown] Given String is empty or null') {
      message = 'Email & Password tidak boleh kosong!';
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              message,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: const EdgeInsets.only(
          top: 32,
          bottom: 32,
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/logo.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 16),
            Text(
              'ABSENSI QR',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }

    Widget inputSection() {
      Widget email() {
        return CustomTextFormField(
          hintText: 'Email',
          controller: _emailController,
        );
      }

      Widget password() {
        return CustomTextFormField(
          hintText: 'Password',
          controller: _passwordController,
          obscureText: true,
        );
      }

      Widget submitButton() {
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              if (state.user.role == 2) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/siswa', (route) => false);
              } else if (state.user.role == 1) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Berhasil masuk!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pushNamedAndRemoveUntil(
                    context, '/main', (route) => false);
              }
            } else if (state is AuthFailed) {
              showErrorMessage(state.error);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return CustomButton(
              title: 'Masuk',
              onPressed: () {
                if (_emailController.text.isEmpty ||
                    _passwordController.text.isEmpty) {
                  showErrorMessage(
                      '[firebase_auth/unknown] Given String is empty or null');
                } else {
                  context.read<AuthCubit>().signIn(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                }
              },
            );
          },
        );
      }

      return Column(
        children: [
          email(),
          password(),
          const SizedBox(height: 64),
          submitButton(),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                title(),
                inputSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
