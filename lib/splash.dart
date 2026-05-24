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
  late final Animation<double> _draw;
  late final Animation<double> _overlayFade;
  bool _done = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _draw = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 80,
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 20),
    ]).animate(_ctrl);

    _overlayFade = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 85),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 15,
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
          builder: (_, context) => Opacity(
            opacity: _overlayFade.value,
            child: ColoredBox(
              color: Colors.black,
              child: Center(
                child: CustomPaint(
                  size: const Size(120, 138.8),
                  painter: _ThreadsPainter(draw: _draw.value),
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
  final double draw;

  const _ThreadsPainter({required this.draw});

  static const double _vbW = 166.0;
  static const double _vbH = 192.0;

  // Cached metrics so we don't recompute every frame
  static List<PathMetric>? _outerMetrics;
  static List<PathMetric>? _innerMetrics;
  static double? _cachedOuterLen;
  static double? _cachedInnerLen;

  static Path get _logoFillPath {
    final p = Path()..fillType = PathFillType.evenOdd;
    p.moveTo(84.0664, 0.5);
    p.lineTo(85.375, 0.515625);
    p.cubicTo(112.756, 0.988837, 133.992, 10.345, 148.577, 28.2881);
    p.cubicTo(155.8, 37.1738, 161.137, 47.873, 164.566, 60.2881);
    p.lineTo(149.385, 64.3379);
    p.cubicTo(146.531, 54.1871, 142.245, 45.4518, 136.572, 38.4717);
    p.cubicTo(124.811, 24.0012, 107.101, 16.6112, 84.0166, 16.4404);
    p.lineTo(84.0088, 16.4404);
    p.cubicTo(61.0908, 16.6113, 43.6783, 23.9666, 32.3447, 38.374);
    p.cubicTo(21.7485, 51.8437, 16.309, 71.252, 16.1055, 95.9961);
    p.lineTo(16.1045, 95.9961);
    p.lineTo(16.1055, 96.0039);
    p.cubicTo(16.309, 120.748, 21.7495, 140.156, 32.3447, 153.626);
    p.cubicTo(43.6773, 168.034, 61.0916, 175.389, 84.0098, 175.559);
    p.lineTo(84.0166, 175.559);
    p.cubicTo(104.672, 175.407, 118.418, 170.487, 129.854, 159.062);
    p.cubicTo(142.939, 145.988, 142.707, 129.929, 138.507, 120.135);
    p.cubicTo(136.029, 114.354, 131.548, 109.564, 125.538, 105.938);
    p.lineTo(124.886, 105.544);
    p.lineTo(124.784, 106.3);
    p.cubicTo(123.347, 117.013, 120.096, 125.475, 114.987, 131.987);
    p.cubicTo(108.48, 140.282, 99.2387, 144.95, 87.4531, 145.849);
    p.lineTo(86.3047, 145.924);
    p.cubicTo(76.9654, 146.434, 67.9976, 144.18, 61.0508, 139.594);
    p.cubicTo(52.8453, 134.176, 48.0525, 125.896, 47.5391, 116.266);
    p.cubicTo(47.0326, 106.764, 50.5442, 98.6101, 57.1104, 92.6533);
    p.cubicTo(63.6848, 86.6892, 73.3507, 82.9041, 85.1738, 82.2236);
    p.cubicTo(93.5972, 81.7395, 101.469, 82.1206, 108.741, 83.3564);
    p.lineTo(109.432, 83.4746);
    p.lineTo(109.318, 82.7832);
    p.cubicTo(108.368, 76.9712, 106.473, 72.2839, 103.619, 68.8193);
    p.lineTo(103.34, 68.4873);
    p.cubicTo(99.1877, 63.6674, 92.803, 61.2382, 84.4609, 61.1846);
    p.lineTo(84.2285, 61.1846);
    p.cubicTo(77.6321, 61.1847, 68.619, 63.0018, 62.7471, 71.5342);
    p.lineTo(49.792, 62.6484);
    p.cubicTo(57.3832, 51.4194, 69.5653, 45.2452, 84.2217, 45.2451);
    p.lineTo(84.5586, 45.2451);
    p.lineTo(85.7158, 45.2637);
    p.cubicTo(97.5916, 45.5721, 107.05, 49.4609, 113.77, 56.4609);
    p.cubicTo(120.711, 63.6925, 124.783, 74.3007, 125.52, 87.8721);
    p.lineTo(125.536, 88.1816);
    p.lineTo(125.822, 88.3047);
    p.cubicTo(126.663, 88.6654, 127.496, 89.0433, 128.32, 89.4385);
    p.cubicTo(139.917, 95.0019, 148.371, 103.411, 152.801, 113.738);
    p.cubicTo(158.986, 128.165, 159.556, 151.683, 140.765, 170.457);
    p.cubicTo(126.383, 184.826, 108.926, 191.328, 84.0664, 191.5);
    p.lineTo(83.9609, 191.5);
    p.cubicTo(56.0048, 191.307, 34.5718, 181.906, 20.1807, 163.612);
    p.cubicTo(7.56478, 147.574, 0.932891, 125.318, 0.515625, 97.3965);
    p.lineTo(0.5, 96.0635);
    p.lineTo(0.5, 96.0078);
    p.lineTo(0.500977, 95.9395);
    p.lineTo(0.500977, 95.9355);
    p.cubicTo(0.723481, 67.3889, 7.36467, 44.6793, 20.1807, 28.3887);
    p.cubicTo(34.347, 10.38, 55.3365, 0.988868, 82.6553, 0.515625);
    p.lineTo(83.9609, 0.5);
    p.lineTo(84.0664, 0.5);
    p.moveTo(91.8711, 97.9678);
    p.cubicTo(89.9664, 97.9678, 88.0274, 98.0231, 86.0518, 98.1377);
    p.cubicTo(77.3984, 98.6364, 71.5623, 100.983, 67.9326, 104.211);
    p.cubicTo(64.2942, 107.447, 62.9149, 111.533, 63.1211, 115.398);
    p.cubicTo(63.3989, 120.62, 66.3681, 124.439, 70.5654, 126.857);
    p.cubicTo(74.6194, 129.193, 79.8356, 130.238, 84.9717, 130.03);
    p.lineTo(85.4678, 130.006);
    p.cubicTo(90.6275, 129.723, 96.2246, 128.565, 100.775, 124.287);
    p.cubicTo(105.325, 120.01, 108.746, 112.691, 109.74, 100.272);
    p.lineTo(109.775, 99.8379);
    p.lineTo(109.349, 99.7441);
    p.cubicTo(104.007, 98.5767, 98.1379, 97.9678, 91.8711, 97.9678);
    p.close();
    return p;
  }

  // Outer path — starts from the top-right tip
  static Path get _outerPath {
    final p = Path();
    p.moveTo(164.566, 60.2881);
    p.lineTo(149.385, 64.3379);
    p.cubicTo(146.531, 54.1871, 142.245, 45.4518, 136.572, 38.4717);
    p.cubicTo(124.811, 24.0012, 107.101, 16.6112, 84.0166, 16.4404);
    p.lineTo(84.0088, 16.4404);
    p.cubicTo(61.0908, 16.6113, 43.6783, 23.9666, 32.3447, 38.374);
    p.cubicTo(21.7485, 51.8437, 16.309, 71.252, 16.1055, 95.9961);
    p.lineTo(16.1045, 95.9961);
    p.lineTo(16.1055, 96.0039);
    p.cubicTo(16.309, 120.748, 21.7495, 140.156, 32.3447, 153.626);
    p.cubicTo(43.6773, 168.034, 61.0916, 175.389, 84.0098, 175.559);
    p.lineTo(84.0166, 175.559);
    p.cubicTo(104.672, 175.407, 118.418, 170.487, 129.854, 159.062);
    p.cubicTo(142.939, 145.988, 142.707, 129.929, 138.507, 120.135);
    p.cubicTo(136.029, 114.354, 131.548, 109.564, 125.538, 105.938);
    p.lineTo(124.886, 105.544);
    p.lineTo(124.784, 106.3);
    p.cubicTo(123.347, 117.013, 120.096, 125.475, 114.987, 131.987);
    p.cubicTo(108.48, 140.282, 99.2387, 144.95, 87.4531, 145.849);
    p.lineTo(86.3047, 145.924);
    p.cubicTo(76.9654, 146.434, 67.9976, 144.18, 61.0508, 139.594);
    p.cubicTo(52.8453, 134.176, 48.0525, 125.896, 47.5391, 116.266);
    p.cubicTo(47.0326, 106.764, 50.5442, 98.6101, 57.1104, 92.6533);
    p.cubicTo(63.6848, 86.6892, 73.3507, 82.9041, 85.1738, 82.2236);
    p.cubicTo(93.5972, 81.7395, 101.469, 82.1206, 108.741, 83.3564);
    p.lineTo(109.432, 83.4746);
    p.lineTo(109.318, 82.7832);
    p.cubicTo(108.368, 76.9712, 106.473, 72.2839, 103.619, 68.8193);
    p.lineTo(103.34, 68.4873);
    p.cubicTo(99.1877, 63.6674, 92.803, 61.2382, 84.4609, 61.1846);
    p.lineTo(84.2285, 61.1846);
    p.cubicTo(77.6321, 61.1847, 68.619, 63.0018, 62.7471, 71.5342);
    p.lineTo(49.792, 62.6484);
    p.cubicTo(57.3832, 51.4194, 69.5653, 45.2452, 84.2217, 45.2451);
    p.lineTo(84.5586, 45.2451);
    p.lineTo(85.7158, 45.2637);
    p.cubicTo(97.5916, 45.5721, 107.05, 49.4609, 113.77, 56.4609);
    p.cubicTo(120.711, 63.6925, 124.783, 74.3007, 125.52, 87.8721);
    p.lineTo(125.536, 88.1816);
    p.lineTo(125.822, 88.3047);
    p.cubicTo(126.663, 88.6654, 127.496, 89.0433, 128.32, 89.4385);
    p.cubicTo(139.917, 95.0019, 148.371, 103.411, 152.801, 113.738);
    p.cubicTo(158.986, 128.165, 159.556, 151.683, 140.765, 170.457);
    p.cubicTo(126.383, 184.826, 108.926, 191.328, 84.0664, 191.5);
    p.lineTo(83.9609, 191.5);
    p.cubicTo(56.0048, 191.307, 34.5718, 181.906, 20.1807, 163.612);
    p.cubicTo(7.56478, 147.574, 0.932891, 125.318, 0.515625, 97.3965);
    p.lineTo(0.5, 96.0635);
    p.lineTo(0.5, 96.0078);
    p.lineTo(0.500977, 95.9395);
    p.lineTo(0.500977, 95.9355);
    p.cubicTo(0.723481, 67.3889, 7.36467, 44.6793, 20.1807, 28.3887);
    p.cubicTo(34.347, 10.38, 55.3365, 0.988868, 82.6553, 0.515625);
    p.lineTo(83.9609, 0.5);
    p.lineTo(84.0664, 0.5);
    p.lineTo(85.375, 0.515625);
    p.cubicTo(112.756, 0.988837, 133.992, 10.345, 148.577, 28.2881);
    p.cubicTo(155.8, 37.1738, 161.137, 47.873, 164.566, 60.2881);
    return p;
  }

  // Inner path — completely separate, drawn only after outer is 100% done
  static Path get _innerPath {
    final p = Path();
    p.moveTo(91.8711, 97.9678);
    p.cubicTo(89.9664, 97.9678, 88.0274, 98.0231, 86.0518, 98.1377);
    p.cubicTo(77.3984, 98.6364, 71.5623, 100.983, 67.9326, 104.211);
    p.cubicTo(64.2942, 107.447, 62.9149, 111.533, 63.1211, 115.398);
    p.cubicTo(63.3989, 120.62, 66.3681, 124.439, 70.5654, 126.857);
    p.cubicTo(74.6194, 129.193, 79.8356, 130.238, 84.9717, 130.03);
    p.lineTo(85.4678, 130.006);
    p.cubicTo(90.6275, 129.723, 96.2246, 128.565, 100.775, 124.287);
    p.cubicTo(105.325, 120.01, 108.746, 112.691, 109.74, 100.272);
    p.lineTo(109.775, 99.8379);
    p.lineTo(109.349, 99.7441);
    p.cubicTo(104.007, 98.5767, 98.1379, 97.9678, 91.8711, 97.9678);
    p.close();
    return p;
  }

  void _ensureMetrics() {
    if (_outerMetrics != null) return;
    _outerMetrics = _outerPath.computeMetrics().toList();
    _innerMetrics = _innerPath.computeMetrics().toList();
    _cachedOuterLen = _outerMetrics!.fold(0.0, (s, m) => s! + m.length);
    _cachedInnerLen = _innerMetrics!.fold(0.0, (s, m) => s! + m.length);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (draw <= 0.0) return;

    _ensureMetrics();

    final lenOuter = _cachedOuterLen!;
    final lenInner = _cachedInnerLen!;
    final total = lenOuter + lenInner;

    final scaleX = size.width / _vbW;
    final scaleY = size.height / _vbH;

    canvas.save();
    canvas.scale(scaleX, scaleY);
    canvas.clipPath(_logoFillPath);

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    final drawn = draw * total;

    // Draw outer — fully, up to how much progress we have
    final drawOuter = drawn.clamp(0.0, lenOuter);
    double remaining = drawOuter;
    for (final m in _outerMetrics!) {
      final take = remaining.clamp(0.0, m.length);
      if (take > 0) canvas.drawPath(m.extractPath(0, take), paint);
      remaining -= take;
      if (remaining <= 0) break;
    }

    // Draw inner — only starts after outer is 100% complete
    if (drawn > lenOuter) {
      final drawInner = (drawn - lenOuter).clamp(0.0, lenInner);
      double rem = drawInner;
      for (final m in _innerMetrics!) {
        final take = rem.clamp(0.0, m.length);
        if (take > 0) canvas.drawPath(m.extractPath(0, take), paint);
        rem -= take;
        if (rem <= 0) break;
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ThreadsPainter old) => old.draw != draw;
}
