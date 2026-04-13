import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class TopInfoBar extends StatelessWidget {
  static const double height = 38.0;

  const TopInfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 640;

    return Container(
      height: height,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surfaceLight,
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _InfoChip(
            icon: Icons.email_outlined,
            text: 'achuriya2@gmail.com',
          ),
          _divider(),
          _InfoChip(
            icon: Icons.phone_outlined,
            text: '+1 (346) 535-2654',
          ),
          if (!isMobile) ...[
            _divider(),
            _InfoChip(
              icon: Icons.location_on_outlined,
              text: 'Missouri City, TX 77459',
            ),
          ],
        ],
      ),
    );
  }

  Widget _divider() => Container(
        width: 1,
        height: 16,
        color: AppColors.border,
        margin: const EdgeInsets.symmetric(horizontal: 20),
      );
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: AppColors.textMuted),
        const SizedBox(width: 6),
        Text(
          text,
          style: AppTextStyles.monoSmall.copyWith(
            color: AppColors.textMuted,
            fontSize: 11,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
