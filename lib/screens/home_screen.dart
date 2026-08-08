import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/app_colors.dart';
import '../core/app_constants.dart';
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
    'Contacts',
  ];

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    final ctx = _sectionKeys[index].currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  void _showCvDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 650,
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: AppColors.bgCard,
            border: Border.all(color: AppColors.borderGlass),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 40,
              )
            ],
          ),
          child: Column(
            children: [
              // Header
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: AppColors.primaryGradient,
                    ),
                    child: const Icon(Icons.description_rounded,
                        color: AppColors.bgDark, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SANGEETH K SAMBASIVAN',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textWhite,
                          ),
                        ),
                        Text(
                          'Flutter Developer Curriculum Vitae',
                          style: GoogleFonts.inter(
                            fontSize: 12.5,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded,
                        color: AppColors.textMuted),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(color: AppColors.borderGlass),
              const SizedBox(height: 12),
              // Scrollable CV Text
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _CvSectionTitle('CONTACT DETAILS'),
                      _CvText(
                          '📍 Thrissur, Kerala\n📧 sangeethks742@gmail.com\n📞 +91-95672 59782 | +91-97780 04059'),
                      const SizedBox(height: 16),
                      _CvSectionTitle('SUMMARY'),
                      _CvText(AppConstants.bio),
                      const SizedBox(height: 16),
                      _CvSectionTitle('EXPERIENCE'),
                      ...AppConstants.experiences.map((exp) => Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '• ${exp.role} — ${exp.company} (${exp.period})',
                                  style: GoogleFonts.inter(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textLight,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                ...exp.bulletPoints.map(
                                  (bp) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 14, bottom: 3),
                                    child: Text(
                                      '- $bp',
                                      style: GoogleFonts.inter(
                                        fontSize: 12.5,
                                        color: AppColors.textMuted,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(height: 12),
                      _CvSectionTitle('TECHNICAL SKILLS'),
                      _CvText(
                          '• Languages: Dart, Java\n• Frameworks: Flutter\n• API Integration: REST APIs, HTTP, Dio\n• State Management: Provider, BLoC\n• Backend: Firebase, Python Django\n• Databases: Hive, SQLite, MySQL, SQL Server\n• Tools: Android Studio, VS Code, Git'),
                      const SizedBox(height: 16),
                      _CvSectionTitle('PROJECTS'),
                      ...AppConstants.projects.map((p) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              '• ${p.title} — ${p.subtitle}',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: AppColors.textLight,
                              ),
                            ),
                          )),
                      const SizedBox(height: 16),
                      _CvSectionTitle('EDUCATION'),
                      _CvText(
                          'BCA, Chinmaya Mission College, Thrissur (Jul 2015 – Aug 2018) | Bharathiar University'),
                      const SizedBox(height: 16),
                      _CvSectionTitle('LANGUAGES'),
                      _CvText('English (Fluent), Malayalam (Native), Tamil (Intermediate)'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => launchUrl(Uri.parse(AppConstants.whatsappUrl)),
                    icon: const Icon(Icons.chat_rounded, size: 16),
                    label: const Text('Contact Sangeeth'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'CV Summary copied & downloaded! Replace resumeUrl in AppConstants for direct PDF download.'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.download_rounded, size: 16),
                    label: const Text('Close / Print CV'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.bgDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
                  child: HeroSection(
                    onExploreWork: () => _scrollToSection(3),
                    onDownloadCv: () => _showCvDialog(context),
                    onContactMe: () => _scrollToSection(5),
                  ),
                ),
                KeyedSubtree(
                  key: _sectionKeys[1],
                  child: AboutSection(
                    onDownloadCv: () => _showCvDialog(context),
                  ),
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
              onDownloadCv: () => _showCvDialog(context),
            ),
          ),
        ],
      ),
      // Scroll to top FAB
      floatingActionButton: _ScrollTopButton(scrollController: _scrollCtrl),
    );
  }
}

class _CvSectionTitle extends StatelessWidget {
  final String title;
  const _CvSectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: GoogleFonts.spaceGrotesk(
          fontSize: 13.5,
          fontWeight: FontWeight.w800,
          color: AppColors.primary,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _CvText extends StatelessWidget {
  final String text;
  const _CvText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 13,
        color: AppColors.textLight,
        height: 1.6,
      ),
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
            ),
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
          child: const Icon(
            Icons.keyboard_arrow_up_rounded,
            color: AppColors.bgDark,
            size: 26,
          ),
        ),
      ),
    );
  }
}
