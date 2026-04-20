import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/app_constants.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_title.dart';
import '../widgets/social_icon_button.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  bool _sending = false;
  bool _sent = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleSend() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _sending = true);
      await Future.delayed(const Duration(milliseconds: 1800));
      if (mounted) setState(() { _sending = false; _sent = true; });
    }
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
            title: 'Contact',
            subtitle:
                'Have a project in mind? Let\'s build something amazing together.',
          ),
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: _ContactInfoCard()),
                    const SizedBox(width: 32),
                    Expanded(flex: 6, child: _ContactForm(
                      formKey: _formKey,
                      nameCtrl: _nameCtrl,
                      emailCtrl: _emailCtrl,
                      msgCtrl: _msgCtrl,
                      sending: _sending,
                      sent: _sent,
                      onSend: _handleSend,
                    )),
                  ],
                )
              : Column(children: [
                  _ContactInfoCard(),
                  const SizedBox(height: 28),
                  _ContactForm(
                    formKey: _formKey,
                    nameCtrl: _nameCtrl,
                    emailCtrl: _emailCtrl,
                    msgCtrl: _msgCtrl,
                    sending: _sending,
                    sent: _sent,
                    onSend: _handleSend,
                  ),
                ]),
          const SizedBox(height: 80),
          // Footer
          const Divider(color: AppColors.borderGlass, height: 1),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© 2025 ${AppConstants.name}. All rights reserved.',
                style: GoogleFonts.inter(
                    fontSize: 13, color: AppColors.textDim),
              ),
              Text(
                'Built with ❤️ in Flutter',
                style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.textDim,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Let\'s talk',
              style: GoogleFonts.spaceGrotesk(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textWhite,
                  letterSpacing: -0.7)),
          const SizedBox(height: 10),
          Text(
            'I\'m always open to discussing new projects, creative ideas, or opportunities to be part of something great.',
            style: GoogleFonts.inter(
                fontSize: 14.5,
                color: AppColors.textMuted,
                height: 1.75),
          ),
          const SizedBox(height: 32),
          _ContactItem(
            icon: Icons.email_outlined,
            label: 'Email',
            value: AppConstants.email,
            color: AppColors.primary,
          ),
          const SizedBox(height: 16),
          _ContactItem(
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: AppConstants.location,
            color: AppColors.secondary,
          ),
          const SizedBox(height: 16),
          _ContactItem(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: AppConstants.phone,
            color: AppColors.accent,
          ),
          const SizedBox(height: 36),
          Text('Find me on',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textDim,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 14),
          Row(
            children: [
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
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.1),
            border: Border.all(color: color.withOpacity(0.25)),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: GoogleFonts.inter(
                    fontSize: 11.5,
                    color: AppColors.textDim,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5)),
            const SizedBox(height: 2),
            Text(value,
                style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}

class _ContactForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController msgCtrl;
  final bool sending;
  final bool sent;
  final VoidCallback onSend;

  const _ContactForm({
    required this.formKey,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.msgCtrl,
    required this.sending,
    required this.sent,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: sent
          ? _SuccessState()
          : Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Send a Message',
                      style: GoogleFonts.spaceGrotesk(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textWhite,
                          letterSpacing: -0.5)),
                  const SizedBox(height: 24),
                  _FormField(
                    ctrl: nameCtrl,
                    label: 'Your Name',
                    hint: 'John Doe',
                    icon: Icons.person_outline_rounded,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Name is required' : null,
                  ),
                  const SizedBox(height: 16),
                  _FormField(
                    ctrl: emailCtrl,
                    label: 'Email Address',
                    hint: 'john@example.com',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => v == null || !v.contains('@')
                        ? 'Valid email required'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  _FormField(
                    ctrl: msgCtrl,
                    label: 'Message',
                    hint: 'Tell me about your project...',
                    icon: Icons.message_outlined,
                    maxLines: 5,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Message is required' : null,
                  ),
                  const SizedBox(height: 28),
                  _SendButton(sending: sending, onTap: onSend),
                ],
              ),
            ),
    );
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;
  final String hint;
  final IconData icon;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _FormField({
    required this.ctrl,
    required this.label,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted)),
        const SizedBox(height: 8),
        TextFormField(
          controller: ctrl,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: GoogleFonts.inter(
              fontSize: 14, color: AppColors.textLight),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: maxLines == 1
                ? Icon(icon, color: AppColors.textDim, size: 18)
                : null,
          ),
        ),
      ],
    );
  }
}

class _SendButton extends StatefulWidget {
  final bool sending;
  final VoidCallback onTap;
  const _SendButton({required this.sending, required this.onTap});
  @override
  State<_SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<_SendButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.sending ? null : widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: AppColors.primaryGradient,
            boxShadow: _hovered
                ? [
                    BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 24,
                        spreadRadius: -4)
                  ]
                : null,
          ),
          child: Center(
            child: widget.sending
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2.5))
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Send Message',
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.bgDark)),
                      const SizedBox(width: 10),
                      const Icon(Icons.send_rounded,
                          size: 18, color: AppColors.bgDark),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _SuccessState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withOpacity(0.12),
            border: Border.all(
                color: AppColors.primary.withOpacity(0.35), width: 2),
          ),
          child: const Icon(Icons.check_rounded,
              color: AppColors.primary, size: 40),
        ),
        const SizedBox(height: 24),
        Text('Message Sent!',
            style: GoogleFonts.spaceGrotesk(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppColors.textWhite)),
        const SizedBox(height: 12),
        Text(
          'Thank you for reaching out.\nI\'ll get back to you within 24 hours!',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              fontSize: 15, color: AppColors.textMuted, height: 1.7),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
