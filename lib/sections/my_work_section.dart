import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/section_header.dart';

class MyWorkSection extends StatelessWidget {
  const MyWorkSection({super.key});

  static final List<_WorkData> _apps = [
    _WorkData(
      title: 'MyVCA',
      description:
          'Veterinary care app with real-time video calling, chat system with video/image/PDF attachments, and Helpshift SDK support.',
      appStoreUrl: 'https://apps.apple.com/us/app/myvca/id1172429469',
      tags: ['Flutter', 'Clean Arch', 'Twilio', 'Helpshift', 'Video Chat'],
      accentColor: AppColors.accentBlue,
      icon: Icons.pets_rounded,
      imagePaths: [
        'assets/images/myvca_app_1.jpg',
        'assets/images/myvca_app_2.jpg',
      ],
    ),
    _WorkData(
      title: 'LifeMD',
      description:
          'Telehealth platform for virtual medical consultations. Features secure video appointments, prescription management, and HIPAA compliance.',
      appStoreUrl:
          'https://apps.apple.com/us/app/lifemd-telehealth/id1584079757',
      tags: ['Flutter', 'Telehealth', 'HIPAA', 'Video Calls', 'Healthcare'],
      accentColor: AppColors.accentPurple,
      icon: Icons.local_hospital_rounded,
      imagePaths: [
        'assets/images/lifemd_app_1.jpg',
        'assets/images/lifemd_app_2.jpg',
        'assets/images/lifemd_app_3.jpg',
        'assets/images/lifemd_app_4.jpg',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            tag: '03. MY WORK',
            title: 'Featured Apps',
            subtitle:
                'Production mobile applications available on the App Store.',
          ),
          const SizedBox(height: 64),
          isMobile ? _MobileGrid(apps: _apps) : _DesktopGrid(apps: _apps),
        ],
      ),
    );
  }
}

class _DesktopGrid extends StatelessWidget {
  final List<_WorkData> apps;
  const _DesktopGrid({required this.apps});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _WorkCard(data: apps[0], index: 0)),
        const SizedBox(width: 32),
        Expanded(child: _WorkCard(data: apps[1], index: 1)),
      ],
    );
  }
}

class _MobileGrid extends StatelessWidget {
  final List<_WorkData> apps;
  const _MobileGrid({required this.apps});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          apps.asMap().entries.map((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: _WorkCard(data: e.value, index: e.key),
            );
          }).toList(),
    );
  }
}

class _WorkCard extends StatefulWidget {
  final _WorkData data;
  final int index;
  const _WorkCard({required this.data, required this.index});

  @override
  State<_WorkCard> createState() => _WorkCardState();
}

class _WorkCardState extends State<_WorkCard> {
  bool _hovered = false;

  Future<void> _launchAppStore() async {
    await launchUrl(
      Uri.parse(widget.data.appStoreUrl),
      webOnlyWindowName: '_blank',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            transform:
                _hovered
                    ? Matrix4.translationValues(0, -6, 0)
                    : Matrix4.identity(),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color:
                      _hovered
                          ? widget.data.accentColor.withValues(alpha: 0.6)
                          : AppColors.border,
                  width: 2,
                ),
                boxShadow:
                    _hovered
                        ? [
                          BoxShadow(
                            color: widget.data.accentColor.withValues(
                              alpha: 0.15,
                            ),
                            blurRadius: 30,
                            offset: const Offset(0, 12),
                          ),
                        ]
                        : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Screenshots Grid
                  _AppScreenshotsGrid(
                    imagePaths: widget.data.imagePaths,
                    accentColor: widget.data.accentColor,
                    icon: widget.data.icon,
                  ),
                  const SizedBox(height: 24),

                  // App Info
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: widget.data.accentColor.withValues(
                            alpha: 0.12,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          widget.data.icon,
                          color: widget.data.accentColor,
                          size: 24,
                        ),
                      ),
                      const Spacer(),
                      _AppStoreButton(
                        onTap: _launchAppStore,
                        hovered: _hovered,
                        accentColor: widget.data.accentColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Text(
                    widget.data.title,
                    style: AppTextStyles.headingMedium.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 12),

                  Text(
                    widget.data.description,
                    style: AppTextStyles.bodyMedium,
                  ),
                  const SizedBox(height: 20),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        widget.data.tags
                            .map(
                              (tag) => _TagChip(
                                tag: tag,
                                color: widget.data.accentColor,
                              ),
                            )
                            .toList(),
                  ),
                ],
              ),
            ),
          )
          .animate()
          .fadeIn(
            delay: Duration(milliseconds: 200 * widget.index),
            duration: 600.ms,
          )
          .slideY(begin: 0.3, curve: Curves.easeOut),
    );
  }
}

class _AppStoreButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool hovered;
  final Color accentColor;

  const _AppStoreButton({
    required this.onTap,
    required this.hovered,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: hovered ? accentGradient : null,
          border: Border.all(color: accentColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.apple_rounded,
              size: 16,
              color: hovered ? Colors.white : accentColor,
            ),
            const SizedBox(width: 6),
            Text(
              'View on App Store',
              style: AppTextStyles.labelLarge.copyWith(
                fontSize: 12,
                color: hovered ? Colors.white : accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const accentGradient = LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class _TagChip extends StatelessWidget {
  final String tag;
  final Color color;
  const _TagChip({required this.tag, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Text(
        tag,
        style: AppTextStyles.monoSmall.copyWith(
          color: color.withValues(alpha: 0.9),
        ),
      ),
    );
  }
}

class _AppScreenshotsGrid extends StatelessWidget {
  final List<String> imagePaths;
  final Color accentColor;
  final IconData icon;

  const _AppScreenshotsGrid({
    required this.imagePaths,
    required this.accentColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return SizedBox(
      width: double.infinity,
      height: isMobile ? 180 : 200,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: imagePaths.length == 2 ? 2 : imagePaths.length,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return _ScreenshotContainer(
            imagePath: imagePaths[index],
            accentColor: accentColor,
            icon: icon,
            index: index,
          );
        },
      ),
    );
  }
}

class _ScreenshotContainer extends StatelessWidget {
  final String imagePath;
  final Color accentColor;
  final IconData icon;
  final int index;

  const _ScreenshotContainer({
    required this.imagePath,
    required this.accentColor,
    required this.icon,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withValues(alpha: 0.2), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: accentColor.withValues(alpha: 0.6)),
          const SizedBox(height: 4),
          Text(
            'Screen ${index + 1}',
            style: AppTextStyles.bodySmall.copyWith(
              color: accentColor.withValues(alpha: 0.8),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkData {
  final String title;
  final String description;
  final String appStoreUrl;
  final List<String> tags;
  final Color accentColor;
  final IconData icon;
  final List<String> imagePaths;

  const _WorkData({
    required this.title,
    required this.description,
    required this.appStoreUrl,
    required this.tags,
    required this.accentColor,
    required this.icon,
    required this.imagePaths,
  });
}
