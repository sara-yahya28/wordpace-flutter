import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordspace/core/di/injection.dart';
import 'package:wordspace/features/user/presentation/cubit/user_cubit.dart';
import 'package:wordspace/features/user/presentation/cubit/user_state.dart';
import 'package:wordspace/features/user/presentation/widgets/auth_footer.dart';
import 'package:wordspace/features/user/presentation/widgets/auth_header.dart';
import 'package:wordspace/features/user/presentation/widgets/custom_button.dart';
import 'package:wordspace/features/user/presentation/widgets/custom_text_field.dart';

import '../widgets/social_login_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final confirmPassword = _confirmPasswordController.text.trim();

      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      context.read<UserCubit>().register(
            name,
            email,
            password,
            confirmPassword,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UserCubit>(),
      child: Scaffold(
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserLoaded) {
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
              child: Center( 
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,  
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Header (Logo + Title + Subtitle)
                        const AuthHeader(
                          title: 'Create Your Account',
                          subtitle: 'Join our community and start sharing your ideas',
                          showLogo: true,
                        ),
                        const SizedBox(height: 24),

                        // Full Name Field
                        CustomTextField(
                          hint: 'Full Name',
                          icon: Icons.person_outlined,
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            if (value.length < 3) {
                              return 'Name must be at least 3 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),

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
                        const SizedBox(height: 12),

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
                            if (!RegExp(r'[A-Z]').hasMatch(value)) {
                              return 'Must contain at least one uppercase letter (A-Z)';
                            }
                            if (!RegExp(r'[0-9]').hasMatch(value)) {
                              return 'Must contain at least one number (0-9)';
                            }
                            if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                              return 'Must contain at least one special character (!@#\$%...)';
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

                        // Confirm Password Field
                        CustomTextField(
                          hint: 'Confirm Password',
                          icon: Icons.lock_outline,
                          obscureText: !_isConfirmPasswordVisible,
                          controller: _confirmPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible;
                              });
                            },
                            icon: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Register Button
                        CustomButton(
                          text: 'Get Started',
                          onPressed: () => _register(context),
                          isLoading: isLoading,
                        ),
                        const SizedBox(height: 12),

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
                        const SizedBox(height: 12),

                        // Social Buttons
                        const SocialLoginButtons(),
                        const SizedBox(height: 16),

                        // Footer (Already have an account? Log In)
                        AuthFooter(
                          text: "Already have an account?",
                          actionText: 'Log In',
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}