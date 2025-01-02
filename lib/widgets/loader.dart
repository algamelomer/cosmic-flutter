import 'package:flutter/material.dart';
import 'dart:math';

class CosmicLoader extends StatefulWidget {
  @override
  _CosmicLoaderState createState() => _CosmicLoaderState();
}

class _CosmicLoaderState extends State<CosmicLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Take the full size of the parent container
        final double size = min(constraints.maxWidth, constraints.maxHeight);

        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                painter: BackgroundCirclePainter(),
                size: Size(size, size), // Set to the available size
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    painter: BlurryGlowingArcPainter(progress: _controller.value),
                    size: Size(size, size), // Set to the available size
                  );
                },
              ),
              // Centered logo or text
              Image.asset("assets/img/logo.png")
            ],
          ),
        );
      },
    );
  }
}

// Background circle painter
class BackgroundCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey[800]!
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Glowing arc painter
class BlurryGlowingArcPainter extends CustomPainter {
  final double progress;

  BlurryGlowingArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;
    final Rect rect = Rect.fromCircle(center: center, radius: radius);
    final double startAngle = 2 * pi * progress;
    final double sweepAngle = 4 * pi / 3;

    // Outer glow
    Paint outerGlowPaint = Paint()
      ..color = Colors.cyanAccent.withOpacity(0.3)
      ..strokeWidth = 25.0
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20);
    canvas.drawArc(rect, startAngle, sweepAngle, false, outerGlowPaint);

    // Mid glow
    Paint midGlowPaint = Paint()
      ..color = Colors.cyanAccent.withOpacity(0.5)
      ..strokeWidth = 20.0
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawArc(rect, startAngle, sweepAngle, false, midGlowPaint);

    // Main arc
    Paint mainArcPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;
    canvas.drawArc(rect, startAngle, sweepAngle, false, mainArcPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
