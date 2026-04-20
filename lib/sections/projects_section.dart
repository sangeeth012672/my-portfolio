import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/app_constants.dart';
import '../models/project_model.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_title.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w > 900;
    final projects = _showAll
        ? AppConstants.projects
        : AppConstants.projects.take(3).toList();

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 80 : 24, vertical: 100),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Projects',
            subtitle:
                'A selection of real-world applications I\'ve designed and built.',
          ),
          // Featured grid
          LayoutBuilder(builder: (ctx, constraints) {
            final cols = isDesktop ? 3 : (w > 600 ? 2 : 1);
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: isDesktop ? 0.78 : 0.85,
              ),
              itemCount: projects.length,
              itemBuilder: (ctx, i) =>
                  _ProjectCard(project: projects[i], index: i),
            );
          }),
          const SizedBox(height: 48),
          // Show more / less button
          GestureDetector(
            onTap: () => setState(() => _showAll = !_showAll),
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
                    _showAll ? 'Show Less' : 'View All Projects',
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textLight),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    _showAll
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textMuted,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final int index;
  const _ProjectCard({required this.project, required this.index});

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
      child: AnimatedBuilder(
        animation: _scaleAnim,
        builder: (ctx, child) =>
            Transform.scale(scale: _scaleAnim.value, child: child),
        child: GlassCard(
          padding: EdgeInsets.zero,
          shadows: _hovered
              ? [
                  BoxShadow(
                    color: gradColors[0].withOpacity(0.22),
                    blurRadius: 40,
                    spreadRadius: -4,
                    offset: const Offset(0, 8),
                  )
                ]
              : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card header with gradient
              Container(
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [
                      gradColors[0].withOpacity(0.25),
                      gradColors[1].withOpacity(0.15),
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
                    // App icon placeholder
                    Center(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                              colors: gradColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          boxShadow: [
                            BoxShadow(
                              color: gradColors[0].withOpacity(0.35),
                              blurRadius: 20,
                              spreadRadius: -4,
                            )
                          ],
                        ),
                        child: const Icon(Icons.phone_android_rounded,
                            color: Colors.white, size: 28),
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
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textWhite,
                                letterSpacing: -0.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (p.featured)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                gradient: LinearGradient(
                                    colors: gradColors,
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight),
                              ),
                              child: Text('Featured',
                                  style: GoogleFonts.inter(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white)),
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        p.description,
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            color: AppColors.textMuted,
                            height: 1.6),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      // Tech chips
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: p.techStack
                            .map((t) => _TechChip(
                                label: t, color: gradColors[0]))
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                      // Links
                      Row(
                        children: [
                          _CardIconButton(
                            icon: FontAwesomeIcons.github,
                            label: 'GitHub',
                            color: AppColors.textMuted,
                            onTap: () {},
                          ),
                          const SizedBox(width: 12),
                          _CardIconButton(
                            icon: Icons.open_in_new_rounded,
                            label: 'Live',
                            color: gradColors[0],
                            onTap: () {},
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Text(label,
          style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color.withOpacity(0.9))),
    );
  }
}

class _CardIconButton extends StatefulWidget {
  final dynamic icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _CardIconButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
  @override
  State<_CardIconButton> createState() => _CardIconButtonState();
}

class _CardIconButtonState extends State<_CardIconButton> {
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
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color:
                _hovered ? widget.color.withOpacity(0.12) : Colors.transparent,
            border: Border.all(
                color: _hovered
                    ? widget.color.withOpacity(0.4)
                    : AppColors.borderGlass),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.icon is IconData
                  ? Icon(widget.icon as IconData,
                      size: 14, color: widget.color)
                  : FaIcon(widget.icon as IconData,
                      size: 13, color: widget.color),
              const SizedBox(width: 6),
              Text(widget.label,
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: widget.color)),
            ],
          ),
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
