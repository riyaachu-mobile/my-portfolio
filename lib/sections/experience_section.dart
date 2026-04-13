import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/section_header.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  static final List<_ExperienceData> _experiences = [
    _ExperienceData(
      role: 'Lead Mobile Developer',
      company: 'Leading U.S. Healthcare Company',
      duration: '2022 – Present',
      type: 'Houston, TX',
      color: AppColors.accentBlue,
      icon: Icons.work_rounded,
      highlights: [
        'Strong expertise in full software development life cycle, state management (RiverPod, Bloc, Provider, GetX)',
        'Efficient session management using Clean Architecture, CI/CD pipelines, and integrating third-party services',
        'Skilled in team collaboration and on-site development, contributing to high-quality software delivery',
        'Strong leadership and project management experience, including mentoring junior developers',
        'Successfully leading mobile development for a leading U.S. healthcare company and an Abu Dhabi-based e-commerce platform',
      ],
    ),
    _ExperienceData(
      role: 'Senior Mobile Engineer',
      company: 'Healthcare Technology Solutions',
      duration: '2020 – 2022',
      type: 'Remote',
      color: AppColors.accentPurple,
      icon: Icons.local_hospital_rounded,
      highlights: [
        'Support onboarding of new developers through hands-on guidance and process training',
        'Facilitate technical discussions and design reviews to align development with architectural goals',
        'Proactively learning React Native through self-study, building personal projects, and exploring best practices',
        'Integration of third-party services (Twilio, Agora, Zoom, Helpshift, Payment Gateways, Firebase, OneSignal)',
        'Firebase Analytics implementation and performance optimization',
      ],
    ),
    _ExperienceData(
      role: 'Mobile Development Lead',
      company: 'E-commerce Platform',
      duration: '2019 – 2020',
      type: 'Abu Dhabi, UAE',
      color: const Color(0xFF00D2FF),
      icon: Icons.shopping_cart_rounded,
      highlights: [
        'Led cross-platform mobile development for Abu Dhabi-based e-commerce platform',
        'Implemented scalable architecture using Clean Architecture principles',
        'Integrated payment gateways and secure authentication systems',
        'Established CI/CD pipelines and automated testing frameworks',
        'Mentored development team in best practices and modern mobile development patterns',
      ],
    ),
    _ExperienceData(
      role: 'Android Developer',
      company: 'CodeFolks Technologies',
      duration: 'Aug 2018 – Nov 2019',
      type: 'India',
      color: const Color(0xFFFFA500),
      icon: Icons.code_rounded,
      highlights: [
        'Developed native Android apps (Java MVVM/MVC, DataBinding, Kotlin) with REST/JSON data handling',
        'Implemented Dependency Injection and build management using Gradle',
        'Used SQLite/MySQL for offline storage; Firebase Crashlytics for monitoring; ASO for store optimization',
        'Hands-on with BLE, NFC, ADB, and multi-threading (AsyncTask, Handler, Kotlin Coroutines) — Apps: Doukani, Humfit',
      ],
    ),
    _ExperienceData(
      role: 'Senior Flutter Developer',
      company: 'Cloud IQ Technologies',
      duration: 'May 2023 – Mar 2025',
      type: 'Houston, TX',
      color: const Color(0xFF00D2FF),
      icon: Icons.cloud_rounded,
      highlights: [
        'Led design & development of MyVCA using Flutter, RiverPod, Bloc, and Azure DevOps',
        'Built real-time video calling (Twilio), chat system with video/image/PDF attachments, and Helpshift SDK support',
        'Automated builds, code signing, and Store publishing with Fastlane; CI/CD via Azure DevOps',
        'Integrated social login (Google, Facebook, Apple), JWT auth, Firebase + OneSignal push notifications',
        'Implemented GraphQL API testing, accessibility features, and Amplitude/Logstash analytics',
      ],
    ),
    _ExperienceData(
      role: 'Lead Flutter Engineer',
      company: 'Halen Super App',
      duration: 'Mar 2023 – May 2023',
      type: 'Houston, TX',
      color: const Color(0xFF43E97B),
      icon: Icons.flash_on_rounded,
      highlights: [
        'Designed and developed the HALEN SUPER APP using Flutter and AWS Amplify',
        'Integrated AWS authentication/authorization and CDN — improved load times by 40%',
        'Implemented Firebase Cloud Messaging (FCM) for push notifications across all app states',
        'Built interactive UX in Figma and led Agile sprints with daily stand-ups and backlog grooming',
      ],
    ),
    _ExperienceData(
      role: 'Senior Mobile Application Engineer',
      company: 'Dexlock Technologies',
      duration: 'Nov 2019 – May 2022',
      type: 'India',
      color: const Color(0xFFFF6B6B),
      icon: Icons.smartphone_rounded,
      highlights: [
        'Shipped LifeMD, Telehealings (Flutter), Highrich (Kotlin + Jetpack Compose + Coroutines/Flow), Upcomer Esports',
        'Integrated payment gateways: Chargify, Razorpay, Apple Pay, Google Pay, Stripe',
        'Integrated video SDKs (Agora, Twilio, Zoom) and built real-time chat via Socket.IO with online/last-seen tracking',
        'Implemented CodeMagic CI/CD; improved reliability with Sentry error monitoring and Alice HTTP debugging',
      ],
    ),
  ];

  static final List<_EducationData> _education = [
    _EducationData(
      degree: 'B.Tech in Computer Science',
      institution: 'University — India',
      duration: 'Computer Science',
      color: const Color(0xFFFF6B6B),
      icon: Icons.school_rounded,
    ),
    _EducationData(
      degree: 'QA Automation',
      institution: 'WebDriverIO + TypeScript · Cucumber',
      duration: 'Specialized',
      color: const Color(0xFF43E97B),
      icon: Icons.verified_rounded,
    ),
    _EducationData(
      degree: 'Cloud Platforms',
      institution: 'AWS · Azure · GCP',
      duration: 'Multi-Cloud',
      color: const Color(0xFF00D2FF),
      icon: Icons.cloud_done_rounded,
    ),
    _EducationData(
      degree: 'Agile / Scrum · SAFe',
      institution: 'Cross-functional team delivery',
      duration: '7+ Years',
      color: AppColors.accentPurple,
      icon: Icons.groups_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            tag: '01. CAREER',
            title: 'Professional Experience',
            subtitle:
                'Building production-grade mobile solutions with a focus on architecture, performance, and scalability.',
          ),
          const SizedBox(height: 32),
          isMobile
              ? _MobileLayout(experiences: _experiences, education: _education)
              : _DesktopLayout(
                experiences: _experiences,
                education: _education,
              ),
        ],
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  final List<_ExperienceData> experiences;
  final List<_EducationData> education;
  const _DesktopLayout({required this.experiences, required this.education});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Experience', style: AppTextStyles.headingMedium),
              const SizedBox(height: 28),
              ...experiences.asMap().entries.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _ExperienceCard(data: e.value, index: e.key),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Education', style: AppTextStyles.headingMedium),
              const SizedBox(height: 28),
              ...education.asMap().entries.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _EducationCard(data: e.value, index: e.key),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final List<_ExperienceData> experiences;
  final List<_EducationData> education;
  const _MobileLayout({required this.experiences, required this.education});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Experience', style: AppTextStyles.headingMedium),
        const SizedBox(height: 28),
        ...experiences.asMap().entries.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _ExperienceCard(data: e.value, index: e.key),
          ),
        ),
        const SizedBox(height: 40),
        Text('Education', style: AppTextStyles.headingMedium),
        const SizedBox(height: 28),
        ...education.asMap().entries.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _EducationCard(data: e.value, index: e.key),
          ),
        ),
      ],
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  final _ExperienceData data;
  final int index;
  const _ExperienceCard({required this.data, required this.index});

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _expanded = false;

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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.role,
                          style: AppTextStyles.labelLarge.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.data.company,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: widget.data.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.data.duration,
                        style: AppTextStyles.monoSmall,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: widget.data.color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          widget.data.type,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: widget.data.color,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Row(
                  children: [
                    Text(
                      _expanded ? 'Hide details' : 'Show details',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.accentBlue,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 4),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 16,
                        color: AppColors.accentBlue,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child:
                    _expanded
                        ? Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                widget.data.highlights.map((h) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 6,
                                          ),
                                          child: Container(
                                            width: 5,
                                            height: 5,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: widget.data.color,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            h,
                                            style: AppTextStyles.bodyMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                          ),
                        )
                        : const SizedBox.shrink(),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 100 * widget.index),
          duration: 600.ms,
        )
        .slideX(begin: -0.1, curve: Curves.easeOut);
  }
}

class _EducationCard extends StatelessWidget {
  final _EducationData data;
  final int index;
  const _EducationCard({required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: data.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(data.icon, color: data.color, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.degree,
                      style: AppTextStyles.labelLarge.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.institution,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: data.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(data.duration, style: AppTextStyles.monoSmall),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 100 * index), duration: 600.ms)
        .slideX(begin: 0.1, curve: Curves.easeOut);
  }
}

class _ExperienceData {
  final String role;
  final String company;
  final String duration;
  final String type;
  final Color color;
  final IconData icon;
  final List<String> highlights;

  const _ExperienceData({
    required this.role,
    required this.company,
    required this.duration,
    required this.type,
    required this.color,
    required this.icon,
    required this.highlights,
  });
}

class _EducationData {
  final String degree;
  final String institution;
  final String duration;
  final Color color;
  final IconData icon;

  const _EducationData({
    required this.degree,
    required this.institution,
    required this.duration,
    required this.color,
    required this.icon,
  });
}
