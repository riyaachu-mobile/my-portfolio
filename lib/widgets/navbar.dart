import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class Navbar extends StatefulWidget {
  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;

  const Navbar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool _isScrolled = false;
  int _activeIndex = 0;

  final List<String> _navItems = [
    'About',
    'Career',
    'Skills',
    'Gallery',
    'Contact',
  ];

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final scrolled = widget.scrollController.offset > 20;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  void _scrollToSection(int index) {
    if (index >= widget.sectionKeys.length) return;
    final key = widget.sectionKeys[index];
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
    setState(() => _activeIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color:
            _isScrolled
                ? AppColors.background.withValues(alpha: 0.85)
                : Colors.transparent,
        border:
            _isScrolled
                ? Border(
                  bottom: BorderSide(
                    color: AppColors.border.withValues(alpha: 0.6),
                    width: 1,
                  ),
                )
                : null,
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 60,
              vertical: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo / Brand
                GestureDetector(
                  onTap:
                      () => widget.scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOut,
                      ),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: AppColors.accentGradient,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'RA',
                        style: GoogleFonts.dmSerifDisplay(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                if (!isMobile) ...[
                  Row(
                    children: List.generate(_navItems.length, (i) {
                      final isActive = _activeIndex == i;
                      return Padding(
                        padding: const EdgeInsets.only(left: 36),
                        child: _NavItem(
                          label: _navItems[i],
                          isActive: isActive,
                          onTap: () => _scrollToSection(i),
                        ),
                      );
                    }),
                  ),
                ] else ...[
                  _MobileMenuButton(
                    navItems: _navItems,
                    onTap: _scrollToSection,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
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
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:
                    widget.isActive || _hovered
                        ? AppColors.accentBlue
                        : Colors.transparent,
                width: 1.5,
              ),
            ),
          ),
          child: Text(
            widget.label.toUpperCase(),
            style: AppTextStyles.navLink.copyWith(
              color:
                  widget.isActive || _hovered
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _ResumeButton extends StatefulWidget {
  @override
  State<_ResumeButton> createState() => _ResumeButtonState();
}

class _ResumeButtonState extends State<_ResumeButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: _hovered ? AppColors.accentGradient : null,
          border: Border.all(color: AppColors.accentBlue, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Resume',
          style: AppTextStyles.labelLarge.copyWith(
            fontSize: 13,
            color: _hovered ? Colors.white : AppColors.accentBlue,
          ),
        ),
      ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  final List<String> navItems;
  final Function(int) onTap;

  const _MobileMenuButton({required this.navItems, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: AppColors.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder:
              (_) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(navItems.length, (i) {
                    return ListTile(
                      title: Text(navItems[i], style: AppTextStyles.labelLarge),
                      onTap: () {
                        Navigator.pop(context);
                        onTap(i);
                      },
                    );
                  }),
                ),
              ),
        );
      },
      icon: const Icon(Icons.menu, color: AppColors.textPrimary),
    );
  }
}
