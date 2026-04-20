import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import 'gradient_text.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final CrossAxisAlignment alignment;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.alignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        // Label pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: AppColors.cardGradient,
            border: Border.all(color: AppColors.borderGlass),
          ),
          child: Text(
            '— ${title.toUpperCase()} —',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
              letterSpacing: 2.5,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Main heading
        GradientText(
          title,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 42,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.5,
            height: 1.1,
          ),
          textAlign: alignment == CrossAxisAlignment.center
              ? TextAlign.center
              : TextAlign.left,
          gradient: AppColors.primaryGradient,
        ),
        // Decorative line
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: alignment == CrossAxisAlignment.center
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 3,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 30,
              height: 3,
              decoration: BoxDecoration(
                gradient: AppColors.accentGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 20),
          Text(
            subtitle!,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppColors.textMuted,
              height: 1.7,
            ),
            textAlign: alignment == CrossAxisAlignment.center
                ? TextAlign.center
                : TextAlign.left,
          ),
        ],
        const SizedBox(height: 48),
      ],
    );
  }
}
