import 'dart:math';

import 'package:findpairs/Models/Painters/ParticleModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class ParticlePainter extends CustomPainter{

  final double span;
  final List<ParticleModel> particles;

  ParticlePainter({@required this.span, @required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    particles.forEach((particle){
      particle.advance(
        height: size.height,
        span: span,
        stage: span > 0.4
      );
      Paint paint = Paint()
      ..color = particle.color.withOpacity(min(max(0.4 * (1-span)+1-span,0),1))
      ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(particle.left, particle.top),
        particle.sizeFactor*5*span,
        paint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}