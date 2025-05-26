import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants.dart';
import 'package:movies_app/core/widgets/apptext_button.dart';
import 'package:movies_app/core/widgets/apptext_formfield.dart';
import 'package:movies_app/core/widgets/showtoast.dart';
import 'package:movies_app/features/auth/data/repos/authrepo.dart';
import 'package:movies_app/features/auth/presentation/views_model/auth_cubit/auth_cubit.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({
    super.key,
  });

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _emailController = TextEditingController();
  void _showDialog(BuildContext context, String title, String message,
      Function() onPressed) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: onPressed,
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: constbackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 62),
        child: BlocProvider(
          create: (context) => AuthCubit(AuthRepository()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Forget',
                style: TextStyle(
                    fontSize: 43,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Text('Password?',
                  style: TextStyle(
                      fontSize: 43,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(
                height: 32,
              ),
              Form(
                key: _formKey,
                child: AppTextFormField(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.grey[350],
                  backgroundColor: Colors.white.withOpacity(0.25),
                  hintText: 'Enter Your Email',
                  controller: _emailController,
                  prefixIcon: const Icon(
                    Icons.email,
                    size: 24,
                    color: Colors.white70,
                  ),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              const Text.rich(TextSpan(
                  text: '*',
                  style: TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                        text:
                            ' We will send you a message to set or reset your new password',
                        style: TextStyle(color: Color(0xff676767)))
                  ])),
              const SizedBox(
                height: 30,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthPasswordResetSuccess) {
                    showToast(message: 'Password reset email sent.');
                    Navigator.pushNamed(context, '/login');
                  } else if (state is AuthFailure) {
                    showToast(message: state.errorMessage);
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return AppTextButton(
                      buttonText: 'Submit',
                      backgroundColor: constbackground,
                      buttonHeight: 50,
                      buttonWidth: MediaQuery.of(context).size.width * 1,
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context)
                              .forgotPassword(_emailController.text);
                        }
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
