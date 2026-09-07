import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          icon: 'assets/icons/google-logo.png',
          onPressed: () {
            // TODO: Google login
          },
        ),
        const SizedBox(width: 16),
        _buildSocialButton(
          icon: 'assets/icons/facebook-logo.png',
          onPressed: () {
            // TODO: Facebook login
          },
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(icon, fit: BoxFit.contain),
        ),
      ),
    );
  }
}