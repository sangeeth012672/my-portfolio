import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/app_constants.dart';
import '../models/experience_model.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_title.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: w > 900 ? 80 : 24, vertical: 100),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.bgDark, AppColors.bgSurface.withOpacity(0.3)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Experience',
            subtitle:
                'My professional journey — the roles, companies, and milestones that shaped me.',
          ),
          ...List.generate(AppConstants.experiences.length, (i) {
            final exp = AppConstants.experiences[i];
            final isLast = i == AppConstants.experiences.length - 1;
            return _TimelineEntry(
                experience: exp, index: i, isLast: isLast);
          }),
        ],
      ),
    );
  }
}

class _TimelineEntry extends StatefulWidget {
  final ExperienceModel experience;
  final int index;
  final bool isLast;
  const _TimelineEntry({
    required this.experience,
    required this.index,
    required this.isLast,
  });

  @override
  State<_TimelineEntry> createState() => _TimelineEntryState();
}

class _TimelineEntryState extends State<_TimelineEntry>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 700));
    _fadeAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: Offset(widget.index.isEven ? -0.04 : 0.04, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

    Future.delayed(Duration(milliseconds: 200 + widget.index * 150), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exp = widget.experience;

    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline line + dot
              SizedBox(
                width: 60,
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    // Dot
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: exp.isPresent
                            ? AppColors.primaryGradient
                            : const LinearGradient(
                                colors: [
                                  AppColors.secondary,
                                  AppColors.accent
                                ],
                              ),
                        boxShadow: [
                          BoxShadow(
                            color: (exp.isPresent
                                    ? AppColors.primary
                                    : AppColors.secondary)
                                .withOpacity(0.5),
                            blurRadius: 12,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: exp.isPresent
                          ? const Center(
                              child: Icon(Icons.circle,
                                  size: 8, color: Colors.white),
                            )
                          : null,
                    ),
                    // Line
                    if (!widget.isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: const BoxDecoration(
                            gradient: AppColors.timelineGradient,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              // Card
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    exp.role,
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textWhite,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.business_rounded,
                                          size: 14,
                                          color: AppColors.primary),
                                      const SizedBox(width: 6),
                                      Text(
                                        exp.company,
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: exp.isPresent
                                    ? AppColors.primary.withOpacity(0.12)
                                    : AppColors.bgSurface,
                                border: Border.all(
                                  color: exp.isPresent
                                      ? AppColors.primary.withOpacity(0.3)
                                      : AppColors.borderGlass,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (exp.isPresent) ...[
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF00FF88),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                  ],
                                  Text(
                                    exp.period,
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: exp.isPresent
                                          ? AppColors.primary
                                          : AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          exp.description,
                          style: GoogleFonts.inter(
                            fontSize: 14.5,
                            color: AppColors.textMuted,
                            height: 1.75,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Tech chips
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: exp.technologies
                              .map((t) => _ExpChip(label: t))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpChip extends StatelessWidget {
  final String label;
  const _ExpChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.bgSurface,
        border: Border.all(color: AppColors.borderGlass),
      ),
      child: Text(label,
          style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textMuted)),
    );
  }
}
