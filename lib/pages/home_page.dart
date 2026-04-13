import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/top_info_bar.dart';
import '../sections/hero_section.dart';
import '../sections/gallery_section.dart';
import '../sections/skills_section.dart';
import '../sections/experience_section.dart';
import '../sections/contact_section.dart';
import '../constants/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  // One key per nav item: About(hero), Career, Gallery, Skills, Contact
  final List<GlobalKey> _sectionKeys = List.generate(5, (_) => GlobalKey());

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // About — section key 0 (Hero)
                SizedBox(key: _sectionKeys[0], child: const HeroSection()),
                // Experience — section key 1
                SizedBox(
                  key: _sectionKeys[1],
                  child: const ExperienceSection(),
                ),
                // Skills — section key 2
                SizedBox(key: _sectionKeys[2], child: const SkillsSection()),
                // Gallery — section key 3
                SizedBox(key: _sectionKeys[3], child: const GallerySection()),
                // Contact — section key 4
                SizedBox(key: _sectionKeys[4], child: const ContactSection()),
              ],
            ),
          ),

          // Fixed top info bar (email | phone | address)
          const Positioned(top: 0, left: 0, right: 0, child: TopInfoBar()),

          // Fixed Navbar below the top info bar
          Positioned(
            top: TopInfoBar.height,
            left: 0,
            right: 0,
            child: Navbar(
              scrollController: _scrollController,
              sectionKeys: _sectionKeys,
            ),
          ),
        ],
      ),
    );
  }
}
