import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class ParticleBackground extends StatefulWidget {
  final Widget child;
  const ParticleBackground({super.key, required this.child});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;
  final int _particleCount = 50;

  @override
  void initState() {
    super.initState();
    _particles = List.generate(_particleCount, (_) => Particle.random());
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              for (final p in _particles) {
                p.update();
              }
              return CustomPaint(
                painter: _ParticlePainter(_particles),
              );
            },
          ),
        ),
        widget.child,
      ],
    );
  }
}

class Particle {
  double x, y, vx, vy, radius, opacity;
  Color color;

  Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.opacity,
    required this.color,
  });

  factory Particle.random() {
    final rng = math.Random();
    final colors = [AppColors.primary, AppColors.secondary, AppColors.accent];
    return Particle(
      x: rng.nextDouble(),
      y: rng.nextDouble(),
      vx: (rng.nextDouble() - 0.5) * 0.0008,
      vy: (rng.nextDouble() - 0.5) * 0.0008,
      radius: rng.nextDouble() * 2.5 + 1.0,
      opacity: rng.nextDouble() * 0.5 + 0.15,
      color: colors[rng.nextInt(colors.length)],
    );
  }

  void update() {
    x += vx;
    y += vy;
    if (x < 0) x = 1;
    if (x > 1) x = 0;
    if (y < 0) y = 1;
    if (y > 1) y = 0;
  }
}

class _ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  _ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < particles.length; i++) {
      final p = particles[i];
      final px = p.x * size.width;
      final py = p.y * size.height;

      // Draw particle
      final paint = Paint()
        ..color = p.color.withOpacity(p.opacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
      canvas.drawCircle(Offset(px, py), p.radius, paint);

      // Draw connections
      for (int j = i + 1; j < particles.length; j++) {
        final q = particles[j];
        final qx = q.x * size.width;
        final qy = q.y * size.height;
        final dist = math.sqrt(
          math.pow(px - qx, 2) + math.pow(py - qy, 2),
        );
        if (dist < 120) {
          final linePaint = Paint()
            ..color = AppColors.primary.withOpacity(
              (1 - dist / 120) * 0.12,
            )
            ..strokeWidth = 0.8;
          canvas.drawLine(Offset(px, py), Offset(qx, qy), linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter oldDelegate) => true;
}
