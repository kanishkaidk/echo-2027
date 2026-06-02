import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onResetGame;

  const SettingsScreen({
    super.key,
    required this.onBack,
    required this.onResetGame,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _glitchEffectEnabled = true;
  double _typewriterSpeed = 1.0;
  bool _soundEnabled = true;

  void _showResetConfirm() {
    showDialog(
      context: context,
      builder: (context) => _ConfirmDialog(
        title: 'SYSTEM CACHE WIPE',
        message: 'This will reset all campaign progression to baseline zero.',
        onConfirm: () {
          Navigator.pop(context);
          widget.onResetGame();
        },
        isDangerous: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050508),
      body: Stack(
        children: [
          CustomPaint(
            painter: _GridPainter(),
            size: Size.infinite,
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SYSTEM SETTINGS',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(fontSize: 24),
                      ),
                      GestureDetector(
                        onTap: widget.onBack,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white.withAlpha((50)),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white.withAlpha((150)),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Display Settings
                  Text(
                    'DISPLAY & RENDERING',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 12,
                          letterSpacing: 2,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _SettingToggle(
                    label: 'GLITCH EFFECT',
                    description: 'Toggles terminal scanline filter effects',
                    value: _glitchEffectEnabled,
                    onChanged: (val) =>
                        setState(() => _glitchEffectEnabled = val),
                  ),
                  const SizedBox(height: 20),

                  // Audio Settings
                  Text(
                    'AUDIO SETTINGS',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 12,
                          letterSpacing: 2,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _SettingToggle(
                    label: 'SOUND EFFECTS',
                    description: 'Enable/disable game audio feedback',
                    value: _soundEnabled,
                    onChanged: (val) => setState(() => _soundEnabled = val),
                  ),
                  const SizedBox(height: 20),

                  // Typewriter Speed
                  Text(
                    'TEXT RENDERING',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 12,
                          letterSpacing: 2,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withAlpha((8)),
                          Colors.white.withAlpha((2)),
                        ],
                      ),
                      border: Border.all(
                        color: Colors.white.withAlpha((30)),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'TYPEWRITER SPEED',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withAlpha((150)),
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Set custom text readout speed',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white.withAlpha((100)),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              _typewriterSpeed == 0.5
                                  ? 'SLOW'
                                  : _typewriterSpeed == 1.0
                                      ? 'NORMAL'
                                      : 'INSTANT',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF00FFCC),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Slider(
                          value: _typewriterSpeed,
                          min: 0.5,
                          max: 2.0,
                          divisions: 2,
                          onChanged: (val) =>
                              setState(() => _typewriterSpeed = val),
                          activeColor: const Color(0xFF00FFCC),
                          inactiveColor: Colors.white.withAlpha((30)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Danger Zone
                  Text(
                    'DANGER ZONE',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 12,
                          letterSpacing: 2,
                          color: const Color(0xFFFF006E),
                        ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _showResetConfirm,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFFF006E).withAlpha((15)),
                            const Color(0xFFFF006E).withAlpha((5)),
                          ],
                        ),
                        border: Border.all(
                          color: const Color(0xFFFF006E).withAlpha((60)),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: const Color(0xFFFF006E),
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SYSTEM CACHE WIPE',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFFFF006E),
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Flushes all progress and resets to baseline',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white.withAlpha((100)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white.withAlpha((100)),
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Info
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withAlpha((20)),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ECHOES OF 2076',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white.withAlpha((120)),
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'v1.0.0 | Delhi 2076 Neo-Noir',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white.withAlpha((100)),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'A brutalist cyberpunk narrative experience',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white.withAlpha((80)),
                            height: 1.4,
                          ),
                        ),
                      ],
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

class _SettingToggle extends StatefulWidget {
  final String label;
  final String description;
  final bool value;
  final Function(bool) onChanged;

  const _SettingToggle({
    required this.label,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  @override
  State<_SettingToggle> createState() => _SettingToggleState();
}

class _SettingToggleState extends State<_SettingToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _toggleController;

  @override
  void initState() {
    super.initState();
    _toggleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    if (widget.value) _toggleController.forward();
  }

  @override
  void didUpdateWidget(_SettingToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value && !oldWidget.value) {
      _toggleController.forward();
    } else if (!widget.value && oldWidget.value) {
      _toggleController.reverse();
    }
  }

  @override
  void dispose() {
    _toggleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withAlpha((8)),
              Colors.white.withAlpha((2)),
            ],
          ),
          border: Border.all(
            color: Colors.white.withAlpha((30)),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: Colors.white.withAlpha((180)),
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withAlpha((100)),
                  ),
                ),
              ],
            ),
            ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0)
                  .animate(_toggleController),
              child: Container(
                width: 48,
                height: 28,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: widget.value
                        ? [
                            const Color(0xFF00FFCC),
                            const Color(0xFF00D9FF),
                          ]
                        : [
                            Colors.white.withAlpha((20)),
                            Colors.white.withAlpha((10)),
                          ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: widget.value
                        ? const Color(0xFF00FFCC).withAlpha((200))
                        : Colors.white.withAlpha((40)),
                  ),
                ),
                child: Row(
                  children: [
                    AnimatedAlign(
                      alignment: widget.value
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: widget.value
                              ? Colors.white
                              : Colors.white.withAlpha((80)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;
  final bool isDangerous;

  const _ConfirmDialog({
    required this.title,
    required this.message,
    required this.onConfirm,
    this.isDangerous = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF0A0A10),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF0A0A10),
              const Color(0xFF050508),
            ],
          ),
          border: Border.all(
            color: isDangerous
                ? const Color(0xFFFF006E).withAlpha((100))
                : const Color(0xFF00FFCC).withAlpha((100)),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: isDangerous ? const Color(0xFFFF006E) : const Color(0xFF00FFCC),
                letterSpacing: 2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withAlpha((180)),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white.withAlpha((50)),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'CANCEL',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          color: Colors.white.withAlpha((150)),
                          letterSpacing: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: onConfirm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            isDangerous
                                ? const Color(0xFFFF006E)
                                : const Color(0xFF00FFCC),
                            isDangerous
                                ? const Color(0xFFFF006E)
                                    .withAlpha((200))
                                : const Color(0xFF00D9FF),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'CONFIRM',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF050508),
                          letterSpacing: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withAlpha((8))
      ..strokeWidth = 0.5;

    const spacing = 50.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
