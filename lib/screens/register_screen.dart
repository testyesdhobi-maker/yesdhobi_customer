import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_auth_button.dart';
import 'login_screen.dart';
import 'otp_verification_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    String phone = _mobileController.text.trim();
    if (phone.isEmpty) {
      phone = '+91 98765 43210';
    }

    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OtpVerificationScreen(phoneNumber: phone),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),

                // Title
                Text(
                  'Create Account',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),

                // Subtitle
                Text(
                  'Join Yes Dhobi to experience hassle-free laundry',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 32),

                // Form Fields
                CustomTextField(
                  label: 'Full Name',
                  isRequired: true,
                  hintText: 'Rahul Sharma',
                  prefixIcon: Icons.person_outline_rounded,
                  controller: _nameController,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  label: 'Mobile Number',
                  isRequired: true,
                  hintText: '+91 98765 4321',
                  prefixIcon: Icons.call_outlined,
                  keyboardType: TextInputType.phone,
                  controller: _mobileController,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  label: 'Email',
                  isRequired: true,
                  hintText: 'rahul@gmail.com',
                  prefixIcon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  label: 'Delivery Address & Pincode',
                  isRequired: true,
                  hintText: 'Flat 402, Green Glen Layout, 560103',
                  prefixIcon: Icons.location_on_outlined,
                  controller: _addressController,
                ),

                const SizedBox(height: 28),

                // Sign Up Button
                CustomButton(
                  text: 'Sign Up',
                  isLoading: _isLoading,
                  onPressed: _handleSignUp,
                ),

                const SizedBox(height: 24),

                // Already have an account? Login
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // OR SIGN IN WITH Divider
                Row(
                  children: [
                    const Expanded(
                      child: Divider(color: AppColors.border, thickness: 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OR SIGN IN WITH',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMuted,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(color: AppColors.border, thickness: 1),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Social Buttons Row
                Row(
                  children: [
                    SocialAuthButton(
                      text: 'Google',
                      icon: const SocialGoogleIcon(size: 18),
                      onPressed: _handleSignUp,
                    ),
                    const SizedBox(width: 14),
                    SocialAuthButton(
                      text: 'Apple',
                      icon: const SocialAppleIcon(size: 18),
                      onPressed: _handleSignUp,
                    ),
                  ],
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
