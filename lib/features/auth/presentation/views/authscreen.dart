import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movies_app/core/constants.dart';
import 'package:movies_app/core/widgets/apptext_button.dart';
import 'package:movies_app/core/widgets/showtoast.dart';
import 'package:movies_app/features/auth/data/repos/authrepo.dart';
import 'package:movies_app/features/auth/presentation/views_model/auth_cubit/auth_cubit.dart';
import '../../../../../core/widgets/apptext_formfield.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.registration});
  final String registration;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  bool isObscure = true;
  bool isObscureConfirm = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmpassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constbackground,
      body: Center(
        child: BlocProvider(
          create: (context) => AuthCubit(AuthRepository()),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showToast(message: state.errorMessage);
              } else if (state is AuthSuccess) {
                widget.registration == 'login'
                    ? showToast(message: 'Login successfully')
                    : showToast(message: 'SignUp successfully');
                Navigator.pushNamed(context, '/home');
              }
            },
            builder: (context, state) {
              bool isLoading = state is AuthLoading;

              return ModalProgressHUD(
                inAsyncCall: isLoading,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.registration == 'login'
                                    ? 'Welcome Back\n to Moviecoo !'
                                    : 'Create an Account \n and Enjoy Moviecoo',
                                style: const TextStyle(
                                  fontFamily: 'Staatliches',
                                  color: Color(0xffF83758),
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                FontAwesomeIcons.film,
                                color: Color(0xffF83758),
                                size: 36,
                              ),
                            ],
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              AppTextFormField(
                                borderRadius: BorderRadius.circular(0),
                                color: Colors.grey[350],
                                backgroundColor: Colors.white.withOpacity(0.25),
                                hintText: 'Email',
                                controller: emailController,
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains('@')) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 25),
                              AppTextFormField(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isObscure = !isObscure;
                                    });
                                  },
                                  child: isObscure
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
                                isObscureText: isObscure,
                                borderRadius: BorderRadius.circular(0),
                                color: Colors.grey[350],
                                backgroundColor: Colors.white.withOpacity(0.25),
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                                hintText: 'Password',
                                controller: passwordController,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    widget.registration == 'login'
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.center,
                                children: [
                                  widget.registration == 'login'
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/forgetpassword');
                                          },
                                          child: const Text(
                                            'Forget Password?',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                decorationColor: Colors.white,
                                                decorationThickness: 1.5,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                              widget.registration == 'login'
                                  ? const SizedBox()
                                  : const SizedBox(height: 15),
                              widget.registration == 'login'
                                  ? const SizedBox()
                                  : AppTextFormField(
                                      borderRadius: BorderRadius.circular(0),
                                      color: Colors.grey[350],
                                      backgroundColor:
                                          Colors.white.withOpacity(0.25),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 6) {
                                          return 'Password must be at least 6 characters';
                                        }
                                        if (value != passwordController.text) {
                                          return 'Passwords do not match';
                                        }
                                        return null;
                                      },
                                      isObscureText: isObscureConfirm,
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isObscureConfirm =
                                                !isObscureConfirm;
                                          });
                                        },
                                        child: isObscureConfirm
                                            ? const Icon(
                                                Icons.visibility_sharp,
                                                size: 24,
                                                color: Colors.white70,
                                              )
                                            : const Icon(
                                                Icons.visibility_off_sharp,
                                                size: 24,
                                                color: Colors.white70),
                                      ),
                                      hintText: 'Confirm Password',
                                      controller: confirmpassController,
                                    ),
                              const SizedBox(height: 25),
                              AppTextButton(
                                buttonText: widget.registration == 'login'
                                    ? 'Login'
                                    : 'Sign Up',
                                backgroundColor: constbackground,
                                buttonHeight: 50,
                                buttonWidth:
                                    MediaQuery.of(context).size.width * .75,
                                textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (widget.registration == 'login') {
                                      BlocProvider.of<AuthCubit>(context).login(
                                          emailController.text,
                                          passwordController.text);
                                    } else {
                                      if (passwordController.text !=
                                          confirmpassController.text) {
                                        showToast(
                                            message: 'Passwords do not match');
                                      } else {
                                        BlocProvider.of<AuthCubit>(context)
                                            .signUp(
                                          emailController.text,
                                          passwordController.text,
                                        );
                                      }
                                    }
                                  }
                                },
                              ),
                              const SizedBox(height: 25),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      widget.registration == 'login'
                                          ? 'Create An Account ? '
                                          : 'Already Have an Account ? ',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                  GestureDetector(
                                    onTap: () {
                                      widget.registration == 'login'
                                          ? Navigator.pushNamed(
                                              context, '/signup')
                                          : Navigator.pushNamed(
                                              context, '/login');
                                    },
                                    child: Text(
                                        widget.registration == 'login'
                                            ? 'Sign Up'
                                            : 'Login',
                                        style: const TextStyle(
                                            decorationThickness: 1.5,
                                            decorationColor: Color(0xffF83758),
                                            decoration:
                                                TextDecoration.underline,
                                            color: Color(0xffF83758),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
