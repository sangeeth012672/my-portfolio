import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/app_constants.dart';
import '../widgets/animated_progress_ring.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_title.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w > 900;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 80 : 24, vertical: 100),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.bgSurface.withOpacity(0.3),
            AppColors.bgDark,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Skills',
            subtitle:
                'Technologies I\'ve mastered and tools I use to bring ideas to life.',
          ),
          GlassCard(
            child: Column(
              children: [
                // Category filter chips
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    _CategoryChip(label: 'All', isActive: true),
                  ],
                ),
                const SizedBox(height: 40),
                // Skills grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isDesktop ? 6 : (w > 600 ? 4 : 3),
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 32,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: AppConstants.skills.length,
                  itemBuilder: (ctx, i) {
                    final skill = AppConstants.skills[i];
                    final color = AppColors.skillColors[
                        i % AppColors.skillColors.length];
                    return AnimatedProgressRing(
                      value: skill.level,
                      label: skill.name,
                      color: color,
                      size: isDesktop ? 105 : 90,
                      strokeWidth: 7,
                    );
                  },
                ),
                const SizedBox(height: 40),
                const _SkillLegend(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isActive;
  const _CategoryChip({required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient: isActive ? AppColors.primaryGradient : null,
        color: isActive ? null : AppColors.bgCard,
        border: Border.all(
          color: isActive ? Colors.transparent : AppColors.borderGlass,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: isActive ? AppColors.bgDark : AppColors.textMuted,
        ),
      ),
    );
  }
}

class _SkillLegend extends StatelessWidget {
  const _SkillLegend();

  @override
  Widget build(BuildContext context) {
    final levels = [
      ('Expert (90–100%)', AppColors.primary),
      ('Advanced (80–89%)', AppColors.secondary),
      ('Proficient (70–79%)', AppColors.accent),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: levels
          .expand((l) => [
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: l.$2),
                  ),
                  const SizedBox(width: 6),
                  Text(l.$1,
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.textDim,
                          fontWeight: FontWeight.w500)),
                ]),
                const SizedBox(width: 24),
              ])
          .toList(),
    );
  }
}
