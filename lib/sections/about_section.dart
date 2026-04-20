import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/app_constants.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_title.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w > 900;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 80 : 24, vertical: 100),
      child: Column(
        children: [
          const SectionTitle(
            title: 'About Me',
            subtitle:
                'A little bit about who I am, what I do and where I come from.',
          ),
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: _BioCard()),
                    const SizedBox(width: 32),
                    Expanded(flex: 5, child: _StatsGrid()),
                  ],
                )
              : Column(children: [_BioCard(), const SizedBox(height: 28), _StatsGrid()]),
        ],
      ),
    );
  }
}

class _BioCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: AppColors.cardGradient,
                  border: Border.all(color: AppColors.borderGlass),
                ),
                child: const Icon(Icons.person_outline_rounded,
                    color: AppColors.primary, size: 22),
              ),
              const SizedBox(width: 14),
              Text('Who Am I?',
                  style: GoogleFonts.spaceGrotesk(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textWhite)),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            AppConstants.bio,
            style: GoogleFonts.inter(
                fontSize: 15.5,
                color: AppColors.textMuted,
                height: 1.8),
          ),
          const SizedBox(height: 28),
          // Detail rows
          ...[
            _InfoRow(Icons.email_outlined, 'Email', AppConstants.email),
            _InfoRow(Icons.location_on_outlined, 'Location',
                AppConstants.location),
            _InfoRow(Icons.phone_outlined, 'Phone', AppConstants.phone),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 10),
          Text('$label: ',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textDim,
                  fontWeight: FontWeight.w500)),
          Expanded(
            child: Text(value,
                style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> _stats = [
    {
      'value': AppConstants.yearsExperience,
      'suffix': '+',
      'label': 'Years Experience',
      'icon': Icons.timeline_rounded,
      'color': AppColors.primary,
    },
    {
      'value': AppConstants.projectsCompleted,
      'suffix': '+',
      'label': 'Projects Completed',
      'icon': Icons.rocket_launch_rounded,
      'color': AppColors.secondary,
    },
    {
      'value': AppConstants.happyClients,
      'suffix': '+',
      'label': 'Happy Clients',
      'icon': Icons.people_alt_rounded,
      'color': AppColors.accent,
    },
    {
      'value': AppConstants.githubStars,
      'suffix': '+',
      'label': 'GitHub Stars',
      'icon': Icons.star_rounded,
      'color': const Color(0xFFFFB300),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.15,
      ),
      itemCount: _stats.length,
      itemBuilder: (ctx, i) => _StatCard(
        value: _stats[i]['value'] as int,
        suffix: _stats[i]['suffix'] as String,
        label: _stats[i]['label'] as String,
        icon: _stats[i]['icon'] as IconData,
        color: _stats[i]['color'] as Color,
      ),
    );
  }
}

class _StatCard extends StatefulWidget {
  final int value;
  final String suffix;
  final String label;
  final IconData icon;
  final Color color;
  const _StatCard({
    required this.value,
    required this.suffix,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<int> _countAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1600))
      ..forward();
    _countAnim =
        IntTween(begin: 0, end: widget.value).animate(
            CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color.withOpacity(0.12),
            ),
            child: Icon(widget.icon, color: widget.color, size: 22),
          ),
          const SizedBox(height: 14),
          AnimatedBuilder(
            animation: _countAnim,
            builder: (_, __) => Text(
              '${_countAnim.value}${widget.suffix}',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                color: widget.color,
                letterSpacing: -1,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.label,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                fontSize: 12.5,
                color: AppColors.textMuted,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
