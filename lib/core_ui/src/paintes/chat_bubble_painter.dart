import 'package:flutter/material.dart';

class CustomChatBubble extends CustomPainter {
  CustomChatBubble({
    required this.color,
    required this.isOwn,
  });

  final Color color;
  final bool isOwn;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    Path paintBubbleTail() {
      Path path;
      if (!isOwn) {
        path = Path()
          ..moveTo(5, size.height - 5)
          ..quadraticBezierTo(-2, size.height, -10, size.height - 5)
          ..quadraticBezierTo(-1, size.height - 4, 0, size.height - 15);
      } else {
        path = Path()
          ..moveTo(size.width - 5, size.height - 5)
          ..quadraticBezierTo(
              size.width + 2, size.height, size.width + 12, size.height - 5)
          ..quadraticBezierTo(
              size.width + 1, size.height - 4, size.width, size.height - 15);
      }
      return path;
    }

    final RRect bubbleBody = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(16));
    final Path bubbleTail = paintBubbleTail();

    canvas.drawRRect(bubbleBody, paint);
    canvas.drawPath(bubbleTail, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
