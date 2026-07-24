import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/app_colors.dart';
import '../core/app_constants.dart';
import '../widgets/gradient_text.dart';
import '../widgets/particle_background.dart';
import '../widgets/social_icon_button.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback? onExploreWork;
  final VoidCallback? onDownloadCv;
  final VoidCallback? onContactMe;

  const HeroSection({
    super.key,
    this.onExploreWork,
    this.onDownloadCv,
    this.onContactMe,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
    _fadeAnim = CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w > 900;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
      child: ParticleBackground(
        child: Container(
          decoration: const BoxDecoration(gradient: AppColors.heroGradient),
          child: Stack(
            children: [
              // Background ambient glow blobs
              Positioned(
                top: -100,
                left: -80,
                child: _GlowBlob(color: AppColors.primary, size: 420),
              ),
              Positioned(
                bottom: -120,
                right: -80,
                child: _GlowBlob(color: AppColors.secondary, size: 380),
              ),
              // Main content
              Center(
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: SlideTransition(
                    position: _slideAnim,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 80 : 24,
                        vertical: 100,
                      ),
                      child: isDesktop
                          ? _DesktopHeroLayout(
                              onExploreWork: widget.onExploreWork,
                              onDownloadCv: widget.onDownloadCv,
                              onContactMe: widget.onContactMe,
                            )
                          : _MobileHeroLayout(
                              onExploreWork: widget.onExploreWork,
                              onDownloadCv: widget.onDownloadCv,
                              onContactMe: widget.onContactMe,
                            ),
                    ),
                  ),
                ),
              ),
              // Scroll indicator
              Positioned(
                bottom: 24,
                left: 0,
                right: 0,
                child: _ScrollIndicator(onTap: widget.onExploreWork),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopHeroLayout extends StatelessWidget {
  final VoidCallback? onExploreWork;
  final VoidCallback? onDownloadCv;
  final VoidCallback? onContactMe;

  const _DesktopHeroLayout({
    this.onExploreWork,
    this.onDownloadCv,
    this.onContactMe,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: _HeroTextContent(
            onExploreWork: onExploreWork,
            onDownloadCv: onDownloadCv,
            onContactMe: onContactMe,
          ),
        ),
        const SizedBox(width: 60),
        Expanded(flex: 4, child: _AvatarWidget()),
      ],
    );
  }
}

class _MobileHeroLayout extends StatelessWidget {
  final VoidCallback? onExploreWork;
  final VoidCallback? onDownloadCv;
  final VoidCallback? onContactMe;

  const _MobileHeroLayout({
    this.onExploreWork,
    this.onDownloadCv,
    this.onContactMe,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _AvatarWidget(),
        const SizedBox(height: 36),
        _HeroTextContent(
          onExploreWork: onExploreWork,
          onDownloadCv: onDownloadCv,
          onContactMe: onContactMe,
        ),
      ],
    );
  }
}

class _HeroTextContent extends StatelessWidget {
  final VoidCallback? onExploreWork;
  final VoidCallback? onDownloadCv;
  final VoidCallback? onContactMe;

  const _HeroTextContent({
    this.onExploreWork,
    this.onDownloadCv,
    this.onContactMe,
  });

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w <= 600;

    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Availability & Location status badge
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.bgGlass,
                border: Border.all(color: AppColors.borderGlass),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF00FF88),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x8800FF88),
                          blurRadius: 8,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Available for Full-time & Client Roles',
                    style: GoogleFonts.inter(
                      fontSize: 12.5,
                      color: AppColors.textLight,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.bgCard,
                border: Border.all(color: AppColors.borderGlass),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.location_on_rounded,
                      color: AppColors.primary, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    'Thrissur, Kerala',
                    style: GoogleFonts.inter(
                      fontSize: 12.5,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Name
        GradientText(
          AppConstants.name,
          style: GoogleFonts.plusJakartaSans(
            fontSize: isMobile ? 34 : 50,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            height: 1.25,
          ),
          gradient: AppColors.primaryGradient,
        ),
        const SizedBox(height: 14),
        // Animated role
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'I build ',
              style: GoogleFonts.spaceGrotesk(
                fontSize: isMobile ? 20 : 26,
                fontWeight: FontWeight.w600,
                color: AppColors.textLight,
                letterSpacing: -0.5,
              ),
            ),
            DefaultTextStyle(
              style: GoogleFonts.spaceGrotesk(
                fontSize: isMobile ? 20 : 26,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                letterSpacing: -0.5,
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                pause: const Duration(milliseconds: 1200),
                animatedTexts: AppConstants.typingRoles
                    .map((r) => TypewriterAnimatedText(
                          r,
                          speed: const Duration(milliseconds: 70),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Tagline
        Text(
          AppConstants.tagline,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.inter(
            fontSize: 15.5,
            color: AppColors.textMuted,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 36),
        // CTA Buttons
        Wrap(
          spacing: 14,
          runSpacing: 14,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _PrimaryButton(
              label: 'Explore Work',
              icon: Icons.rocket_launch_rounded,
              onTap: () => onExploreWork?.call(),
            ),
            _OutlineButton(
              label: 'Download CV',
              icon: Icons.description_rounded,
              onTap: () => onDownloadCv?.call(),
            ),
            _GlassButton(
              label: 'WhatsApp',
              icon: FontAwesomeIcons.whatsapp,
              color: const Color(0xFF25D366),
              onTap: () => _launchUrl(AppConstants.whatsappUrl),
            ),
          ],
        ),
        const SizedBox(height: 40),
        // Social links bar
        Row(
          mainAxisAlignment:
              isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Text(
              'Connect:',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textDim,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 14),
            SocialIconButton(
              icon: FontAwesomeIcons.github,
              tooltip: 'GitHub',
              onTap: () => _launchUrl(AppConstants.githubUrl),
            ),
            const SizedBox(width: 10),
            SocialIconButton(
              icon: FontAwesomeIcons.linkedin,
              tooltip: 'LinkedIn',
              onTap: () => _launchUrl(AppConstants.linkedinUrl),
              color: const Color(0xFF0A66C2),
            ),
            const SizedBox(width: 10),
            SocialIconButton(
              icon: FontAwesomeIcons.whatsapp,
              tooltip: 'WhatsApp Direct Chat',
              onTap: () => _launchUrl(AppConstants.whatsappUrl),
              color: const Color(0xFF25D366),
            ),
            const SizedBox(width: 10),
            SocialIconButton(
              icon: Icons.email_rounded,
              tooltip: 'Email Sangeeth',
              onTap: () => _launchUrl('mailto:${AppConstants.email}'),
              color: AppColors.primary,
            ),
          ],
        ),
      ],
    );
  }
}

class _AvatarWidget extends StatefulWidget {
  @override
  State<_AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<_AvatarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotController;

  @override
  void initState() {
    super.initState();
    _rotController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _rotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 320,
        height: 330,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Rotating gradient glow ring
            RotationTransition(
              turns: _rotController,
              child: Container(
                width: 290,
                height: 290,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.secondary,
                      AppColors.accent,
                      AppColors.primary,
                    ],
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.bgDark,
                  ),
                ),
              ),
            ),
            // Profile photo / demo image placeholder card
            Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.borderGlass, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.25),
                    blurRadius: 30,
                    spreadRadius: -4,
                  )
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile.png',
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, stack) => Container(
                    color: AppColors.bgCard,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (b) =>
                                AppColors.primaryGradient.createShader(b),
                            child: Text(
                              'SKS',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 64,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -2,
                              ),
                            ),
                          ),
                          Text(
                            'Flutter Developer',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Demo photo replace notice pill
            Positioned(
              bottom: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.bgDark.withOpacity(0.9),
                  border: Border.all(color: AppColors.primary.withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add_a_photo_rounded,
                        color: AppColors.primary, size: 13),
                    const SizedBox(width: 6),
                    Text(
                      'Demo Photo (Replace in assets/images/profile.png)',
                      style: GoogleFonts.inter(
                        fontSize: 10.5,
                        color: AppColors.textLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Floating Tech Badges
            Positioned(
              top: 15,
              right: 0,
              child: _TechBadge(label: '💙 Flutter', color: AppColors.primary),
            ),
            Positioned(
              bottom: 45,
              left: -5,
              child: _TechBadge(label: '🎯 Dart', color: AppColors.secondary),
            ),
            Positioned(
              bottom: 85,
              right: -5,
              child: _TechBadge(
                label: '🐍 Django REST',
                color: const Color(0xFF00FF88),
              ),
            ),
            Positioned(
              top: 45,
              left: -5,
              child: _TechBadge(label: '🔥 Firebase', color: AppColors.accent),
            ),
          ],
        ),
      ),
    );
  }
}

class _TechBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _TechBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.bgCard.withOpacity(0.9),
        border: Border.all(color: color.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.25),
            blurRadius: 16,
            spreadRadius: -2,
          )
        ],
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.textLight,
        ),
      ),
    );
  }
}

class _GlowBlob extends StatelessWidget {
  final Color color;
  final double size;
  const _GlowBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.12), blurRadius: size * 0.8)
        ],
        gradient: RadialGradient(colors: [
          color.withOpacity(0.08),
          Colors.transparent,
        ]),
      ),
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _PrimaryButton(
      {required this.label, required this.icon, required this.onTap});
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
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: AppColors.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary
                    .withOpacity(_hovered ? 0.45 : 0.25),
                blurRadius: _hovered ? 28 : 16,
                spreadRadius: -4,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.bgDark,
                ),
              ),
              const SizedBox(width: 10),
              AnimatedSlide(
                offset: _hovered ? const Offset(0.25, 0) : Offset.zero,
                duration: const Duration(milliseconds: 200),
                child: Icon(widget.icon, size: 17, color: AppColors.bgDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _OutlineButton(
      {required this.label, required this.icon, required this.onTap});
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
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: _hovered ? AppColors.bgSurface : Colors.transparent,
            border: Border.all(color: AppColors.borderGlass, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 17, color: AppColors.textMuted),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _GlassButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  State<_GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<_GlassButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: widget.color.withOpacity(_hovered ? 0.2 : 0.1),
            border: Border.all(
                color: widget.color.withOpacity(_hovered ? 0.6 : 0.3)),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: -2,
                    )
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(widget.icon, size: 16, color: widget.color),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: widget.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScrollIndicator extends StatefulWidget {
  final VoidCallback? onTap;
  const _ScrollIndicator({this.onTap});

  @override
  State<_ScrollIndicator> createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<_ScrollIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat(reverse: true);
    _bounceAnim = Tween<double>(begin: 0, end: 8).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedBuilder(
          animation: _bounceAnim,
          builder: (context, child) => Transform.translate(
            offset: Offset(0, _bounceAnim.value),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'explore portfolio',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppColors.textDim,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.primary,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
