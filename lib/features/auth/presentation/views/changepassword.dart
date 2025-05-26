import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants.dart';
import 'package:movies_app/core/widgets/apptext_button.dart';
import 'package:movies_app/core/widgets/apptext_formfield.dart';
import 'package:movies_app/core/widgets/showtoast.dart';
import 'package:movies_app/features/auth/data/repos/authrepo.dart';
import 'package:movies_app/features/auth/presentation/views_model/auth_cubit/auth_cubit.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController oldpasscontroller = TextEditingController();
  final TextEditingController newpasscontroller = TextEditingController();

  bool isoldobscure = true;
  bool isnewobscure = true;
  final GlobalKey<FormState> _formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final authrepository = AuthRepository(firebaseAuth: FirebaseAuth.instance);
    return BlocProvider(
      create: (context) => AuthCubit(authrepository),
      child: Scaffold(
          backgroundColor: constbackground,
          appBar: AppBar(
            centerTitle: true,
            foregroundColor: Colors.white,
            backgroundColor: constbackground,
            title: const Text(
              'Change Password',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthPasswordChangeSuccess) {
                showToast(
                    message:
                        'Your password has been successfully changed. You can now use your new password to log in.');
                Navigator.pushNamed(context, '/login');
              } else if (state is AuthFailure) {
                showToast(message: state.errorMessage);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTextFormField(
                          backgroundColor: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.grey[350],
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            if (value != oldpasscontroller.text) {
                              return 'Password doesn\'t match';
                            }
                            return null;
                          },
                          isObscureText: isoldobscure,
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isoldobscure = !isoldobscure;
                              });
                            },
                            child: isoldobscure
                                ? const Icon(
                                    Icons.visibility_sharp,
                                    size: 24,
                                    color: Colors.white70,
                                  )
                                : const Icon(
                                    Icons.visibility_off_sharp,
                                    size: 24,
                                    color: Colors.white70,
                                  ),
                          ),
                          hintText: 'Old Password',
                          controller: oldpasscontroller),
                      const SizedBox(
                        height: 25,
                      ),
                      AppTextFormField(
                          backgroundColor: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.grey[350],
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            if (value != newpasscontroller.text) {
                              return 'Password doesn\'t match';
                            }
                            return null;
                          },
                          isObscureText: isnewobscure,
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isnewobscure = !isnewobscure;
                              });
                            },
                            child: isnewobscure
                                ? const Icon(
                                    Icons.visibility_sharp,
                                    size: 24,
                                    color: Colors.white70,
                                  )
                                : const Icon(
                                    Icons.visibility_off_sharp,
                                    size: 24,
                                    color: Colors.white70,
                                  ),
                          ),
                          hintText: 'New Password',
                          controller: newpasscontroller),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          state is AuthLoading
                              ? const Center(child: CircularProgressIndicator())
                              : AppTextButton(
                                  backgroundColor: constbackground,
                                  buttonHeight: 50,
                                  buttonWidth: double.infinity,
                                  buttonText: 'Change Password',
                                  textStyle:
                                      const TextStyle(color: Colors.white),
                                  onPressed: () {
                                    if (_formkey.currentState!.validate()) {
                                      BlocProvider.of<AuthCubit>(context)
                                          .changePassword(
                                              oldpasscontroller.text,
                                              newpasscontroller.text);
                                    }
                                  }),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
