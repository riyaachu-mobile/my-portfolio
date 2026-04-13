import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/section_header.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static final List<_SkillCategory> _categories = [
    _SkillCategory(
      title: 'Mobile Development',
      icon: Icons.phone_android_rounded,
      color: AppColors.accentBlue,
      skills: [
        'Flutter (Dart)',
        'Android (Java, Kotlin)',
        'iOS (Swift, Obj-C)',
        'React Native',
        'Jetpack Compose',
        'Kotlin Coroutines / Flow',
      ],
    ),
    _SkillCategory(
      title: 'Architecture & State',
      icon: Icons.layers_rounded,
      color: AppColors.accentPurple,
      skills: [
        'Clean Architecture',
        'MVVM / MVC / MVP',
        'DDD · SOLID Principles',
        'RiverPod',
        'Bloc / Provider / GetX',
        'Dagger / Hilt (DI)',
      ],
    ),
    _SkillCategory(
      title: 'Cloud & DevOps',
      icon: Icons.cloud_rounded,
      color: const Color(0xFF00D2FF),
      skills: [
        'AWS (EC2, S3, Lambda, RDS)',
        'Azure · GCP',
        'Firebase Platform',
        'GitHub Actions · CodeMagic',
        'Jenkins · Azure DevOps',
        'Terraform · AWS Cognito',
      ],
    ),
    _SkillCategory(
      title: 'APIs & Integrations',
      icon: Icons.hub_rounded,
      color: const Color(0xFFFF6B6B),
      skills: [
        'REST APIs · GraphQL',
        'OAuth2 · JWT · Retrofit',
        'WebSockets (Socket.IO)',
        'NFC · BLE · Deep Linking',
        'Twilio · Agora · Zoom',
        'Stripe · Razorpay · Apple Pay',
      ],
    ),
    _SkillCategory(
      title: 'QA Automation',
      icon: Icons.bug_report_rounded,
      color: const Color(0xFF43E97B),
      skills: [
        'WebDriverIO + TypeScript',
        'Cucumber (BDD)',
        'Espresso · JUnit · Mockito',
        'API Testing (Postman / Swagger)',
        'UI & Functional Testing',
        'SQL · MySQL · DynamoDB',
      ],
    ),
    _SkillCategory(
      title: 'Analytics & Tools',
      icon: Icons.bar_chart_rounded,
      color: const Color(0xFFFFA500),
      skills: [
        'Amplitude · Logstash',
        'Sentry · Alice',
        'Firebase / Google Analytics',
        'Figma',
        'Jira · Confluence · SVN',
        'Android Studio · Xcode',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;
    final isTablet = size.width < 1100 && !isMobile;

    int crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Container(
      color: AppColors.surfaceLight,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            tag: '02. SKILLS',
            title: 'Technical Expertise',
            subtitle:
                'Full-stack mobile toolkit — from Flutter & native to cloud, QA automation, and AI.',
          ),
          const SizedBox(height: 64),
          _SkillGrid(categories: _categories, crossAxisCount: crossAxisCount),
        ],
      ),
    );
  }
}

class _SkillGrid extends StatelessWidget {
  final List<_SkillCategory> categories;
  final int crossAxisCount;
  const _SkillGrid({required this.categories, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < categories.length; i += crossAxisCount) {
      final rowItems = categories.sublist(
        i,
        (i + crossAxisCount) > categories.length
            ? categories.length
            : i + crossAxisCount,
      );
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              rowItems.asMap().entries.map((e) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: e.key < rowItems.length - 1 ? 20 : 0,
                    ),
                    child: _SkillCard(data: e.value, index: i + e.key),
                  ),
                );
              }).toList(),
        ),
      );
      if (i + crossAxisCount < categories.length) {
        rows.add(const SizedBox(height: 20));
      }
    }
    return Column(children: rows);
  }
}

class _SkillCard extends StatelessWidget {
  final _SkillCategory data;
  final int index;
  const _SkillCard({required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: data.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(data.icon, color: data.color, size: 20),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      data.title,
                      style: AppTextStyles.labelLarge.copyWith(fontSize: 15),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    data.skills
                        .map(
                          (skill) => _SkillTag(skill: skill, color: data.color),
                        )
                        .toList(),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 80 * index), duration: 500.ms)
        .slideY(begin: 0.15, curve: Curves.easeOut);
  }
}

class _SkillTag extends StatefulWidget {
  final String skill;
  final Color color;
  const _SkillTag({required this.skill, required this.color});

  @override
  State<_SkillTag> createState() => _SkillTagState();
}

class _SkillTagState extends State<_SkillTag> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color:
              _hovered
                  ? widget.color.withValues(alpha: 0.15)
                  : AppColors.surface,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color:
                _hovered
                    ? widget.color.withValues(alpha: 0.5)
                    : AppColors.border,
            width: 1,
          ),
        ),
        child: Text(
          widget.skill,
          style: AppTextStyles.bodySmall.copyWith(
            color: _hovered ? widget.color : AppColors.textSecondary,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _SkillCategory {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> skills;
  const _SkillCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.skills,
  });
}
