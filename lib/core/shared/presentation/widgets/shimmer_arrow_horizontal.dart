import 'package:flutter/material.dart';

class ShimmerArrowsHorizontal extends StatefulWidget {
  const ShimmerArrowsHorizontal({super.key});

  @override
  State<ShimmerArrowsHorizontal> createState() => _ShimmerArrowsHorizontalState();
}

class _ShimmerArrowsHorizontalState extends State<ShimmerArrowsHorizontal> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController.unbounded(vsync: this)..repeat(min: -0.5, max: 1.5, period: const Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Gradient _gradientLeft(double value) => LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: const [Colors.white10, Colors.white, Colors.white10],
        stops: const [0.0, 0.3, 1],
        transform: _SlideGradientTransformLeft(value),
      );

  Gradient _gradientRight(double value) => LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: const [Colors.white10, Colors.white, Colors.white10],
        stops: const [0.0, 0.3, 1],
        transform: _SlideGradientTransformRight(value),
      );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔹 sola bakan 3 ok
            ShaderMask(
              shaderCallback: (bounds) => _gradientLeft(_controller.value).createShader(bounds),
              blendMode: BlendMode.srcIn,
              child: const Row(
                children: [
                  Icon(Icons.arrow_back_ios_new, size: 20),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_back_ios_new, size: 20),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_back_ios_new, size: 20),
                ],
              ),
            ),
            const SizedBox(width: 32),

            // 🔹 sağa bakan 3 ok
            ShaderMask(
              shaderCallback: (bounds) => _gradientRight(_controller.value).createShader(bounds),
              blendMode: BlendMode.srcIn,
              child: const Row(
                children: [
                  Icon(Icons.arrow_forward_ios, size: 20),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, size: 20),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, size: 20),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SlideGradientTransformLeft extends GradientTransform {
  const _SlideGradientTransformLeft(this.percent);
  final double percent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) =>
      // sola kaydır
      Matrix4.translationValues(-bounds.width * percent, 0, 0);
}

class _SlideGradientTransformRight extends GradientTransform {
  const _SlideGradientTransformRight(this.percent);
  final double percent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) =>
      // sağa kaydır
      Matrix4.translationValues(bounds.width * percent, 0, 0);
}
