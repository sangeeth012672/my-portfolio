import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../sections/about_section.dart';
import '../sections/contact_section.dart';
import '../sections/experience_section.dart';
import '../sections/hero_section.dart';
import '../sections/projects_section.dart';
import '../sections/skills_section.dart';
import '../widgets/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollCtrl = ScrollController();

  final List<GlobalKey> _sectionKeys = List.generate(6, (_) => GlobalKey());
  final List<String> _sectionNames = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Experience',
    'Contact',
  ];

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            controller: _scrollCtrl,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Each section tagged with its key
                KeyedSubtree(
                  key: _sectionKeys[0],
                  child: const HeroSection(),
                ),
                KeyedSubtree(
                  key: _sectionKeys[1],
                  child: const AboutSection(),
                ),
                KeyedSubtree(
                  key: _sectionKeys[2],
                  child: const SkillsSection(),
                ),
                KeyedSubtree(
                  key: _sectionKeys[3],
                  child: const ProjectsSection(),
                ),
                KeyedSubtree(
                  key: _sectionKeys[4],
                  child: const ExperienceSection(),
                ),
                KeyedSubtree(
                  key: _sectionKeys[5],
                  child: const ContactSection(),
                ),
              ],
            ),
          ),
          // Floating navbar pinned at top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PortfolioNavBar(
              scrollController: _scrollCtrl,
              sectionKeys: _sectionKeys,
              sectionNames: _sectionNames,
            ),
          ),
        ],
      ),
      // Scroll to top FAB
      floatingActionButton: _ScrollTopButton(scrollController: _scrollCtrl),
    );
  }
}

class _ScrollTopButton extends StatefulWidget {
  final ScrollController scrollController;
  const _ScrollTopButton({required this.scrollController});

  @override
  State<_ScrollTopButton> createState() => _ScrollTopButtonState();
}

class _ScrollTopButtonState extends State<_ScrollTopButton> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final shouldShow = widget.scrollController.offset > 400;
    if (shouldShow != _visible) setState(() => _visible = shouldShow);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.primaryGradient,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: -4,
            )
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () => widget.scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOutCubic,
          ),
          child: const Icon(Icons.keyboard_arrow_up_rounded,
              color: AppColors.bgDark, size: 26),
        ),
      ),
    );
  }
}
