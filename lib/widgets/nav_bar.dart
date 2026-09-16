import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/responsive.dart';

class PortfolioNavBar extends StatefulWidget {
  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;
  final List<String> sectionNames;
  final VoidCallback? onDownloadCv;

  const PortfolioNavBar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
    required this.sectionNames,
    this.onDownloadCv,
  });

  @override
  State<PortfolioNavBar> createState() => _PortfolioNavBarState();
}

class _PortfolioNavBarState extends State<PortfolioNavBar> {
  int _activeIndex = 0;
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = widget.scrollController.offset;
    if (offset > 40 && !_scrolled) setState(() => _scrolled = true);
    if (offset <= 40 && _scrolled) setState(() => _scrolled = false);

    for (int i = widget.sectionKeys.length - 1; i >= 0; i--) {
      final ctx = widget.sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      if (box.localToGlobal(Offset.zero).dy <= 240) {
        if (_activeIndex != i) setState(() => _activeIndex = i);
        break;
      }
    }
  }

  void _scrollTo(int index) {
    final ctx = widget.sectionKeys[index].currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktopOrLaptop = Responsive.isDesktop(context) || Responsive.isLaptop(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: _scrolled
                ? AppColors.bgDark.withOpacity(0.85)
                : Colors.transparent,
            border: _scrolled
                ? const Border(
                    bottom: BorderSide(color: AppColors.borderGlass))
                : null,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isDesktopOrLaptop ? 40 : 20, vertical: 14),
            child: Row(
              children: [
                // Logo / Name Initials
                GestureDetector(
                  onTap: () => _scrollTo(0),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppColors.primaryGradient,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.4),
                                blurRadius: 12,
                                spreadRadius: -2,
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'SK',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: AppColors.bgDark,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (b) =>
                              AppColors.primaryGradient.createShader(b),
                          child: Text(
                            'SANGEETH K SAMBASIVAN',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: isDesktopOrLaptop ? 17 : 14,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                if (isDesktopOrLaptop) ...[
                  ...List.generate(
                    widget.sectionNames.length,
                    (i) => _NavItem(
                      label: widget.sectionNames[i],
                      isActive: _activeIndex == i,
                      onTap: () => _scrollTo(i),
                    ),
                  ),
                  const SizedBox(width: 24),
                  _ResumeButton(onTap: widget.onDownloadCv),
                ] else ...[
                  IconButton(
                    icon: const Icon(Icons.menu_rounded,
                        color: AppColors.primary, size: 28),
                    onPressed: () {
                      _showMobileMenu(context);
                    },
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.textDim,
              ),
            ),
            const SizedBox(height: 24),
            ...List.generate(
              widget.sectionNames.length,
              (i) => ListTile(
                title: Text(
                  widget.sectionNames[i],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 18,
                    fontWeight: _activeIndex == i
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: _activeIndex == i
                        ? AppColors.primary
                        : AppColors.textLight,
                  ),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  _scrollTo(i);
                },
              ),
            ),
            const SizedBox(height: 16),
            _ResumeButton(onTap: () {
              Navigator.pop(ctx);
              widget.onDownloadCv?.call();
            }),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _NavItem(
      {required this.label, required this.isActive, required this.onTap});
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: widget.isActive || _hovered
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color: widget.isActive || _hovered
                      ? AppColors.primary
                      : AppColors.textMuted,
                ),
                child: Text(widget.label),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 2,
                width: widget.isActive ? 20 : 0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  gradient: AppColors.primaryGradient,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResumeButton extends StatefulWidget {
  final VoidCallback? onTap;
  const _ResumeButton({this.onTap});

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
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: _hovered ? AppColors.primaryGradient : null,
            border: Border.all(
              color: _hovered ? Colors.transparent : AppColors.primary,
              width: 1.5,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                        color: AppColors.primary.withOpacity(0.35),
                        blurRadius: 20,
                        spreadRadius: -4)
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.download_rounded,
                size: 16,
                color: _hovered ? AppColors.bgDark : AppColors.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Get CV',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _hovered ? AppColors.bgDark : AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
