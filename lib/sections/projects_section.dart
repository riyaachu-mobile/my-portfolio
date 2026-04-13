import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/section_header.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  static final List<_ProjectData> _projects = [
    _ProjectData(
      title: 'MyVCA Mobile App',
      description:
          'Led Flutter + Clean Architecture development for a veterinary care app. Built real-time video calling via Twilio, integrated Helpshift for customer support, and improved analytics with Amplitude & Logstash.',
      tags: ['Flutter', 'Clean Arch', 'Twilio', 'Amplitude', 'Helpshift'],
      icon: Icons.pets_rounded,
      accentColor: AppColors.accentBlue,
      links: [_LinkData(icon: Icons.apple_rounded, label: 'App Store')],
    ),
    _ProjectData(
      title: 'LumiRx App',
      description:
          'Led Flutter development for a LumiRx mobile application. Implemented NFC-based secure data exchange, Android Instant Apps, iOS App Clips, deep linking, and push notifications.',
      tags: ['Flutter', 'NFC', 'iOS App Clips', 'Deep Linking', 'Firebase'],
      icon: Icons.local_pharmacy_rounded,
      accentColor: AppColors.accentPurple,
      links: [_LinkData(icon: Icons.open_in_new_rounded, label: 'Live')],
    ),
    _ProjectData(
      title: 'HALEN Super App',
      description:
          'Built a feature-rich super app using Flutter & AWS Amplify. Integrated authentication and CDN, improving performance by 40%. Designed interactive UI using Figma.',
      tags: ['Flutter', 'AWS Amplify', 'Figma', 'CDN', 'Auth'],
      icon: Icons.flash_on_rounded,
      accentColor: const Color(0xFF00D2FF),
      links: [_LinkData(icon: Icons.open_in_new_rounded, label: 'Live')],
    ),
    _ProjectData(
      title: 'Government Assistance App',
      description:
          'Migrated and enhanced a complex government app using Flutter. Implemented CI/CD pipelines, Voice Response feature, and integrated a GenAI Chatbot for AI-powered conversational engagement.',
      tags: ['Flutter', 'GenAI', 'CI/CD', 'Voice Response', 'Chatbot'],
      icon: Icons.account_balance_rounded,
      accentColor: const Color(0xFF43E97B),
      links: [_LinkData(icon: Icons.open_in_new_rounded, label: 'Case Study')],
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
            tag: '02. PROJECTS',
            title: 'Featured Work',
            subtitle:
                'Production apps in healthcare, government, fintech, and consumer domains.',
          ),
          const SizedBox(height: 64),
          isMobile
              ? _MobileGrid(projects: _projects)
              : _DesktopGrid(projects: _projects),
        ],
      ),
    );
  }
}

class _DesktopGrid extends StatelessWidget {
  final List<_ProjectData> projects;
  const _DesktopGrid({required this.projects});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _ProjectCard(data: projects[0], index: 0)),
            const SizedBox(width: 24),
            Expanded(child: _ProjectCard(data: projects[1], index: 1)),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _ProjectCard(data: projects[2], index: 2)),
            const SizedBox(width: 24),
            Expanded(child: _ProjectCard(data: projects[3], index: 3)),
          ],
        ),
      ],
    );
  }
}

class _MobileGrid extends StatelessWidget {
  final List<_ProjectData> projects;
  const _MobileGrid({required this.projects});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          projects.asMap().entries.map((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: _ProjectCard(data: e.value, index: e.key),
            );
          }).toList(),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final _ProjectData data;
  final int index;
  const _ProjectCard({required this.data, required this.index});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

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
                    ? Matrix4.translationValues(0, -4, 0)
                    : Matrix4.identity(),
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border(
                  left: BorderSide(
                    color:
                        _hovered
                            ? widget.data.accentColor
                            : widget.data.accentColor.withValues(alpha: 0.4),
                    width: 3,
                  ),
                ),
                boxShadow:
                    _hovered
                        ? [
                          BoxShadow(
                            color: widget.data.accentColor.withValues(
                              alpha: 0.1,
                            ),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ]
                        : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: widget.data.accentColor.withValues(
                            alpha: 0.12,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          widget.data.icon,
                          color: widget.data.accentColor,
                          size: 22,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children:
                            widget.data.links.map((link) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: _LinkButton(data: link),
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.data.title,
                    style: AppTextStyles.headingMedium.copyWith(fontSize: 22),
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
            delay: Duration(milliseconds: 100 * widget.index),
            duration: 600.ms,
          )
          .slideY(begin: 0.2, curve: Curves.easeOut),
    );
  }
}

class _LinkButton extends StatefulWidget {
  final _LinkData data;
  const _LinkButton({required this.data});

  @override
  State<_LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<_LinkButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color:
              _hovered
                  ? AppColors.accentBlue.withValues(alpha: 0.15)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          widget.data.icon,
          size: 18,
          color: _hovered ? AppColors.accentBlue : AppColors.textMuted,
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String tag;
  final Color color;
  const _TagChip({required this.tag, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
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

class _ProjectData {
  final String title;
  final String description;
  final List<String> tags;
  final IconData icon;
  final Color accentColor;
  final List<_LinkData> links;

  const _ProjectData({
    required this.title,
    required this.description,
    required this.tags,
    required this.icon,
    required this.accentColor,
    required this.links,
  });
}

class _LinkData {
  final IconData icon;
  final String label;
  const _LinkData({required this.icon, required this.label});
}
