import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo / App Name
         Image.asset(
            'assets/images/WordSpace-Logo.png',
            height: 200,
            width: 200,
            fit: BoxFit.contain,
          ),
              // Subtitle
              const Text(
                'Share your ideas, grow together',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.primaryMedium,
                ),
              ),
              const SizedBox(height: 20),
              // Login Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to Login Page
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Log In'),
              ),
              const SizedBox(height: 16),
              // Create Account Button
              OutlinedButton(
                onPressed: () {
                  // Navigate to Sign Up Page
                  Navigator.pushNamed(context, '/register');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primaryDark,
                  side: const BorderSide(color: AppTheme.primaryDark, width: 2),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Create Account'),
              ),
              const SizedBox(height: 20),
              // Optional: "Or continue with" (you can add social buttons here later)
            ],
          ),
        ),
      ),
    );
  }
}