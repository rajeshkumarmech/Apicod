import 'package:flutter/material.dart';

class SliderTooltip extends StatelessWidget {
  final double sliderValue;
  final double thumbWidth;

  const SliderTooltip({super.key, required this.sliderValue, required this.thumbWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 8, vertical: 4), // Reduced padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6), // Smaller border radius
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${sliderValue.toStringAsFixed(0)} Due',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 2),
        ],
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0) // Arrow tip (top center)
      ..lineTo(0, size.height) // Bottom left
      ..lineTo(size.width, size.height) // Bottom right
      ..close(); // Close path

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
