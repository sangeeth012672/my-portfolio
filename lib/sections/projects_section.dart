import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/app_constants.dart';
import '../core/responsive.dart';
import '../models/project_model.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_title.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _selectedCategory = 'All';
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final isDesktopOrLaptop = Responsive.isDesktop(context) || Responsive.isLaptop(context);

    List<ProjectModel> filtered = _selectedCategory == 'All'
        ? AppConstants.projects
        : (_selectedCategory == 'Featured'
            ? AppConstants.projects.where((p) => p.featured).toList()
            : AppConstants.projects
                .where((p) => p.category == _selectedCategory)
                .toList());

    final displayedProjects = _showAll ? filtered : filtered.take(6).toList();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktopOrLaptop ? 80 : 24,
        vertical: 100,
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Featured Projects',
            subtitle:
                'Cross-platform mobile applications, e-learning systems, healthcare apps, and web portals I\'ve developed.',
          ),
          // Category Tabs
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: AppConstants.projectCategories
                .map(
                  (cat) => _ProjectCategoryTab(
                    label: cat,
                    isActive: _selectedCategory == cat,
                    onTap: () => setState(() {
                      _selectedCategory = cat;
                      _showAll = false;
                    }),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 36),
          // Grid
          LayoutBuilder(
            builder: (ctx, constraints) {
              final cols = Responsive.isDesktop(context) || Responsive.isLaptop(context) 
                  ? 3 
                  : (Responsive.isTablet(context) ? 2 : 1);
                  
              final aspectRatio = Responsive.isDesktop(context) 
                  ? 0.78 
                  : (Responsive.isLaptop(context) 
                      ? 0.8 
                      : (Responsive.isTablet(context) ? 0.85 : 0.82));

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: aspectRatio,
                ),
                itemCount: displayedProjects.length,
                itemBuilder: (ctx, i) => _ProjectCard(
                  project: displayedProjects[i],
                  index: i,
                  onTap: () => _showProjectDetailModal(
                      context, displayedProjects[i]),
                ),
              );
            },
          ),
          if (filtered.length > 6) ...[
            const SizedBox(height: 48),
            GestureDetector(
              onTap: () => setState(() => _showAll = !_showAll),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderGlass, width: 1.5),
                    color: AppColors.bgCard,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _showAll
                            ? 'Show Less'
                            : 'View All ${filtered.length} Projects',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textLight,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        _showAll
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  void _showProjectDetailModal(BuildContext context, ProjectModel project) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: AppColors.bgCard,
            border: Border.all(color: AppColors.borderGlass),
            boxShadow: [
              BoxShadow(
                color: project.gradient[0].withOpacity(0.3),
                blurRadius: 30,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(colors: project.gradient),
                    ),
                    child: Icon(project.icon, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textWhite,
                          ),
                        ),
                        Text(
                          project.subtitle,
                          style: GoogleFonts.inter(
                            fontSize: 12.5,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
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
              const SizedBox(height: 18),
              Text(
                project.description,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textMuted,
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Key Features & Architecture:',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textWhite,
                ),
              ),
              const SizedBox(height: 10),
              ...project.features.map(
                (f) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle_rounded,
                          size: 16, color: Color(0xFF00FF88)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          f,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: AppColors.textLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Tech Stack:',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textWhite,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: project.techStack
                    .map((t) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: project.gradient[0].withOpacity(0.15),
                            border: Border.all(
                                color: project.gradient[0].withOpacity(0.3)),
                          ),
                          child: Text(
                            t,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textLight,
                            ),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: Text(
                      'Close',
                      style: GoogleFonts.inter(color: AppColors.textMuted),
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
}

class _ProjectCategoryTab extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ProjectCategoryTab({
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

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final int index;
  final VoidCallback onTap;
  const _ProjectCard({
    required this.project,
    required this.index,
    required this.onTap,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 220));
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.025).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final gradColors = p.gradient;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _hovered = true);
        _ctrl.forward();
      },
      onExit: (_) {
        setState(() => _hovered = false);
        _ctrl.reverse();
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _scaleAnim,
          builder: (ctx, child) =>
              Transform.scale(scale: _scaleAnim.value, child: child),
          child: GlassCard(
            padding: EdgeInsets.zero,
            shadows: _hovered
                ? [
                    BoxShadow(
                      color: gradColors[0].withOpacity(0.3),
                      blurRadius: 36,
                      spreadRadius: -4,
                      offset: const Offset(0, 8),
                    )
                  ]
                : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card Header with gradient background & icon
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    gradient: LinearGradient(
                      colors: [
                        gradColors[0].withOpacity(0.28),
                        gradColors[1].withOpacity(0.18),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Pattern
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _GridPatternPainter(gradColors[0]),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              colors: gradColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: gradColors[0].withOpacity(0.4),
                                blurRadius: 20,
                                spreadRadius: -4,
                              )
                            ],
                          ),
                          child: Icon(p.icon, color: Colors.white, size: 28),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.bgDark.withOpacity(0.7),
                            border: Border.all(
                                color: gradColors[0].withOpacity(0.4)),
                          ),
                          child: Text(
                            p.category,
                            style: GoogleFonts.inter(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: gradColors[0],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                p.title,
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textWhite,
                                  letterSpacing: -0.3,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (p.featured) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: LinearGradient(colors: gradColors),
                                ),
                                child: Text(
                                  'Featured',
                                  style: GoogleFonts.inter(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          p.subtitle,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: gradColors[0],
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          p.description,
                          style: GoogleFonts.inter(
                            fontSize: 12.5,
                            color: AppColors.textMuted,
                            height: 1.55,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: p.techStack
                              .take(4)
                              .map((t) => _TechChip(
                                  label: t, color: gradColors[0]))
                              .toList(),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Text(
                              'Click for details',
                              style: GoogleFonts.inter(
                                fontSize: 11.5,
                                color: AppColors.textDim,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 15,
                              color: gradColors[0],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  final String label;
  final Color color;
  const _TechChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: color.withOpacity(0.95),
        ),
      ),
    );
  }
}

class _GridPatternPainter extends CustomPainter {
  final Color color;
  _GridPatternPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.07)
      ..strokeWidth = 0.8;
    const step = 28.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPatternPainter old) => old.color != color;
}
