import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/features/likes/presentation/cubit/like_cubit.dart';
import 'package:wordspace/features/user/presentation/cubit/user_cubit.dart';
import 'package:wordspace/features/user/presentation/cubit/user_state.dart';
import 'package:wordspace/features/user/presentation/widgets/auth_footer.dart';
import 'package:wordspace/features/user/presentation/widgets/auth_header.dart';
import 'package:wordspace/features/user/presentation/widgets/custom_button.dart';
import 'package:wordspace/features/user/presentation/widgets/custom_text_field.dart';

import '../widgets/social_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final savedEmail = context
          .read<UserCubit>()
          .cacheHelper
          .getDataString(key: 'remembered_email');
      if (savedEmail != null && savedEmail.isNotEmpty && mounted) {
        setState(() {
          _emailController.text = savedEmail;
          _rememberMe = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      if (_rememberMe) {
        context.read<UserCubit>().cacheHelper.saveData(
              key: 'remembered_email',
              value: email,
            );
      } else {
        context.read<UserCubit>().cacheHelper.removeData(
              key: 'remembered_email',
            );
      }

      context.read<UserCubit>().login(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserLoaded) {
            context.read<LikeCubit>().getFavoritePosts();
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is UserLoading;
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Form(
                key: _formKey,
                // ⚠️ لا نستخدم autovalidateMode هنا — كل حقل يتحكم بنفسه
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    const AuthHeader(
                      title: 'Welcome Back',
                      subtitle: 'Login to your account to continue',
                      showLogo: true,
                    ),
                    const SizedBox(height: 40),

                    // Email Field
                    CustomTextField(
                      hint: 'Email address',
                      icon: Icons.email_outlined,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Password Field
                    CustomTextField(
                      hint: 'Password',
                      icon: Icons.lock_outlined,
                      obscureText: !_isPasswordVisible,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Remember Me & Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                              activeColor: Theme.of(context).primaryColor,
                            ),
                            const Text('Remember me'),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Forgot password feature coming soon'),
                              ),
                            );
                          },
                          child: const Text('Forgot Password?'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    isLoading
                        ? const CircularProgressIndicator(color: Colors.grey)
                        : CustomButton(
                            text: 'Log In',
                            onPressed: () {
                              _login(context);
                            },
                          ),
                    const SizedBox(height: 16),

                    // Or continue with
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('Or continue with'),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Social Buttons
                    const SocialLoginButtons(),
                    const SizedBox(height: 32),

                    // Footer
                    AuthFooter(
                      text: "Don't have an account?",
                      actionText: 'Sign Up',
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}