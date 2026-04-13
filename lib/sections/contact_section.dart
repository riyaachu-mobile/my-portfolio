import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  static final List<_ContactLink> _links = [];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      color: AppColors.surfaceLight,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 100,
      ),
      child: Column(
        children: [
          // Header
          Column(
                children: [
                  Text('05. CONTACT', style: AppTextStyles.monoMedium),
                  const SizedBox(height: 12),
                  Text(
                    "Let's Work Together",
                    style: AppTextStyles.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Text(
                      "Open to Lead / Senior Mobile Developer roles in Flutter, Android & iOS. Based in Missouri City, TX — happy to discuss remote, hybrid, or on-site opportunities.",
                      style: AppTextStyles.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
              .animate()
              .fadeIn(duration: 600.ms)
              .slideY(begin: 0.2, curve: Curves.easeOut),

          const SizedBox(height: 64),

          // Contact cards
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children:
                _links.asMap().entries.map((e) {
                  return _ContactCard(data: e.value, index: e.key);
                }).toList(),
          ),

          const SizedBox(height: 80),

          // Footer
          Column(
            children: [
              Container(
                height: 1,
                color: AppColors.border,
                margin: const EdgeInsets.only(bottom: 28),
              ),
              Text(
                'Designed & Built with Flutter',
                style: AppTextStyles.bodySmall.copyWith(fontSize: 13),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('© 2025 ', style: AppTextStyles.bodySmall),
                  ShaderMask(
                    shaderCallback:
                        (b) => AppColors.accentGradient.createShader(b),
                    child: Text(
                      'Riya Achu Thomas',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '. All rights reserved.',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Location — no icon
              Text(
                'Missouri City, TX 77459',
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12,
                  color: AppColors.textMuted,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
        ],
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  final _ContactLink data;
  final int index;
  const _ContactCard({required this.data, required this.index});

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hovered = false;

  Future<void> _handleTap() async {
    final url = widget.data.url;
    if (url == null) return;
    await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
  }

  @override
  Widget build(BuildContext context) {
    final hasUrl = widget.data.url != null;

    return GestureDetector(
          onTap: hasUrl ? _handleTap : null,
          child: MouseRegion(
            cursor: hasUrl ? SystemMouseCursors.click : MouseCursor.defer,
            onEnter: (_) => setState(() => _hovered = true),
            onExit: (_) => setState(() => _hovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform:
                  _hovered && hasUrl
                      ? Matrix4.translationValues(0, -4, 0)
                      : Matrix4.identity(),
              width: 220,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color:
                    _hovered && hasUrl
                        ? widget.data.color.withValues(alpha: 0.08)
                        : AppColors.cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color:
                      _hovered && hasUrl
                          ? widget.data.color.withValues(alpha: 0.4)
                          : AppColors.border,
                  width: 1,
                ),
                boxShadow:
                    _hovered && hasUrl
                        ? [
                          BoxShadow(
                            color: widget.data.color.withValues(alpha: 0.12),
                            blurRadius: 20,
                            offset: const Offset(0, 6),
                          ),
                        ]
                        : [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: widget.data.color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          widget.data.icon,
                          color: widget.data.color,
                          size: 20,
                        ),
                      ),
                      if (hasUrl) ...[
                        const Spacer(),
                        Icon(
                          Icons.open_in_new_rounded,
                          size: 14,
                          color:
                              _hovered
                                  ? widget.data.color
                                  : AppColors.textMuted,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.data.label,
                    style: AppTextStyles.labelLarge.copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.data.value,
                    style: AppTextStyles.bodySmall.copyWith(
                      color:
                          _hovered && hasUrl
                              ? widget.data.color
                              : AppColors.textMuted,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 100 * widget.index),
          duration: 600.ms,
        )
        .slideY(begin: 0.2, curve: Curves.easeOut);
  }
}

class _ContactLink {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final String? url;

  const _ContactLink({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.url,
  });
}
