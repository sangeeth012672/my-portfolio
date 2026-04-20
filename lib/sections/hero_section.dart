import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/app_constants.dart';
import '../widgets/gradient_text.dart';
import '../widgets/particle_background.dart';
import '../widgets/social_icon_button.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

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

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ParticleBackground(
        child: Container(
          decoration: const BoxDecoration(gradient: AppColors.heroGradient),
          child: Stack(
            children: [
              // Background glow blobs
              Positioned(
                top: -100,
                left: -80,
                child: _GlowBlob(color: AppColors.primary, size: 400),
              ),
              Positioned(
                bottom: -120,
                right: -80,
                child: _GlowBlob(color: AppColors.secondary, size: 350),
              ),
              // Main content
              Center(
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: SlideTransition(
                    position: _slideAnim,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 80 : 24),
                      child: isDesktop
                          ? _DesktopHeroLayout()
                          : _MobileHeroLayout(),
                    ),
                  ),
                ),
              ),
              // Scroll indicator
              Positioned(
                bottom: 32,
                left: 0,
                right: 0,
                child: _ScrollIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopHeroLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 6, child: _HeroTextContent()),
        const SizedBox(width: 60),
        Expanded(flex: 4, child: _AvatarWidget()),
      ],
    );
  }
}

class _MobileHeroLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _AvatarWidget(),
        const SizedBox(height: 40),
        _HeroTextContent(),
      ],
    );
  }
}

class _HeroTextContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Greeting badge
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
                        spreadRadius: 2)
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Available for freelance & full-time',
                style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        // Name
        GradientText(
          'Hi, I\'m ${AppConstants.name}',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 58,
            fontWeight: FontWeight.w800,
            letterSpacing: -2.5,
            height: 1.05,
          ),
          gradient: AppColors.primaryGradient,
        ),
        const SizedBox(height: 16),
        // Animated role
        Row(
          children: [
            Text(
              'I\'m a  ',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: AppColors.textLight,
                letterSpacing: -0.5,
              ),
            ),
            DefaultTextStyle(
              style: GoogleFonts.spaceGrotesk(
                fontSize: 28,
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
                          speed: const Duration(milliseconds: 80),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Tagline
        Text(
          AppConstants.tagline,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: AppColors.textMuted,
            height: 1.75,
          ),
        ),
        const SizedBox(height: 40),
        // CTA Buttons
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _PrimaryButton(
              label: 'View My Work',
              icon: Icons.arrow_forward_rounded,
              onTap: () {},
            ),
            _OutlineButton(
              label: 'Download CV',
              icon: Icons.download_rounded,
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 48),
        // Social icons
        Row(
          children: [
            Text(
              'Follow me:',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textDim,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 16),
            SocialIconButton(
              icon: FontAwesomeIcons.github,
              tooltip: 'GitHub',
              onTap: () {},
            ),
            const SizedBox(width: 10),
            SocialIconButton(
              icon: FontAwesomeIcons.linkedin,
              tooltip: 'LinkedIn',
              onTap: () {},
              color: const Color(0xFF0A66C2),
            ),
            const SizedBox(width: 10),
            SocialIconButton(
              icon: FontAwesomeIcons.xTwitter,
              tooltip: 'Twitter / X',
              onTap: () {},
              color: AppColors.textLight,
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
      duration: const Duration(seconds: 8),
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
        height: 320,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Rotating gradient ring
            RotationTransition(
              turns: _rotController,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const SweepGradient(
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
            // Avatar placeholder with initials
            Container(
              width: 270,
              height: 270,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.cardGradient,
                border: Border.all(color: AppColors.borderGlass, width: 1.5),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (b) =>
                          AppColors.primaryGradient.createShader(b),
                      child: Text(
                        'AC',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 80,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -4,
                        ),
                      ),
                    ),
                    Text(
                      'Flutter Dev',
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1),
                    ),
                  ],
                ),
              ),
            ),
            // Floating tech badges
            Positioned(
              top: 20,
              right: 10,
              child: _TechBadge(label: '🎯 Dart', color: AppColors.primary),
            ),
            Positioned(
              bottom: 30,
              left: 0,
              child:
                  _TechBadge(label: '📱 Flutter', color: AppColors.secondary),
            ),
            Positioned(
              bottom: 80,
              right: 0,
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.bgCard,
        border: Border.all(color: color.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 16,
              spreadRadius: -2)
        ],
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: AppColors.textLight),
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
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: AppColors.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary
                    .withOpacity(_hovered ? 0.45 : 0.25),
                blurRadius: _hovered ? 30 : 18,
                spreadRadius: -4,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.label,
                  style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.bgDark)),
              const SizedBox(width: 10),
              AnimatedSlide(
                offset: _hovered ? const Offset(0.3, 0) : Offset.zero,
                duration: const Duration(milliseconds: 200),
                child: Icon(widget.icon,
                    size: 18, color: AppColors.bgDark),
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
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: _hovered
                ? AppColors.bgSurface
                : Colors.transparent,
            border: Border.all(
                color: AppColors.borderGlass, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon,
                  size: 18, color: AppColors.textMuted),
              const SizedBox(width: 10),
              Text(widget.label,
                  style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textLight)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScrollIndicator extends StatefulWidget {
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
    return AnimatedBuilder(
      animation: _bounceAnim,
      builder: (_, __) => Transform.translate(
        offset: Offset(0, _bounceAnim.value),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('scroll down',
                style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppColors.textDim,
                    letterSpacing: 1.5)),
            const SizedBox(height: 6),
            const Icon(Icons.keyboard_arrow_down_rounded,
                color: AppColors.textDim, size: 20),
          ],
        ),
      ),
    );
  }
}
