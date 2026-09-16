import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/app_colors.dart';

class SocialIconButton extends StatefulWidget {
  final dynamic icon;
  final String tooltip;
  final VoidCallback onTap;
  final Color? color;
  final double size;

  const SocialIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.color,
    this.size = 22,
  });

  @override
  State<SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<SocialIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? AppColors.primary;

    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          setState(() => _hovered = true);
          _controller.forward();
        },
        onExit: (_) {
          setState(() => _hovered = false);
          _controller.reverse();
        },
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedBuilder(
            animation: _scaleAnim,
            builder: (context, child) => Transform.scale(
              scale: _scaleAnim.value,
              child: child,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _hovered
                    ? color.withOpacity(0.15)
                    : AppColors.bgCard,
                border: Border.all(
                  color: _hovered ? color : AppColors.borderGlass,
                  width: 1.5,
                ),
                boxShadow: _hovered
                    ? [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: -3,
                        ),
                      ]
                    : null,
              ),
              child: widget.icon is IconData
                  ? Icon(
                      widget.icon,
                      color: _hovered ? color : AppColors.textMuted,
                      size: widget.size,
                    )
                  : FaIcon(
                      widget.icon,
                      color: _hovered ? color : AppColors.textMuted,
                      size: widget.size,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
