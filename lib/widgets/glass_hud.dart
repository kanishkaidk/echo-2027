import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../models/game_state.dart';

class GlassHUD extends StatelessWidget {
  final GameMetrics metrics;
  final Duration animationDuration;

  const GlassHUD({
    Key? key,
    required this.metrics,
    this.animationDuration = const Duration(milliseconds: 800),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withAlpha((0.08 * 255).toInt()),
                Colors.white.withAlpha((0.04 * 255).toInt()),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: Colors.white.withAlpha((0.15 * 255).toInt()),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ECHO NETWORK STATUS',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 11,
                      letterSpacing: 2.5,
                      color: Colors.white.withAlpha((0.7 * 255).toInt()),
                    ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _MetricSlider(
                    label: 'MUTUAL AID',
                    value: metrics.mutualAid,
                    color: const Color(0xFF00FFCC), // Neon Mint
                    animationDuration: animationDuration,
                  ),
                  _MetricSlider(
                    label: 'ECO INDEX',
                    value: metrics.ecoIndex,
                    color: const Color(0xFF00D9FF), // Cyan
                    animationDuration: animationDuration,
                  ),
                  _MetricSlider(
                    label: 'FUNDS',
                    value: (metrics.funds % 100).toInt(),
                    color: const Color(0xFFFF006E), // Crimson
                    animationDuration: animationDuration,
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

class _MetricSlider extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  final Duration animationDuration;

  const _MetricSlider({
    required this.label,
    required this.value,
    required this.color,
    required this.animationDuration,
  });

  @override
  Widget build(BuildContext context) {
    final clampedValue = value.clamp(0, 100);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                letterSpacing: 1.5,
                color: Colors.white.withAlpha((0.5 * 255).toInt()),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: [
                  // Background bar
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha((0.1 * 255).toInt()),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  // Animated fill bar with inner glow
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: clampedValue / 100),
                    duration: animationDuration,
                    curve: Curves.easeOutQuad,
                    builder: (context, progress, child) {
                      return Container(
                        height: 6,
                        width: 200 * progress, // Adjust width based on parent
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: color.withAlpha((0.6 * 255).toInt()),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '$clampedValue%',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
