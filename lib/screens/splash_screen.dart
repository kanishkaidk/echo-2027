import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const SplashScreen({super.key, required this.onComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late List<String> _bootLines;
  int _currentLineIndex = 0;

  @override
  void initState() {
    super.initState();
    _bootLines = [
      'BOOT_SEQUENCE: INITIALIZED...',
      'LOCAL_PROXY_SUBNET: ENCRYPTED...',
      'NEURAL_LINK: CALIBRATING...',
      'DATABASE_SYNC: COMPLETE...',
      'ECHOES_OF_2076: LIVE...',
      '',
      '> _',
    ];
    _startBootSequence();
  }

  void _startBootSequence() async {
    for (int i = 0; i < _bootLines.length; i++) {
      await Future.delayed(const Duration(milliseconds: 400));
      if (mounted) {
        setState(() => _currentLineIndex = i + 1);
      }
    }
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) {
      _slideUp();
    }
  }

  void _slideUp() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            FadeTransition(opacity: animation, child: Container()),
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050508),
      body: Stack(
        children: [
          // Subtle grid background
          CustomPaint(
            painter: _SplashGridPainter(),
            size: Size.infinite,
          ),

          // Boot text
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ECHOES_OF_2076',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 32,
                          letterSpacing: 4,
                          shadows: [
                            Shadow(
                              color: const Color(0xFF00FFCC).withAlpha((100)),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                  ),
                  const SizedBox(height: 48),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      _currentLineIndex,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          _bootLines[index],
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            color: const Color(0xFF00FFCC),
                            letterSpacing: 1,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),
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

class _SplashGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withAlpha((5))
      ..strokeWidth = 0.5;

    const spacing = 60.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
