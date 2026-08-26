import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class TrackOrderScreen extends StatelessWidget {
  final String orderId;
  final String estimatedDelivery;

  const TrackOrderScreen({
    super.key,
    this.orderId = 'YD-892740',
    this.estimatedDelivery = 'Tomorrow • By 6:00 PM',
  });

  void _onBack(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(initialTab: 1),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => _onBack(context),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Icon(
                Icons.chevron_left_rounded,
                color: AppColors.textPrimary,
                size: 26,
              ),
            ),
          ),
        ),
        title: Text(
          'Track Order',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Estimated Delivery Blue Header Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFF2E4CEE),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ESTIMATED DELIVERY',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFE2C07D),
                              letterSpacing: 0.6,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            estimatedDelivery,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Vertical Order Progress Stepper
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      _buildStep(
                        title: 'Order Placed',
                        subtitle: "We've received your request",
                        status: _StepStatus.completed,
                        isFirst: true,
                      ),
                      _buildStep(
                        title: 'Pickup Scheduled',
                        subtitle: 'Today, 10:00 AM - 12:00 PM',
                        status: _StepStatus.completed,
                      ),
                      _buildStep(
                        title: 'Rider On Way',
                        subtitle: 'Rider Rahul is coming to pick up',
                        status: _StepStatus.inProgress,
                      ),
                      _buildStep(
                        title: 'Clothes Picked Up',
                        subtitle: 'Pending pickup verification',
                        status: _StepStatus.pending,
                      ),
                      _buildStep(
                        title: 'Washing In Progress',
                        subtitle: 'Processing at premium facility',
                        status: _StepStatus.pending,
                      ),
                      _buildStep(
                        title: 'Quality Check',
                        subtitle: 'Inspecting fabric & ironing standard',
                        status: _StepStatus.pending,
                      ),
                      _buildStep(
                        title: 'Out For Delivery',
                        subtitle: 'Fresh clothes on their way back',
                        status: _StepStatus.pending,
                      ),
                      _buildStep(
                        title: 'Delivered',
                        subtitle: 'Doorstep delivery completed',
                        status: _StepStatus.pending,
                        isLast: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Floating Rider Contact Card
          Positioned(
            bottom: 24,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5FD),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      color: AppColors.primary,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rahul Sharma',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Assigned Pickup Rider',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Call Action
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Calling Rider Rahul (+91 98765 43210)...'),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                    },
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEEF2FF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.call_rounded,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Chat Action
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Opening chat with Rider Rahul...'),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                    },
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEEF2FF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.chat_bubble_outline_rounded,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep({
    required String title,
    required String subtitle,
    required _StepStatus status,
    bool isFirst = false,
    bool isLast = false,
  }) {
    Color nodeColor;
    Color lineColor;
    Widget nodeChild;
    Color titleColor = AppColors.textPrimary;

    switch (status) {
      case _StepStatus.completed:
        nodeColor = const Color(0xFF10B981);
        lineColor = const Color(0xFF10B981);
        nodeChild = const Icon(Icons.check, color: Colors.white, size: 14);
        break;
      case _StepStatus.inProgress:
        nodeColor = const Color(0xFF2E4CEE);
        lineColor = const Color(0xFFE2E8F0);
        nodeChild = const SizedBox();
        titleColor = const Color(0xFF2E4CEE);
        break;
      case _StepStatus.pending:
        nodeColor = const Color(0xFFE2E8F0);
        lineColor = const Color(0xFFE2E8F0);
        nodeChild = const SizedBox();
        titleColor = const Color(0xFF475569);
        break;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stepper Node and Connecting Line
        Column(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: status == _StepStatus.pending ? Colors.white : nodeColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: nodeColor,
                  width: status == _StepStatus.pending ? 2 : 0,
                ),
              ),
              child: Center(child: nodeChild),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: lineColor,
              ),
          ],
        ),
        const SizedBox(width: 14),

        // Text Info
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

enum _StepStatus { completed, inProgress, pending }
