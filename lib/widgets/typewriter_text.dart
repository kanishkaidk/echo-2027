import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration charDuration;
  final Curve curve;
  final VoidCallback? onComplete;

  const TypewriterText({
    Key? key,
    required this.text,
    this.style,
    this.charDuration = const Duration(milliseconds: 30),
    this.curve = Curves.linear,
    this.onComplete,
  }) : super(key: key);

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  int _displayedCharCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      duration: Duration(
        milliseconds:
            widget.charDuration.inMilliseconds * widget.text.length,
      ),
      vsync: this,
    );

    // Drive character count updates
    _controller.addListener(() {
      final progress = _controller.value; // 0.0 to 1.0
      final newCharCount =
          (progress * widget.text.length).toInt().clamp(0, widget.text.length);

      if (newCharCount != _displayedCharCount) {
        setState(() {
          _displayedCharCount = newCharCount;
        });
      }
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });

    _controller.forward();
  }

  @override
  void didUpdateWidget(TypewriterText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _controller.dispose();
      _displayedCharCount = 0;
      _initializeAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayText = widget.text.substring(0, _displayedCharCount);
    final cursorVisible = _controller.isAnimating ||
        (_displayedCharCount < widget.text.length &&
            (_controller.value * 1000).toInt() % 600 < 300);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: displayText,
            style: widget.style ??
                DefaultTextStyle.of(context).style.copyWith(
                      color: Colors.white.withAlpha((0.95 * 255).toInt()),
                      height: 1.6,
                    ),
          ),
          if (_controller.isAnimating || _displayedCharCount < widget.text.length)
            TextSpan(
              text: cursorVisible ? '▌' : '',
              style: (widget.style ?? DefaultTextStyle.of(context).style)
                  .copyWith(
                color: const Color(0xFF00FFCC),
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
