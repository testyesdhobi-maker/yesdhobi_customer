import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Custom Vector Washing Machine Icon matching the Yes Dhobi Brand Logo
class WashingMachineIcon extends StatelessWidget {
  final double size;
  final Color color;
  final double strokeWidth;

  const WashingMachineIcon({
    super.key,
    this.size = 38.0,
    this.color = AppColors.primary,
    this.strokeWidth = 2.4,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _WashingMachinePainter(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class _WashingMachinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _WashingMachinePainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // Outer Machine Body Rounded Rectangle
    final outerRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.1, h * 0.05, w * 0.8, h * 0.9),
      Radius.circular(w * 0.18),
    );
    canvas.drawRRect(outerRect, paint);

    // Top control line / bar separator
    canvas.drawLine(
      Offset(w * 0.14, h * 0.28),
      Offset(w * 0.86, h * 0.28),
      paint..strokeWidth = strokeWidth * 0.8,
    );

    // Top left knob / indicator dot
    canvas.drawCircle(
      Offset(w * 0.28, h * 0.17),
      w * 0.04,
      fillPaint,
    );

    // Top right small dot/button
    canvas.drawCircle(
      Offset(w * 0.72, h * 0.17),
      w * 0.035,
      fillPaint,
    );

    // Drum Outer Circle
    final center = Offset(w * 0.5, h * 0.62);
    final drumRadius = w * 0.23;
    canvas.drawCircle(center, drumRadius, paint..strokeWidth = strokeWidth);

    // Gentle S-curve or water wave inside drum
    final wavePath = Path();
    wavePath.moveTo(center.dx - drumRadius * 0.65, center.dy + drumRadius * 0.2);
    wavePath.cubicTo(
      center.dx - drumRadius * 0.3,
      center.dy + drumRadius * 0.7,
      center.dx + drumRadius * 0.2,
      center.dy - drumRadius * 0.6,
      center.dx + drumRadius * 0.65,
      center.dy - drumRadius * 0.1,
    );
    canvas.drawPath(wavePath, paint..strokeWidth = strokeWidth * 0.85);
  }

  @override
  bool shouldRepaint(covariant _WashingMachinePainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}

/// Large Splash Screen Logo Emblem
class YesDhobiSplashLogo extends StatelessWidget {
  final double size;

  const YesDhobiSplashLogo({super.key, this.size = 110.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size * 0.32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: size * 0.78,
          height: size * 0.78,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5FD),
            borderRadius: BorderRadius.circular(size * 0.24),
          ),
          child: Center(
            child: WashingMachineIcon(
              size: size * 0.44,
              color: const Color(0xFF1E3A8A),
              strokeWidth: 2.6,
            ),
          ),
        ),
      ),
    );
  }
}

/// Mini App Header Badge with Washing Machine Icon
class YesDhobiAppBadge extends StatelessWidget {
  final double size;

  const YesDhobiAppBadge({super.key, this.size = 28.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(size * 0.28),
      ),
      child: Center(
        child: WashingMachineIcon(
          size: size * 0.58,
          color: Colors.white,
          strokeWidth: 1.8,
        ),
      ),
    );
  }
}
