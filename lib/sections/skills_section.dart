import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/app_constants.dart';
import '../core/responsive.dart';
import '../widgets/animated_progress_ring.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_title.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final isDesktopOrLaptop = Responsive.isDesktop(context) || Responsive.isLaptop(context);

    final filteredSkills = _selectedCategory == 'All'
        ? AppConstants.skills
        : AppConstants.skills
            .where((s) => s.category == _selectedCategory)
            .toList();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktopOrLaptop ? 80 : 24,
        vertical: 100,
      ),
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
            title: 'Technical Skills',
            subtitle:
                'Frameworks, languages, state management, databases, and development tools I use.',
          ),
          GlassCard(
            child: Column(
              children: [
                // Category filter chips
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: AppConstants.skillCategories
                      .map(
                        (cat) => _CategoryChip(
                          label: cat,
                          isActive: _selectedCategory == cat,
                          onTap: () => setState(() => _selectedCategory = cat),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 40),
                // Skills grid
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Wrap(
                    key: ValueKey(_selectedCategory),
                    spacing: Responsive.isMobile(context) ? 16 : 24,
                    runSpacing: Responsive.isMobile(context) ? 24 : 32,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: List.generate(filteredSkills.length, (i) {
                      final skill = filteredSkills[i];
                      final color = AppColors.skillColors[i % AppColors.skillColors.length];
                      return SizedBox(
                        width: isDesktopOrLaptop ? 130 : (Responsive.isTablet(context) ? 110 : 90),
                        child: AnimatedProgressRing(
                          value: skill.level,
                          label: skill.name,
                          color: color,
                          size: isDesktopOrLaptop ? 100 : (Responsive.isTablet(context) ? 85 : 75),
                          strokeWidth: 6.5,
                        ),
                      );
                    }),
                  ),
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
  final VoidCallback onTap;
  const _CategoryChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: isActive ? AppColors.primaryGradient : null,
            color: isActive ? null : AppColors.bgCard,
            border: Border.all(
              color: isActive ? Colors.transparent : AppColors.borderGlass,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 16,
                      spreadRadius: -2,
                    )
                  ]
                : null,
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isActive ? AppColors.bgDark : AppColors.textMuted,
            ),
          ),
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
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: levels
          .map(
            (l) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: l.$2),
                ),
                const SizedBox(width: 8),
                Text(
                  l.$1,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.textDim,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
