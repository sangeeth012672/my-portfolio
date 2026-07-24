import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/app_colors.dart';
import '../core/app_constants.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_title.dart';

class AboutSection extends StatelessWidget {
  final VoidCallback? onDownloadCv;
  const AboutSection({super.key, this.onDownloadCv});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w > 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 100,
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'About Me',
            subtitle:
                'Flutter Developer specialized in cross-platform mobile solutions, Django REST API integration & state management.',
          ),
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 6,
                        child: _BioCard(onDownloadCv: onDownloadCv)),
                    const SizedBox(width: 32),
                    Expanded(flex: 5, child: _StatsGrid()),
                  ],
                )
              : Column(
                  children: [
                    _BioCard(onDownloadCv: onDownloadCv),
                    const SizedBox(height: 28),
                    _StatsGrid(),
                  ],
                ),
        ],
      ),
    );
  }
}

class _BioCard extends StatelessWidget {
  final VoidCallback? onDownloadCv;
  const _BioCard({this.onDownloadCv});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: AppColors.cardGradient,
                  border: Border.all(color: AppColors.borderGlass),
                ),
                child: const Icon(Icons.person_outline_rounded,
                    color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Professional Summary',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textWhite,
                    ),
                  ),
                  Text(
                    'Flutter Developer | Thrissur, Kerala',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            AppConstants.bio,
            style: GoogleFonts.inter(
              fontSize: 15,
              color: AppColors.textMuted,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 28),
          const Divider(color: AppColors.borderGlass, height: 1),
          const SizedBox(height: 24),
          // Key details rows
          _InfoRow(Icons.email_outlined, 'Email', AppConstants.email,
              onTap: () => _launchUrl('mailto:${AppConstants.email}')),
          _InfoRow(Icons.phone_outlined, 'Phones',
              '${AppConstants.phone1}  |  ${AppConstants.phone2}',
              onTap: () => _launchUrl('tel:+919567259782')),
          _InfoRow(Icons.location_on_outlined, 'Location', AppConstants.location),
          _InfoRow(
            Icons.code_rounded,
            'Core Stack',
            'Flutter, Dart, Django REST APIs, Provider, BLoC, Firebase',
          ),
          const SizedBox(height: 28),
          // Action Buttons
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton.icon(
                onPressed: onDownloadCv,
                icon: const Icon(Icons.download_rounded, size: 18),
                label: Text(
                  'Download CV',
                  style: GoogleFonts.inter(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.bgDark,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => _launchUrl(AppConstants.whatsappUrl),
                icon: const FaIcon(FontAwesomeIcons.whatsapp,
                    size: 16, color: Color(0xFF25D366)),
                label: Text(
                  'Chat on WhatsApp',
                  style: GoogleFonts.inter(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textLight,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  side: const BorderSide(color: AppColors.borderGlass),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;
  const _InfoRow(this.icon, this.label, this.value, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.primary.withOpacity(0.1),
              ),
              child: Icon(icon, size: 16, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 90,
              child: Text(
                '$label: ',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textDim,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 13.5,
                  color: onTap != null ? AppColors.primary : AppColors.textLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> _stats = [
    {
      'value': AppConstants.yearsExperience,
      'suffix': '+ Yrs',
      'label': 'Flutter & Android Development',
      'icon': Icons.timeline_rounded,
      'color': AppColors.primary,
    },
    {
      'value': AppConstants.projectsCompleted,
      'suffix': '+ Apps',
      'label': 'Production & Practice Projects',
      'icon': Icons.phone_iphone_rounded,
      'color': AppColors.secondary,
    },
    {
      'value': 2,
      'suffix': ' Backends',
      'label': 'Django REST & Firebase Integrated',
      'icon': Icons.api_rounded,
      'color': AppColors.accent,
    },
    {
      'value': 100,
      'suffix': '%',
      'label': 'Agile & Teamwork Focus',
      'icon': Icons.diversity_3_rounded,
      'color': const Color(0xFF00FF88),
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
    _countAnim = IntTween(begin: 0, end: widget.value).animate(
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
          const SizedBox(height: 12),
          AnimatedBuilder(
            animation: _countAnim,
            builder: (context, child) => Text(
              '${_countAnim.value}${widget.suffix}',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 28,
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
              fontSize: 12,
              color: AppColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
