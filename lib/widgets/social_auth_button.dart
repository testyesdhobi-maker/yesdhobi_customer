import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class SocialAuthButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onPressed;
  final bool fullWidth;

  const SocialAuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonContent = OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.border, width: 1.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );

    if (fullWidth) {
      return SizedBox(
        width: double.infinity,
        height: 52,
        child: buttonContent,
      );
    }

    return Expanded(
      child: SizedBox(
        height: 52,
        child: buttonContent,
      ),
    );
  }
}

/// Custom Google Icon matching the screenshot outline badge style
class SocialGoogleIcon extends StatelessWidget {
  final double size;
  const SocialGoogleIcon({super.key, this.size = 18.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.textPrimary, width: 1.6),
      ),
      child: Center(
        child: Icon(
          Icons.close_rounded,
          size: size * 0.75,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

/// Custom Apple Icon matching the screenshot outline badge style
class SocialAppleIcon extends StatelessWidget {
  final double size;
  const SocialAppleIcon({super.key, this.size = 18.0});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.devices_other_rounded,
      size: size,
      color: AppColors.textPrimary,
    );
  }
}

/// Video/Play / Google continuation icon in Welcome Back screen
class SocialPlayGoogleIcon extends StatelessWidget {
  final double size;
  const SocialPlayGoogleIcon({super.key, this.size = 20.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size * 0.75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.textPrimary, width: 1.6),
      ),
      child: Center(
        child: Icon(
          Icons.play_arrow_rounded,
          size: size * 0.6,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
