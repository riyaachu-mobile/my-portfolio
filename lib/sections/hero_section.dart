import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

Future<void> _launchResume() async {
  // Build absolute URL from current page base so url_launcher resolves it correctly on web
  final uri = Uri.base.replace(path: '/resume.pdf', query: '');
  await launchUrl(uri, webOnlyWindowName: '_blank');
}

Future<void> _launchLinkedIn() async {
  final uri = Uri.parse('https://www.linkedin.com/in/riya-achu-thomas');
  await launchUrl(uri, webOnlyWindowName: '_blank');
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: size.height),
      decoration: const BoxDecoration(color: AppColors.background),
      child: Stack(
        children: [
          // Background glow
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accentBlue.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accentPurple.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 80,
              vertical: isMobile ? 100 : 0,
            ),
            child: isMobile ? _MobileHero() : _DesktopHero(),
          ),
        ],
      ),
    );
  }
}

class _DesktopHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Expanded(child: _HeroContent())],
      ),
    );
  }
}

class _MobileHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_HeroContent(), const SizedBox(height: 60)],
    );
  }
}

class _HeroContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Available badge
        _AvailableBadge()
            .animate()
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3, curve: Curves.easeOut),
        const SizedBox(height: 28),

        // Main heading
        Text(
              "Hi, I'm",
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textMuted,
                fontSize: 20,
              ),
            )
            .animate()
            .fadeIn(delay: 100.ms, duration: 600.ms)
            .slideY(begin: 0.3, curve: Curves.easeOut),
        Text('Riya Achu Thomas', style: AppTextStyles.displayLarge)
            .animate()
            .fadeIn(delay: 200.ms, duration: 600.ms)
            .slideY(begin: 0.3, curve: Curves.easeOut),
        ShaderMask(
              shaderCallback:
                  (bounds) => AppColors.accentGradient.createShader(bounds),
              child: Text(
                'Lead Mobile Developer',
                style: AppTextStyles.displayLarge.copyWith(color: Colors.white),
              ),
            )
            .animate()
            .fadeIn(delay: 300.ms, duration: 600.ms)
            .slideY(begin: 0.3, curve: Curves.easeOut),

        const SizedBox(height: 16),

        // Subtitle
        Text(
              '7+ years in Flutter, Android & iOS — healthcare, fintech & government.\nExpert in Clean Architecture, CI/CD, QA automation, and AI integration.',
              style: AppTextStyles.bodyLarge,
            )
            .animate()
            .fadeIn(delay: 400.ms, duration: 600.ms)
            .slideY(begin: 0.3, curve: Curves.easeOut),

        const SizedBox(height: 32),

        // Stats row
        _StatsRow()
            .animate()
            .fadeIn(delay: 500.ms, duration: 600.ms)
            .slideY(begin: 0.3, curve: Curves.easeOut),

        const SizedBox(height: 32),

        // CTA buttons
        Row(
              children: [
                _PrimaryButton(label: 'Resume', onTap: _launchResume),
                const SizedBox(width: 16),
                _OutlineButton(label: 'LinkedIn', onTap: _launchLinkedIn),
              ],
            )
            .animate()
            .fadeIn(delay: 600.ms, duration: 600.ms)
            .slideY(begin: 0.3, curve: Curves.easeOut),
      ],
    );
  }
}

class _AvailableBadge extends StatefulWidget {
  @override
  State<_AvailableBadge> createState() => _AvailableBadgeState();
}

class _AvailableBadgeState extends State<_AvailableBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.accentBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AppColors.accentBlue.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _pulseAnim,
            builder:
                (_, __) => Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF22C55E),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(
                          0xFF22C55E,
                        ).withValues(alpha: _pulseAnim.value),
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
          ),
          const SizedBox(width: 10),
          Text(
            'Available for Opportunities',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.accentBlue,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final List<Map<String, String>> stats = const [
    {'value': '7+', 'label': 'Years Experience'},
    {'value': '10+', 'label': 'Apps Shipped'},
    {'value': '6+', 'label': 'Companies'},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          stats.asMap().entries.map((e) {
            return Row(
              children: [
                if (e.key > 0) ...[
                  Container(
                    height: 40,
                    width: 1,
                    color: AppColors.border,
                    margin: const EdgeInsets.symmetric(horizontal: 28),
                  ),
                ],
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShaderMask(
                      shaderCallback:
                          (b) => AppColors.accentGradient.createShader(b),
                      child: Text(
                        e.value['value']!,
                        style: AppTextStyles.statNumber.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(e.value['label']!, style: AppTextStyles.statLabel),
                  ],
                ),
              ],
            );
          }).toList(),
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.onTap});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform:
              _hovered
                  ? Matrix4.translationValues(0, -2, 0)
                  : Matrix4.identity(),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(10),
            boxShadow:
                _hovered
                    ? [
                      BoxShadow(
                        color: AppColors.accentBlue.withValues(alpha: 0.35),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ]
                    : [],
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.labelLarge.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _OutlineButton({required this.label, required this.onTap});

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform:
              _hovered
                  ? Matrix4.translationValues(0, -2, 0)
                  : Matrix4.identity(),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color:
                _hovered
                    ? AppColors.accentBlue.withValues(alpha: 0.1)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.accentBlue.withValues(alpha: 0.6),
              width: 1.5,
            ),
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.labelLarge.copyWith(
              color: _hovered ? AppColors.accentBlue : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
