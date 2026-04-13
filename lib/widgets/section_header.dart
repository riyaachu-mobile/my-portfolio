import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  final String tag;
  final String title;
  final String subtitle;

  const SectionHeader({
    super.key,
    required this.tag,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tag, style: AppTextStyles.monoMedium),
        const SizedBox(height: 12),
        Text(title, style: AppTextStyles.displaySmall),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Text(subtitle, style: AppTextStyles.bodyLarge),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.2, curve: Curves.easeOut);
  }
}
