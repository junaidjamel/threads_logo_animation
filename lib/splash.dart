import 'dart:ui';

import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  final Widget child;
  const SplashView({super.key, required this.child});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _progress;
  late final Animation<double> _overlayFade;

  bool _done = false;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    // 0.00→0.39 : draw in       (easeInOut — natural pen feel)
    // 0.39→0.68 : hold full
    // 0.68→0.95 : undraw        (easeInQuart — fast snap away)
    // 0.95→1.00 : overlay fades
    _progress = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 39,
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 29),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeInQuart)),
        weight: 27,
      ),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 5),
    ]).animate(_ctrl);

    _overlayFade = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 95),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 5,
      ),
    ]).animate(_ctrl);

    _ctrl.forward().then((_) {
      if (mounted) setState(() => _done = true);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_done) return widget.child;

    return Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        AnimatedBuilder(
          animation: _ctrl,
          builder: (_, __) => Opacity(
            opacity: _overlayFade.value,
            child: ColoredBox(
              color: Colors.black,
              child: Center(
                child: CustomPaint(
                  size: const Size(96, 96),
                  painter: _ThreadsPainter(progress: _progress.value),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ThreadsPainter extends CustomPainter {
  final double progress; // 0 = nothing drawn, 1 = full logo

  const _ThreadsPainter({required this.progress});

  static const double _vb = 192.0;

  // Stroke width in viewbox units — tune between 24–28 to match logo weight
  static const double _sw = 26.0;

  static Path? _mainCache;
  static Path? _ovalCache;

  // Centerline of the main @ spiral.
  // Derived from the exact SVG fill path (threads_dark.svg, viewBox 0 0 192 192).
  // Traced down the middle of each stroke segment.
  // Order: serif tail tip → outer loop CCW → spiral inward → end near inner counter.
  static Path get _mainPath {
    if (_mainCache != null) return _mainCache!;
    final p = Path();
    p.moveTo(157, 63); // serif tail tip (right side, mid-height)
    p.cubicTo(165, 52, 167, 37, 157, 24); // tail hook curling up-right
    p.cubicTo(147, 11, 124, 5, 97, 5); // top sweep left
    p.cubicTo(70, 5, 48, 15, 33, 33); // top-left descent
    p.cubicTo(18, 51, 12, 72, 12, 96); // left side down
    p.cubicTo(12, 120, 18, 141, 33, 158); // bottom-left sweep
    p.cubicTo(48, 176, 70, 186, 97, 186); // bottom across right
    p.cubicTo(122, 186, 141, 178, 153, 165); // up right outer edge
    p.cubicTo(166, 151, 169, 132, 164, 113); // inner top-right spiral
    p.cubicTo(159, 94, 148, 81, 133, 74); // spiral inward
    p.cubicTo(119, 67, 103, 65, 88, 67); // end near inner counter top
    return _mainCache = p;
  }

  // Centerline of the inner counter — a closed oval.
  // The counter sits roughly centered at (97, 108).
  static Path get _ovalPath {
    if (_ovalCache != null) return _ovalCache!;
    final p = Path();
    p.moveTo(121, 108);
    p.cubicTo(121, 94, 111, 86, 97, 86); // top-right → top-left
    p.cubicTo(83, 86, 72, 94, 72, 108); // top-left → bottom-left
    p.cubicTo(72, 122, 83, 130, 97, 130); // bottom-left → bottom-right
    p.cubicTo(111, 130, 121, 122, 121, 108); // bottom-right → close
    p.close();
    return _ovalCache = p;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0.0) return;

    final scale = size.width / _vb;
    canvas.save();
    canvas.scale(scale, scale);

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = _sw
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    // Compute lengths once (Flutter caches PathMetrics internally)
    final mainMetrics = _mainPath.computeMetrics().toList();
    final ovalMetrics = _ovalPath.computeMetrics().toList();

    final mainLen = mainMetrics.fold<double>(0, (s, m) => s + m.length);
    final ovalLen = ovalMetrics.fold<double>(0, (s, m) => s + m.length);
    final totalLen = mainLen + ovalLen;

    final drawLen = progress * totalLen;

    // Draw main path up to drawLen
    _drawMetrics(canvas, mainMetrics, drawLen, paint);

    // Draw oval only after main is fully drawn
    if (drawLen > mainLen) {
      _drawMetrics(canvas, ovalMetrics, drawLen - mainLen, paint);
    }

    canvas.restore();
  }

  void _drawMetrics(
    Canvas canvas,
    List<PathMetric> metrics,
    double budget,
    Paint paint,
  ) {
    double consumed = 0;
    for (final m in metrics) {
      if (budget <= 0) break;
      final take = budget.clamp(0.0, m.length);
      if (take > 0) {
        canvas.drawPath(m.extractPath(0, take), paint);
      }
      consumed += m.length;
      budget -= m.length;
    }
  }

  @override
  bool shouldRepaint(covariant _ThreadsPainter old) => old.progress != progress;
}
