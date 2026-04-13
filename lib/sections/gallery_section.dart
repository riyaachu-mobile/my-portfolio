import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/section_header.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  static final List<String> _imagePaths = [
    'assets/images/lifemd_app_1.jpeg',
    'assets/images/lifemd_app_2.jpeg',
    'assets/images/lifemd_app_3.jpeg',
    'assets/images/lifemd_app_4.jpeg',
    'assets/images/myvca_app_1.jpeg',
    'assets/images/myvca_app_2.jpeg',
    'assets/images/genAI_1.png',
    'assets/images/genAI_2.png',
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
            tag: '03. GALLERY',
            title: 'App Showcase',
            subtitle: 'Featured mobile application screenshots and designs.',
          ),
          const SizedBox(height: 64),
          isMobile
              ? _MobileGallery(images: _imagePaths)
              : _DesktopGallery(images: _imagePaths),
        ],
      ),
    );
  }
}

class _DesktopGallery extends StatelessWidget {
  final List<String> images;
  const _DesktopGallery({required this.images});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First row (images 0-3)
        Row(
          children:
              images.asMap().entries.where((entry) => entry.key < 4).map((
                entry,
              ) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: entry.key < 3 ? 16 : 0),
                    child: _GalleryImage(
                      imagePath: entry.value,
                      index: entry.key,
                    ),
                  ),
                );
              }).toList(),
        ),
        const SizedBox(height: 16),
        // Second row (images 4-7)
        Row(
          children:
              images
                  .asMap()
                  .entries
                  .where((entry) => entry.key >= 4 && entry.key < 8)
                  .map((entry) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: entry.key < 7 ? 16 : 0),
                        child: _GalleryImage(
                          imagePath: entry.value,
                          index: entry.key,
                        ),
                      ),
                    );
                  })
                  .toList(),
        ),
      ],
    );
  }
}

class _MobileGallery extends StatelessWidget {
  final List<String> images;
  const _MobileGallery({required this.images});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          images.asMap().entries.map((entry) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: entry.key < images.length - 1 ? 16 : 0,
              ),
              child: _GalleryImage(imagePath: entry.value, index: entry.key),
            );
          }).toList(),
    );
  }
}

class _GalleryImage extends StatefulWidget {
  final String imagePath;
  final int index;
  const _GalleryImage({required this.imagePath, required this.index});

  @override
  State<_GalleryImage> createState() => _GalleryImageState();
}

class _GalleryImageState extends State<_GalleryImage> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform:
                _hovered
                    ? Matrix4.translationValues(0, -8, 0)
                    : Matrix4.identity(),
            child: Container(
              width: double.infinity,
              height: 700,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow:
                    _hovered
                        ? [
                          BoxShadow(
                            color: AppColors.accentBlue.withValues(alpha: 0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 12),
                          ),
                        ]
                        : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Actual image
                    Image.asset(
                      widget.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.cardBg,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_outlined,
                                size: 48,
                                color: AppColors.textMuted,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Image ${widget.index + 1}',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    // Overlay on hover
                    if (_hovered)
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.4),
                            ],
                          ),
                        ),
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
          .slideY(begin: 0.3, curve: Curves.easeOut),
    );
  }
}
